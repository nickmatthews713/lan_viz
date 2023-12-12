part of 'lanviz_connections_cubit.dart';

class LanvizConnectionsState extends Equatable {
  const LanvizConnectionsState({
    this.connections = const [],
  });

  final List<ClientConnection> connections;

  @override
  List<Object> get props => [connections];

  LanvizConnectionsState copyWith({
    List<ClientConnection>? connections,
  }) {
    return LanvizConnectionsState(
      connections: connections ?? this.connections,
    );
  }
}
