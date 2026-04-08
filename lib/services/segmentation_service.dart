import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class SegmentationResult {
  final Uint8List? maskBytes;
  final bool isWoundDetected;

  SegmentationResult({
    this.maskBytes,
    required this.isWoundDetected,
  });
}

/// Service to handle TFLite model loading and inference
class SegmentationService {
  Interpreter? _interpreter;
  List<int> _inputShape = [1, 256, 256, 3];
  List<int> _outputShape = [1, 256, 256, 1];
  TensorType _inputType = TensorType.float32;
  TensorType _outputType = TensorType.float32;

  /// Initialize the TFLite interpreter
  Future<void> loadModel() async {
    try {
      final options = InterpreterOptions();
      // Use GPU delegate if available (optional, keeping it simple for now)
      // if (Platform.isAndroid) options.addDelegate(GpuDelegateV2());
      
      _interpreter = await Interpreter.fromAsset(
        'assets/models/pyramidnet.tflite',
        options: options,
      );
      debugPrint('Model loaded successfully');
      
      // Get input tensor details
      final inputTensor = _interpreter!.getInputTensor(0);
      _inputShape = inputTensor.shape;
      _inputType = inputTensor.type;
      debugPrint('Input: shape=$_inputShape, type=$_inputType');

      // Get output tensor details
      final outputTensor = _interpreter!.getOutputTensor(0);
      _outputShape = outputTensor.shape;
      _outputType = outputTensor.type;
      debugPrint('Output: shape=$_outputShape, type=$_outputType');

    } catch (e) {
      debugPrint('Error loading model: $e');
      rethrow;
    }
  }

  /// Run segmentation on the given image file
  Future<SegmentationResult> segmentImage(File imageFile) async {
    if (_interpreter == null) {
      await loadModel();
    }

    try {
      // 1. Read and decode image
      final imageBytes = await imageFile.readAsBytes();
      var decodedImage = img.decodeImage(imageBytes);
      
      if (decodedImage == null) {
        throw Exception('Failed to decode image');
      }

      // 2. Handle Orientation (Crucial for mobile photos)
      decodedImage = img.bakeOrientation(decodedImage);

      // 3. Preprocess: Resize to model input size dynamically
      // Determine layout NCHW ([1, 3, H, W]) vs NHWC ([1, H, W, 3])
      int inputHeight = 256;
      int inputWidth = 256;
      bool isNCHW = false;

      if (_inputShape.length == 4) {
        if (_inputShape[1] == 3) {
          // NCHW
          isNCHW = true;
          inputHeight = _inputShape[2];
          inputWidth = _inputShape[3];
        } else {
          // NHWC (Default)
          inputHeight = _inputShape[1];
          inputWidth = _inputShape[2];
        }
      }
      debugPrint('Detected Layout: ${isNCHW ? "NCHW" : "NHWC"}, Size: ${inputWidth}x$inputHeight');

      final resizedImage = img.copyResize(
        decodedImage, 
        width: inputWidth, 
        height: inputHeight,
        interpolation: img.Interpolation.linear
      );

      // 4. Prepare input tensor
      var input = _prepareInput(resizedImage, inputHeight, inputWidth, isNCHW);

      // 5. Prepare output tensor
      final outputBuffer = List.filled(
        _outputShape.reduce((a, b) => a * b), 
        _outputType == TensorType.float32 ? 0.0 : 0
      ).reshape(_outputShape);

      // 6. Run inference
      _interpreter!.run(input, outputBuffer);

      // 7. Postprocess: Create mask image
      // We pass the layout info if we need to decode NCHW output too, 
      // but for now let's assume output is [1, H, W, 1] or similar.
      // If output is NCHW [1, Classes, H, W], we might need logic there too.
      // Let's safe check output shape.
      return _postProcessOutput(outputBuffer, inputWidth, inputHeight, decodedImage.width, decodedImage.height);

    } catch (e) {
      debugPrint('Error during segmentation: $e');
      throw Exception(e.toString()); // Rethrow to show in UI
    }
  }

  /// Prepare input based on tensor type and layout
  Object _prepareInput(img.Image image, int height, int width, bool isNCHW) {
    if (isNCHW) {
        // [Batch, Channels, Height, Width]
        // Three separate matrices for R, G, B
        return List.generate(1, (b) => [
            // Red Channel
            List.generate(height, (y) => List.generate(width, (x) {
                final pixel = image.getPixel(x, y);
                return _normalize(pixel.r);
            })),
            // Green Channel
            List.generate(height, (y) => List.generate(width, (x) {
                final pixel = image.getPixel(x, y);
                return _normalize(pixel.g);
            })),
            // Blue Channel
            List.generate(height, (y) => List.generate(width, (x) {
                final pixel = image.getPixel(x, y);
                return _normalize(pixel.b);
            })),
        ]);
    } else {
        // [Batch, Height, Width, Channels]
        return List.generate(1, (b) => 
          List.generate(height, (y) => 
            List.generate(width, (x) {
              final pixel = image.getPixel(x, y);
              return [
                  _normalize(pixel.r),
                  _normalize(pixel.g),
                  _normalize(pixel.b),
              ];
            })
          )
        );
    }
  }

  dynamic _normalize(num channelValue) {
      if (_inputType == TensorType.float32) {
          return channelValue / 255.0;
      } else {
          return channelValue.toInt();
      }
  }

  /// Convert model output to visual mask
  SegmentationResult _postProcessOutput(dynamic outputBuffer, int modelWidth, int modelHeight, int targetWidth, int targetHeight) {
    // 1. Construct mask at model resolution (e.g., 256x256)
    // IMPORTANT: numChannels: 4 is required for RGBA transparency. Default is usually 3 (RGB).
    final maskImage = img.Image(width: modelWidth, height: modelHeight, numChannels: 4);
    final outputTensor = outputBuffer[0] as List<dynamic>; // [Height, Width, Channels]
    int woundPixelCount = 0;

    for (var y = 0; y < modelHeight; y++) {
      for (var x = 0; x < modelWidth; x++) {
        // Accessing the first channel of output
        dynamic value = outputTensor[y][x][0]; 
        
        bool isWound = false;
        // Simple thresholding for binary mask
        // Inverting logic based on user feedback (background was being highlighted)
        if (_outputType == TensorType.float32) {
          isWound = (value as double) < 0.5;
        } else {
          // Assuming Uint8 mask
          // Previously > 0 highlighted background, so now we check for 0
          isWound = (value as num) == 0;
        }

        if (isWound) {
           maskImage.setPixelRgba(x, y, 255, 0, 0, 150); // Red overlay
           woundPixelCount++;
        } else {
           maskImage.setPixelRgba(x, y, 0, 0, 0, 0); // Transparent
        }
      }
    }
    
    // 2. Resize mask to original image resolution to ensure perfect alignment
    final resizedMask = img.copyResize(
      maskImage, 
      width: targetWidth, 
      height: targetHeight,
      interpolation: img.Interpolation.linear,
    );
    

    
    // Count red pixels to decide if wound is detected
    // We can do this on the smaller maskImage for efficiency, or the resized one.
    // Doing it during the loop above is most efficient.
    
    return SegmentationResult(
      maskBytes: Uint8List.fromList(img.encodePng(resizedMask)),
      isWoundDetected: woundPixelCount > 10, // minimal threshold to avoid noise
    );
  }
  
  void dispose() {
    _interpreter?.close();
  }
}
