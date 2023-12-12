import 'package:flutter/material.dart';
import 'package:lan_viz/app/bloc/lanviz_client/lanviz_client_bloc.dart';
import 'package:lan_viz/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lanviz_server_repository/lanviz_server_repository.dart';
import 'package:lanviz_client_repository/lanviz_client_repository.dart';
import 'package:lan_viz/core/control/bloc/lanviz_connections/lanviz_connections_cubit.dart';
import 'package:lan_viz/core/server_setup/server_setup.dart';

import 'control_view.dart';

class ControlPage extends StatelessWidget {
  const ControlPage({super.key});

  static const name = "control";

  @override
  Widget build(BuildContext context) {

    final lanvizServer = context.read<LanvizServerRepository>();
    final lanvizClient = context.read<LanvizClientRepository>();

    // Make a scaffold with the text "LanViz" on the left and the ip address on the right
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lanvizServer.isRunning ? secondary[2] : primary[4],
        title: Text("LanViz - ${lanvizServer.isRunning ? "Server" : "Client"}"),
        actions: [
          // Get my public IP address aligned to the right, but centered vertically and with a font size of 20
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                "${lanvizServer.isRunning ? lanvizServer.myIpAddress : lanvizClient.myIpAddress}",
                style: const TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
      body: BlocListener<LanvizClientBloc, LanvizClientState>(
        listener: (context, state) {
          if(state is LanvizClientDisconnected) {
            Navigator.of(context).pushNamedAndRemoveUntil(ServerSetupPage.name, (route) => false);
          }
        },
        child: BlocProvider(
          create: (context) => LanvizConnectionsCubit(lanvizClientRepository: lanvizClient),
          child: const ControlView(),
        ),
      ),
    );
  }
}
