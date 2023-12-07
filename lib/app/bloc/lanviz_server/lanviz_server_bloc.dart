import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:lanviz_server_repository/lanviz_server_repository.dart';

part 'lanviz_server_state.dart';
part 'lanviz_server_event.dart';

class LanvizServerBloc extends Bloc<LanvizServerEvent, LanvizServerState> {
  LanvizServerBloc(
    LanvizServerRepository? lanvizServerRepository,
  ) : _lanvizServerRepository = lanvizServerRepository ?? LanvizServerRepository(),
  super(LanvizServerNotStarted()) {
    on<HostServerClicked>(_onHostServerClicked);
  }

  final LanvizServerRepository _lanvizServerRepository;

  Future<void> _onHostServerClicked(HostServerClicked event, Emitter<LanvizServerState> emit) async {
    emit(LanvizServerStarting());
    try {
      await _lanvizServerRepository.initializeServer();
      emit(LanvizServerRunning());
      print("Server running");
    } catch (e) {
      emit(LanvizServerError(message: e.toString()));
    }
  }
}
