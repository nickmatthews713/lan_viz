part of 'lanviz_connections_cubit.dart';

class LanvizConnectionsState extends Equatable {
  const LanvizConnectionsState({
    this.connections = const [],
    this.stateChanger = 0,
  });

  final List<ClientConnection> connections;

  final int stateChanger;

  @override
  List<Object> get props => [connections];

  LanvizConnectionsState copyWith({
    List<ClientConnection>? connections,
    int? stateChanger,
  }) {
    return LanvizConnectionsState(
      connections: connections ?? this.connections,
      stateChanger: stateChanger ?? this.stateChanger,
    );
  }
}
