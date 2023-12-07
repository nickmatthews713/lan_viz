import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lanviz_server_repository/lanviz_server_repository.dart';
import 'package:lanviz_client_repository/lanviz_client_repository.dart';
import 'package:lan_viz/app/bloc/lanviz_server/lanviz_server_bloc.dart';
import 'package:lan_viz/app/bloc/lanviz_client/lanviz_client_bloc.dart';

import 'app_view.dart';

class App extends StatelessWidget {
  const App({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LanvizServerRepository>(create: (context) => LanvizServerRepository()),
        RepositoryProvider<LanvizClientRepository>(create: (context) => LanvizClientRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LanvizServerBloc>(create: (context) => LanvizServerBloc(context.read<LanvizServerRepository>())),
          BlocProvider<LanvizClientBloc>(create: (context) => LanvizClientBloc(context.read<LanvizClientRepository>())),
        ],
        child: const AppView(),
      ),
    );
  }
}
