import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lanviz_server_repository/lanviz_server_repository.dart';

import 'app_view.dart';

class App extends StatelessWidget {
  const App({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LanvizServerRepository>(create: (context) => LanvizServerRepository()),
      ],
      child: const AppView(),
    );
  }
}
