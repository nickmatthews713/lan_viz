import 'package:flutter/material.dart';
import 'package:lan_viz/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:lan_viz/core/server_setup/server_setup.dart';


class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LanViz",
      debugShowCheckedModeBanner: false,
      theme: theme,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 580, name: MOBILE),
          const Breakpoint(start: 581, end: 960, name: TABLET),
          const Breakpoint(start: 961, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      initialRoute: ServerSetupPage.name,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          return buildPage(settings.name ?? '');
        });
      },
    );
  }

  Widget buildPage(String name) {
    switch (name) {
      case ServerSetupPage.name:
        return const ServerSetupPage();
      default:
        return const SizedBox.shrink();
    }
  }
}
