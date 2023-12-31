import 'package:flutter/material.dart';
import 'package:lan_viz/app/bloc/lanviz_client/lanviz_client_bloc.dart';
import 'package:lan_viz/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lan_viz/shared/standard_input_field/standard_input_field.dart';

import 'cubit/join_server_modal_cubit.dart';

class JoinServerModal extends StatelessWidget {
  const JoinServerModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocProvider(
        create: (context) => JoinServerModalCubit(),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<LanvizClientBloc, LanvizClientState>(
              builder: (context, state) {
                if(state is LanvizClientConnecting) {
                  return const _LoadingInfo(title: "Connecting to Server...");
                } else if(state is LanvizClientConnected) {
                  return const _LoadingInfo(title: "Connected to Server!");
                } else {
                  return const _JoinServerForm();
                }
              }
            ),
          ),
        ),
      ),
    );
  }
}

class _JoinServerForm extends StatelessWidget {
  const _JoinServerForm();

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
        "Join Server",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: primary[4],
        ),
      ),
    );
  }
}

class _ServerNameInput extends StatelessWidget {
  const _ServerNameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JoinServerModalCubit, JoinServerModalState>(
      buildWhen: (previous, current) => previous.serverName != current.serverName,
      builder: (context, state) {
        return StandardInputField(
          placeholder: "Server Name",
          onChanged: (value) => context.read<JoinServerModalCubit>().serverNameChanged(value),
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
        BlocBuilder<JoinServerModalCubit, JoinServerModalState>(
            buildWhen: (previous, current) => previous.serverName != current.serverName,
            builder: (context, state) {
              // if server name is pure or invalid, disable the button
              return ElevatedButton(
                onPressed: state.serverName.invalid || state.serverName.pure
                    ? null
                    : () {
                  context.read<LanvizClientBloc>().add(JoinServerClicked(name: "Bob", host: state.serverName.value, port: 8080));
                },
                child: const Text("Join Server"),
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
            color: primary[4],
          ),
        ),
        const SizedBox(height: 8.0),
        const CircularProgressIndicator(),
      ],
    );
  }
}
