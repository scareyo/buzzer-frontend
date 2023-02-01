import 'package:flutter/material.dart';

import 'package:settings_ui/settings_ui.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _host = 'localhost';
  String _port = '80';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Settings"),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Connection'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                title: Text('Host'),
                value: Text(_host),
                onPressed: (context) async {
                  final input = await showTextInputDialog(
                    context: context,
                    textFields: const [
                      DialogTextField(
                        keyboardType: TextInputType.url,
                      ),
                    ],
                    title: 'Host',
                  );
                  
                  if (input != null) {
                    setState(() {
                      _host = input[0];
                    });
                  }
                }
              ),
              SettingsTile.navigation(
                title: Text('Port'),
                value: Text(_port),
                onPressed: (context) async {
                  final input = await showTextInputDialog(
                    context: context,
                    textFields: const [
                      DialogTextField(
                        keyboardType: TextInputType.number,
                      ),
                    ],
                    title: 'Port',
                  );
                  
                  if (input != null) {
                    setState(() {
                      _port = input[0];
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

