import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF120B22),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A102F),
        title: const Text('إعدادات التطبيق ⚙️', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'الإعدادات العامة',
            style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 10),
          _buildSettingItem(
            icon: Icons.notifications_active,
            title: 'إشعارات البث والمراسلة',
            trailing: Switch(
              value: true,
              activeColor: Colors.pink,
              onChanged: (val) {},
            ),
          ),
          _buildSettingItem(
            icon: Icons.language,
            title: 'لغة التطبيق',
            subtitle: 'العربية',
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.security,
            title: 'الخصوصية والأمان',
            onTap: () {},
          ),
          const SizedBox(height: 20),
          const Text(
            'حول التطبيق',
            style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 10),
          _buildSettingItem(
            icon: Icons.info,
            title: 'شروط الاستخدام',
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.help_outline,
            title: 'الدعم الفني والاتصال بنا',
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.system_update,
            title: 'إصدار التطبيق',
            subtitle: 'v1.0.0+1',
            onTap: () {},
          ),
          const SizedBox(height: 30),
          // زر تسجيل الخروج
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.withOpacity(0.2),
              foregroundColor: Colors.redAccent,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(color: Colors.redAccent),
              ),
            ),
            onPressed: () {
              // تسجيل الخروج
            },
            icon: const Icon(Icons.logout),
            label: const Text('تسجيل الخروج من الحساب', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A102F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.pinkAccent),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 12)) : null,
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 16),
        onTap: onTap,
      ),
    );
  }
}
