part of 'lanviz_server_bloc.dart';

abstract class LanvizServerState extends Equatable {
  const LanvizServerState();

  @override
  List<Object> get props => [];
}

class LanvizServerNotStarted extends LanvizServerState {}

class LanvizServerStarting extends LanvizServerState {}

class LanvizServerRunning extends LanvizServerState {}

class LanvizServerError extends LanvizServerState {
  const LanvizServerError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
