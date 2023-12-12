import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lanviz_client_repository/lanviz_client_repository.dart';
import 'package:lanviz_network/lanviz_network.dart';

part 'lanviz_connections_state.dart';

class LanvizConnectionsCubit extends Cubit<LanvizConnectionsState> {
  LanvizConnectionsCubit({required this.lanvizClientRepository})
      : super(const LanvizConnectionsState()) {
    _messageStreamSubscription = lanvizClientRepository.messageStream.listen((json) {
      handleMessage(json);
    });
  }

  final LanvizClientRepository lanvizClientRepository;

  late final StreamSubscription<Map<String, dynamic>> _messageStreamSubscription;

  void handleMessage(Map<String, dynamic> json) {
    final id = json["id"];
    if(id == "all_connections") {
      final allConnectionsResponse = AllConnectionsResponse.fromJson(json);
      final connections = allConnectionsResponse.connections;
      emit(
        state.copyWith(
          connections: connections,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _messageStreamSubscription.cancel();
    return super.close();
  }
}