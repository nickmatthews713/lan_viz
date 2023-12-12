import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lanviz_client_repository/lanviz_client_repository.dart';
import 'package:lanviz_network/lanviz_network.dart';

import 'bloc/packet_delivery/packet_delivery_bloc.dart';

class ConnectionTile extends StatelessWidget {
  const ConnectionTile({
    required this.receiver,
    super.key,
  });

  final ClientConnection receiver;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PacketDeliveryBloc(
        lanvizClientRepository: context.read<LanvizClientRepository>(),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(receiver.name ?? "", style: const TextStyle(fontSize: 20)),
            subtitle: Text(receiver.ip, style: const TextStyle(fontSize: 16)),
            // trailing is a square shaped button with a mail icon. Use an elevated button to get the square shape
            trailing: _TileTrailing(receiver: receiver),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class _TileTrailing extends StatelessWidget {
  const _TileTrailing({
    required this.receiver,
  });

  final ClientConnection receiver;

  @override
  Widget build(BuildContext context) {
    final ClientConnection me = context.read<LanvizClientRepository>().myClientConnection;
    print("me: ${me.ip}, receiver: ${receiver.ip}");
    return BlocBuilder<PacketDeliveryBloc, PacketDeliveryState>(
      builder: (context, state) {
        if (state is PacketSteady) {
          return ElevatedButton(
            onPressed: receiver.ip == me.ip ? null : () {
              context.read<PacketDeliveryBloc>().add(
                SendPacket(
                  sender: context.read<LanvizClientRepository>().myClientConnection,
                  receiver: receiver,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
            ),
            child: const Icon(Icons.mail),
          );
        } else if (state is PacketSending) {
          return const CircularProgressIndicator();
        } else if (state is PacketSent) {
          return const Icon(Icons.check);
        } else {
          return const Icon(Icons.error);
        }
      },
    );
  }
}
