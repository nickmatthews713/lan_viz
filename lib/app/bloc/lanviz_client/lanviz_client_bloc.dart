import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:lanviz_client_repository/lanviz_client_repository.dart';

part 'lanviz_client_state.dart';
part 'lanviz_client_event.dart';

class LanvizClientBloc extends Bloc<LanvizClientEvent, LanvizClientState> {
  LanvizClientBloc(
    LanvizClientRepository? lanvizClientRepository,
  ) : _lanvizClientRepository = lanvizClientRepository ?? LanvizClientRepository(),
  super(LanvizClientDisconnected()) {
    _connectionStatusStreamSubscription = _lanvizClientRepository.connectionStatus.stream.listen((status) {
      if(status == ClientConnectionStatus.disconnected) {
        add(ServerDisconnected());
      }
    });
    on<JoinServerClicked>(_onJoinServerClicked);
    on<ServerDisconnected>(_onServerDisconnected);
  }

  final LanvizClientRepository _lanvizClientRepository;

  late final StreamSubscription<ClientConnectionStatus> _connectionStatusStreamSubscription;

  Future<void> _onJoinServerClicked(JoinServerClicked event, Emitter<LanvizClientState> emit) async {
    emit(LanvizClientConnecting());
    // sleep for 2 seconds to simulate connecting to server
    await Future.delayed(const Duration(seconds: 2));
    try {
      await _lanvizClientRepository.initializeClient(host: event.host, port: event.port);
      emit(LanvizClientConnected());
    } catch (e) {
      emit(LanvizClientConnectionError(message: e.toString()));
    }
  }

  Future<void> _onServerDisconnected(ServerDisconnected event, Emitter<LanvizClientState> emit) async {
    emit(LanvizClientDisconnected());
  }

  @override
  Future<void> close() {
    _connectionStatusStreamSubscription.cancel();
    return super.close();
  }
}
