import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../widgets/common/app_text_field.dart';

class AndroidAppPicker extends StatefulWidget {
  const AndroidAppPicker({super.key});

  @override
  State<AndroidAppPicker> createState() => _AndroidAppPickerState();
}

class _AndroidAppPickerState extends State<AndroidAppPicker> {
  final Set<String> _selectedPackages = {};
  
  // Scaffold: In production, load via installed_apps plugin
  final List<Map<String, String>> _installedApps = [
    {'name': 'Instagram', 'package': 'com.instagram.android'},
    {'name': 'TikTok', 'package': 'com.zhiliaoapp.musically'},
    {'name': 'Twitter', 'package': 'com.twitter.android'},
    {'name': 'YouTube', 'package': 'com.google.android.youtube'},
  ];

  void _toggleSelection(String package) {
    setState(() {
      if (_selectedPackages.contains(package)) {
        _selectedPackages.remove(package);
      } else {
        _selectedPackages.add(package);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Apps to Block'),
        actions: [
          if (_selectedPackages.isNotEmpty)
            TextButton(
              onPressed: () => Navigator.pop(context, _selectedPackages.toList()),
              child: Text('Done (${_selectedPackages.length})'),
            )
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: AppTextField(
              label: 'Search Apps',
              hint: 'e.g. Social Media',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _installedApps.length,
              itemBuilder: (context, index) {
                final app = _installedApps[index];
                final isSelected = _selectedPackages.contains(app['package']);
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.android)), // Scaffold icon
                  title: Text(app['name']!),
                  subtitle: Text(app['package']!, style: const TextStyle(fontSize: 12)),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (_) => _toggleSelection(app['package']!),
                  ),
                  onTap: () => _toggleSelection(app['package']!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
