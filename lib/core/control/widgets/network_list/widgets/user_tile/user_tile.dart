import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    required this.name,
    required this.ip,
    super.key,
  });

  final String name;
  final String ip;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(name, style: const TextStyle(fontSize: 20)),
          subtitle: Text(ip, style: const TextStyle(fontSize: 16)),
          // trailing is a square shaped button with a mail icon. Use an elevated button to get the square shape
          trailing: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
            ),
            child: const Icon(Icons.mail),
          ),
        ),
        Divider(),
      ],
    );
  }
}
