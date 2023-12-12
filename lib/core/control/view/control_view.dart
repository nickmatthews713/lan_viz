import 'package:flutter/material.dart';

import 'package:lan_viz/core/control/widgets/network_list/network_list.dart';

class ControlView extends StatelessWidget {
  const ControlView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: NetworkList(),
    );
  }
}
