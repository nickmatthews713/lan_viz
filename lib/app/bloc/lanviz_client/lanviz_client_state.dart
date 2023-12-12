part of 'lanviz_client_bloc.dart';

abstract class LanvizClientState extends Equatable {
  const LanvizClientState();

  @override
  List<Object> get props => [];
}

class LanvizClientDisconnected extends LanvizClientState {}

class LanvizClientConnecting extends LanvizClientState {}

class LanvizClientConnected extends LanvizClientState {}

class LanvizClientConnectionError extends LanvizClientState {
  const LanvizClientConnectionError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
