import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lan_viz/core/control/bloc/lanviz_connections/lanviz_connections_cubit.dart';

import 'widgets/user_tile/user_tile.dart';

class NetworkList extends StatelessWidget {
  const NetworkList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanvizConnectionsCubit, LanvizConnectionsState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.connections.length,
          itemBuilder: (context, index) {
            return UserTile(
              name: state.connections[index].name,
              ip: state.connections[index].ip,
            );
          },
        );
      },
    );
  }
}
