import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lanviz_client_repository/lanviz_client_repository.dart';
import 'package:lanviz_network/lanviz_network.dart';

part 'lanviz_connections_state.dart';

class LanvizConnectionsCubit extends Cubit<LanvizConnectionsState> {
  LanvizConnectionsCubit({required this.lanvizClientRepository})
      : super(const LanvizConnectionsState()) {
    _allConnectionsStreamSubscription = lanvizClientRepository.allConnections.stream.listen((json) {
      handleMessage(json);
    });
  }

  final LanvizClientRepository lanvizClientRepository;

  late final StreamSubscription<Map<String, dynamic>> _allConnectionsStreamSubscription;

  void handleMessage(Map<String, dynamic> json) {
    final allConnectionsResponse = AllConnectionsResponse.fromJson(json);
    final connections = allConnectionsResponse.connections;

    // make a copy of the connections list
    final connectionsCopy = List<ClientConnection>.from(connections);

    final newStateChanger = DateTime.now().millisecondsSinceEpoch;
    emit(
      state.copyWith(
        connections: connectionsCopy,
        stateChanger: newStateChanger,
      ),
    );
  }

  @override
  Future<void> close() {
    _allConnectionsStreamSubscription.cancel();
    lanvizClientRepository.allConnections.close();
    return super.close();
  }
}
