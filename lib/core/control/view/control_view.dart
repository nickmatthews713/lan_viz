import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lanviz_client_repository/lanviz_client_repository.dart';

class ControlView extends StatelessWidget {
  const ControlView({super.key});

  @override
  Widget build(BuildContext context) {

    final lanvizClient = context.read<LanvizClientRepository>();

    // text controller for the text field
    final textController = TextEditingController();

    // make a column with a text field and a button. on button push, the text field value is sent to the server
    return Column(
      children: [
        TextField(
          controller: textController,
          decoration: const InputDecoration(
            labelText: "Message",
          ),
          onSubmitted: (value) {
            lanvizClient.sendData(value);
          },
        ),
        ElevatedButton(
          onPressed: () {
            lanvizClient.sendData(textController.text);
          },
          child: const Text("Send Message"),
        ),
      ],
    );
  }
}
