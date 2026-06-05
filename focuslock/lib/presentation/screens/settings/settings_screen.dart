import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../widgets/common/app_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _reduceMotion = false;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _buildProfileHeader(),
          const SizedBox(height: AppSpacing.xl),
          
          _buildSystemHealthCard(),
          const SizedBox(height: AppSpacing.md),
          
          _buildPermissionsDashboard(),
          const SizedBox(height: AppSpacing.xl),
          
          const Text('Preferences', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)),
          const SizedBox(height: AppSpacing.sm),
          SwitchListTile(
            title: const Text('Reduce Motion'),
            subtitle: const Text('Disables non-essential animations'),
            value: _reduceMotion,
            onChanged: (val) => setState(() => _reduceMotion = val),
            contentPadding: EdgeInsets.zero,
          ),
          SwitchListTile(
            title: const Text('Focus Reminders'),
            value: _notifications,
            onChanged: (val) => setState(() => _notifications = val),
            contentPadding: EdgeInsets.zero,
          ),
          const Divider(),
          
          const Text('Data & Privacy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)),
          const SizedBox(height: AppSpacing.sm),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.cloud_download),
            title: const Text('Backup & Restore'),
            subtitle: const Text('Last backup: 2 hours ago', style: TextStyle(color: Colors.green)),
            onTap: () {},
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('Delete Account', style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        const CircleAvatar(radius: 32, child: Icon(Icons.person, size: 32)),
        const SizedBox(width: AppSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('User Name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('user@example.com', style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      ],
    );
  }

  Widget _buildSystemHealthCard() {
    return AppCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('System Health', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: AppSpacing.xs),
              Text('Excellent', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('92%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionsDashboard() {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildPermissionRow('Usage Access', 'Granted', Colors.green),
          const Divider(height: 1),
          _buildPermissionRow('Overlay Permissions', 'Granted', Colors.green),
          const Divider(height: 1),
          _buildPermissionRow('Battery Optimization', 'Missing', Colors.red),
        ],
      ),
    );
  }

  Widget _buildPermissionRow(String title, String status, Color color) {
    return ListTile(
      title: Text(title),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
      ),
      onTap: () {
        // Open System Settings
      },
    );
  }
}
