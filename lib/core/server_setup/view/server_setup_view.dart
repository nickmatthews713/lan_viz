import 'package:flutter/material.dart';
import 'package:lan_viz/theme.dart';

import 'package:lan_viz/core/server_setup/server_setup.dart';

class ServerSetupView extends StatelessWidget {
  const ServerSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: const _ServerButtons(),
      ),
    );
  }
}

class _ServerButtons extends StatelessWidget {
  const _ServerButtons();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const HostServerModal(),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(60),
            backgroundColor: secondary[2],
          ),
          child: Text('HOST a server', style: TextStyle(
            color: neutral[0],
            fontSize: 18,
          )),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(60),
          ),
          child: Text('JOIN a server', style: TextStyle(
            color: neutral[0],
            fontSize: 18,
          )),
        ),
      ],
    );
  }
}
