import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _apiKeyController = TextEditingController();
  final _storage = const FlutterSecureStorage();
  bool _isLoading = true;
  bool _isAppLocked = false;
  bool _hasExistingKey = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final key = await _storage.read(key: 'gemini_api_key');
    final lockedStr = await _storage.read(key: 'is_app_locked');
    setState(() {
      // Never put the key into the field — just track whether one exists
      _hasExistingKey = (key != null && key.isNotEmpty);
      _isAppLocked = lockedStr == 'true';
      _isLoading = false;
    });
  }

  Future<void> _saveApiKey() async {
    final newKey = _apiKeyController.text.trim();
    if (newKey.isEmpty) {
      // Nothing typed — nothing to save
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a new API key first.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    await _storage.write(key: 'gemini_api_key', value: newKey);
    _apiKeyController.clear();
    setState(() => _hasExistingKey = true);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('API Key updated successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  Future<void> _toggleAppLock(bool value) async {
    await _storage.write(key: 'is_app_locked', value: value.toString());
    setState(() {
      _isAppLocked = value;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(value ? '🔒 App Lock Enabled' : '🔓 App Lock Disabled'),
          backgroundColor: value ? AppColors.primary : AppColors.textSecondary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Settings',
            style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Security Section ──────────────────────────
                  _sectionHeader(Icons.security_rounded, 'Security'),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: SwitchListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      secondary: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: (_isAppLocked
                                  ? AppColors.primary
                                  : AppColors.textSecondary)
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _isAppLocked
                              ? Icons.lock_rounded
                              : Icons.lock_open_rounded,
                          color: _isAppLocked
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                      ),
                      title: const Text(
                        'App Lock',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary),
                      ),
                      subtitle: Text(
                        _isAppLocked
                            ? 'Biometric / PIN required on launch'
                            : 'No authentication on launch',
                        style: TextStyle(
                            fontSize: 13, color: AppColors.textSecondary),
                      ),
                      activeThumbColor: AppColors.primary,
                      value: _isAppLocked,
                      onChanged: _toggleAppLock,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // ── API Key Section ───────────────────────────
                  _sectionHeader(Icons.vpn_key_rounded, 'Gemini API Key'),
                  const SizedBox(height: 12),
                  const Text(
                    'Update your Gemini API key here. This key is stored securely and never shared.',
                    style:
                        TextStyle(fontSize: 14, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  if (_hasExistingKey)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            'An API key is already saved securely.',
                            style: TextStyle(fontSize: 13, color: AppColors.success),
                          ),
                        ],
                      ),
                    ),
                  TextField(
                    controller: _apiKeyController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter new API Key to replace existing',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: AppColors.primary.withValues(alpha: 0.3)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: AppColors.primary.withValues(alpha: 0.3)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: AppColors.primary, width: 2),
                      ),
                      prefixIcon:
                          const Icon(Icons.vpn_key_outlined, color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _saveApiKey,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Save Key',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textLight),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _sectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
