import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/helpers/navigator/app_navigator.dart';
import 'package:other_screens/data/music/source/audio_service.dart';
import 'package:other_screens/presentation/main/pages/home_page.dart';
import 'package:other_screens/presentation/profile/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Logger _log = Logger('settings_page.dart');

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late AudioService _audioService;
  bool _isSoundEnabled = true;
  static const String _soundPreferenceKey = 'sound_enabled';

  @override
  void initState() {
    super.initState();
    _audioService = AudioService();
    _loadSoundPreference();
  }

  Future<void> _loadSoundPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isSoundEnabled = prefs.getBool(_soundPreferenceKey) ?? true;
    });
  }

  Future<void> _toggleSound(bool value) async {
    setState(() {
      _isSoundEnabled = value;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_soundPreferenceKey, value);

    if (value) {
      await _audioService.initialize();
      await _audioService.play();
    } else {
      await _audioService.pause();
    }

    _log.info('Sound ${value ? 'enabled' : 'disabled'}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: scaffoldBgColor,
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            AppNavigator.pushReplacement(context, ProfilePage());
          },
        ),
        title: const Text(
          "Settings",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Audio Settings'),
          _buildSettingTile(
            title: 'Background Music',
            subtitle: 'Enable or disable app music',
            icon: Icons.music_note_rounded,
            trailing: Switch(
              value: _isSoundEnabled,
              onChanged: _toggleSound,
              activeColor: seedColor,
              activeTrackColor: seedColorPalette.shade200,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: seedColorPalette.shade700,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget trailing,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: seedColor.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: seedColorPalette.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: seedColor),
        ),
        title: Text(title, style: AppTextStyles.h3),
        subtitle: Text(subtitle, style: AppTextStyles.body),
        trailing: trailing,
      ),
    );
  }
}
