import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lan_viz/app/bloc/lanviz_client/lanviz_client_bloc.dart';
import 'package:lan_viz/core/control/control.dart';

import 'server_setup_view.dart';

class ServerSetupPage extends StatelessWidget {
  const ServerSetupPage({super.key});

  static const name = "server_setup";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MultiBlocListener(
          listeners: [
            BlocListener<LanvizClientBloc, LanvizClientState>(
              listener: (context, state) {
                if(state is LanvizClientConnected) {
                  // push control page without back button
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    ControlPage.name,
                    (route) => false,
                  );
                }
              }
            ),
          ],
          child: const ServerSetupView(),
        ),
      ),
    );
  }
}
