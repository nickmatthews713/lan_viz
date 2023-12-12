part of 'packet_delivery_bloc.dart';

abstract class PacketDeliveryState extends Equatable {
  const PacketDeliveryState();

  @override
  List<Object> get props => [];
}

/// Initial state of the [PacketDeliveryBloc].
class PacketSteady extends PacketDeliveryState {}

/// State of the [PacketDeliveryBloc] when a packet is being sent.
class PacketSending extends PacketDeliveryState {}

/// State of the [PacketDeliveryBloc] when a packet has been sent.
class PacketSent extends PacketDeliveryState {}

/// State of the [PacketDeliveryBloc] when a packet is being received.
class PacketReceiving extends PacketDeliveryState {}

/// State of the [PacketDeliveryBloc] when a packet has been received.
class PacketReceived extends PacketDeliveryState {}

/// State of the [PacketDeliveryBloc] when a packet has been lost.
class PacketLost extends PacketDeliveryState {}
