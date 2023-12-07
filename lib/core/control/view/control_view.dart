import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lanviz_server_repository/lanviz_server_repository.dart';

class ControlView extends StatelessWidget {
  const ControlView({super.key});

  @override
  Widget build(BuildContext context) {

    final lanvizServer = context.read<LanvizServerRepository>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Control View"),
        // Get my public IP address
        Text("${lanvizServer.isRunning ? lanvizServer.ipAddress : "Not Running"}"),
      ],
    );
  }
}
