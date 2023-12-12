import 'package:flutter/material.dart';
import 'package:lan_viz/app/app.dart';
import 'package:lan_viz/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lan_viz/shared/standard_input_field/standard_input_field.dart';

import 'cubit/host_server_modal_cubit.dart';

class HostServerModal extends StatelessWidget {
  const HostServerModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocProvider(
        create: (context) => HostServerModalCubit(),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<LanvizServerBloc, LanvizServerState>(
              builder: (context, state) {
                if(state is LanvizServerStarting) {
                  return const _LoadingInfo(title: "Starting and Connecting...");
                } else if(state is LanvizServerRunning) {
                  return const _LoadingInfo(title: "Server Running!");
                } else {
                  return const _HostServerForm();
                }
              }
            ),
          ),
        ),
      ),
    );
  }
}

class _HostServerForm extends StatelessWidget {
  const _HostServerForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const _Header(),
        Divider(color: neutral[1]),
        const SizedBox(height: 8.0),
        const _ServerNameInput(),
        const SizedBox(height: 8.0),
        const _ActionButtons(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Host Server",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: secondary[2],
        ),
      ),
    );
  }
}

class _ServerNameInput extends StatelessWidget {
  const _ServerNameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HostServerModalCubit, HostServerModalState>(
      buildWhen: (previous, current) => previous.serverName != current.serverName,
      builder: (context, state) {
        return StandardInputField(
          placeholder: "Server Name",
          onChanged: (value) => context.read<HostServerModalCubit>().serverNameChanged(value),
          isInputValid: !state.serverName.invalid,
          fontSize: 20,
        );
      },
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        BlocBuilder<HostServerModalCubit, HostServerModalState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            // if server name is pure or invalid, disable the button
            return ElevatedButton(
              onPressed: state.serverName.invalid || state.serverName.pure
                ? null
                : () {
                context.read<LanvizServerBloc>().add(HostServerClicked());
            },
              child: const Text("Host Server"),
            );
          }
        ),
      ],
    );
  }
}

class _LoadingInfo extends StatelessWidget {
  const _LoadingInfo({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    // column of title a loading indicator
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: secondary[2],
          ),
        ),
        const SizedBox(height: 8.0),
        const CircularProgressIndicator(),
      ],
    );
  }
}
