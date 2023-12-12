part of 'packet_delivery_bloc.dart';

abstract class PacketDeliveryEvent extends Equatable {
  const PacketDeliveryEvent();

  @override
  List<Object> get props => [];
}

/// Event of the [PacketDeliveryBloc] when a packet is being sent.
class SendPacket extends PacketDeliveryEvent {
  /// {@macro send_packet}
  const SendPacket({
    required this.sender,
    required this.receiver,
  });

  final ClientConnection sender;
  final ClientConnection receiver;

  @override
  List<Object> get props => [sender, receiver];
}
