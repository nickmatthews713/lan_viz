import 'package:flutter/material.dart';
import 'package:lan_viz/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lanviz_server_repository/lanviz_server_repository.dart';

import 'control_view.dart';

class ControlPage extends StatelessWidget {
  const ControlPage({super.key});

  static const name = "control";

  @override
  Widget build(BuildContext context) {

    final lanvizServer = context.read<LanvizServerRepository>();

    // Make a scaffold with the text "LanViz" on the left and the ip address on the right
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lanvizServer.isRunning ? secondary[2] : primary[4],
        title: const Text("LanViz"),
        actions: [
          // Get my public IP address aligned to the right, but centered vertically and with a font size of 20
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                "${lanvizServer.isRunning ? lanvizServer.ipAddress : "Error"}",
                style: const TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
      body: const ControlView(),
    );
  }
}
