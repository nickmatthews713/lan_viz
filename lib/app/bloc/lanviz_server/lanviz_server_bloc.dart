import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lan_viz/app/bloc/lanviz_client/lanviz_client_bloc.dart';

import 'package:lanviz_server_repository/lanviz_server_repository.dart';

part 'lanviz_server_state.dart';
part 'lanviz_server_event.dart';

class LanvizServerBloc extends Bloc<LanvizServerEvent, LanvizServerState> {
  LanvizServerBloc(
    LanvizServerRepository? lanvizServerRepository,
    {required LanvizClientBloc lanvizClientBloc}
  ) : _lanvizServerRepository = lanvizServerRepository ?? LanvizServerRepository(),
      _lanvizClientBloc = lanvizClientBloc,
  super(LanvizServerNotStarted()) {
    on<HostServerClicked>(_onHostServerClicked);
  }

  final LanvizServerRepository _lanvizServerRepository;

  final LanvizClientBloc _lanvizClientBloc;

  Future<void> _onHostServerClicked(HostServerClicked event, Emitter<LanvizServerState> emit) async {
    emit(LanvizServerStarting());
    // sleep for 2 seconds to simulate starting server
    await Future.delayed(const Duration(seconds: 2));
    try {
      await _lanvizServerRepository.initializeServer();
      emit(LanvizServerRunning());
      _lanvizClientBloc.add(const JoinServerClicked(name: "Beans", host: "127.0.0.1", port: 8080));
    } catch (e) {
      emit(LanvizServerError(message: e.toString()));
    }
  }
}
