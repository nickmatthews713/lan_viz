import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:lanviz_client_repository/lanviz_client_repository.dart';
import 'package:lanviz_network/lanviz_network.dart';

part 'packet_delivery_event.dart';
part 'packet_delivery_state.dart';

class PacketDeliveryBloc extends Bloc<PacketDeliveryEvent, PacketDeliveryState> {
  PacketDeliveryBloc({required this.lanvizClientRepository}) : super(PacketSteady()) {
    on<SendPacket>(_onSendPacket);
  }

  final LanvizClientRepository lanvizClientRepository;

  Future<void> _onSendPacket(SendPacket event, Emitter<PacketDeliveryState> emit) async {
    emit(PacketSending());

    lanvizClientRepository.sendPacketDirectiveRequest(
      sender: event.sender,
      receiver: event.receiver,
    );
    // sleep for 2 seconds to simulate sending a packet
    await Future.delayed(const Duration(seconds: 2), () {
      emit(PacketSent());
    });
  }
}
