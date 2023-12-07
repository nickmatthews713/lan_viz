import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:lanviz_client_repository/lanviz_client_repository.dart';

part 'lanviz_client_state.dart';
part 'lanviz_client_event.dart';

class LanvizClientBloc extends Bloc<LanvizClientEvent, LanvizClientState> {
  LanvizClientBloc(
    LanvizClientRepository? lanvizClientRepository,
  ) : _lanvizClientRepository = lanvizClientRepository ?? LanvizClientRepository(),
  super(LanvizClientNotStarted()) {
    on<JoinServerClicked>(_onJoinServerClicked);
  }

  final LanvizClientRepository _lanvizClientRepository;

  Future<void> _onJoinServerClicked(JoinServerClicked event, Emitter<LanvizClientState> emit) async {
    emit(LanvizClientStarting());
    try {
      await _lanvizClientRepository.initializeClient(host: event.host, port: event.port);
      emit(LanvizClientRunning());
    } catch (e) {
      emit(LanvizClientError(message: e.toString()));
    }
  }
}
