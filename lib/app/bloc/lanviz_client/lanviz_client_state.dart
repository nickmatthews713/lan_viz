part of 'lanviz_client_bloc.dart';

abstract class LanvizClientState extends Equatable {
  const LanvizClientState();

  @override
  List<Object> get props => [];
}

class LanvizClientNotStarted extends LanvizClientState {}

class LanvizClientStarting extends LanvizClientState {}

class LanvizClientRunning extends LanvizClientState {}

class LanvizClientError extends LanvizClientState {
  const LanvizClientError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
