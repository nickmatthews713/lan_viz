import 'package:flutter/material.dart';

import 'server_setup_view.dart';

class ServerSetupPage extends StatelessWidget {
  const ServerSetupPage({super.key});

  static const name = "server_setup";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: ServerSetupView(),
      ),
    );
  }
}
