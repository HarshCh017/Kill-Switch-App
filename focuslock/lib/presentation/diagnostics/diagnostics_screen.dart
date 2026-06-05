import 'package:flutter/material.dart';

class DiagnosticsScreen extends StatelessWidget {
  const DiagnosticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('System Diagnostics')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHealthTile('Usage Access Permission', true),
          _buildHealthTile('Overlay Permission', true),
          _buildHealthTile('Battery Optimization Disabled', false, isCritical: true),
          _buildHealthTile('Foreground Service Status', true),
          _buildHealthTile('Background Sync Queue', true),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              // Trigger SupportBundleGenerator
            },
            icon: const Icon(Icons.bug_report),
            label: const Text('Generate Support Bundle'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _buildHealthTile(String title, bool isHealthy, {bool isCritical = false}) {
    return ListTile(
      leading: Icon(
        isHealthy ? Icons.check_circle : Icons.error,
        color: isHealthy ? Colors.green : (isCritical ? Colors.red : Colors.orange),
      ),
      title: Text(title),
      trailing: isHealthy ? null : TextButton(
        onPressed: () {
          // Route to specific Android/iOS OS settings page
        },
        child: const Text('Fix'),
      ),
    );
  }
}
