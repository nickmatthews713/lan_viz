part of 'lanviz_client_bloc.dart';

abstract class LanvizClientEvent extends Equatable {
  const LanvizClientEvent();

  @override
  List<Object> get props => [];
}

class JoinServerClicked extends LanvizClientEvent {
  const JoinServerClicked({required this.host, required this.port});

  // IP address of the server to connect to
  final String host;

  // Port number of the server to connect to
  final int port;

  @override
  List<Object> get props => [host, port];
}
