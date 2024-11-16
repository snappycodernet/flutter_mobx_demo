import 'package:flutter/material.dart';
import 'package:flutter_mobx_demo/models/user.dart';
import 'package:flutter_mobx_demo/riverpod/user_provider.dart';
import 'package:flutter_mobx_demo/screens/riverpod_user_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserList extends ConsumerWidget {
  final List<User> users;

  const UserList({required this.users, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<int> favorites = ref.read(userProvider).favoriteUserIds;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 500),
            child: ListView.builder(
              itemBuilder: (context, idx) {
                return Column(
                  children: [
                    ListTile(
                      tileColor: Colors.grey,
                      textColor: Colors.white,
                      title: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(users[idx].name, overflow: TextOverflow.visible),
                            ),
                            Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => UserDetails(userId: users[idx].id)
                                      )
                                    );
                                  },
                                  child: const Text('View Profile')
                                ),
                                const SizedBox(width: 10),
                                favorites.contains(users[idx].id) ?
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 32.0,
                                ) :
                                const Icon(
                                  Icons.star,
                                  color: Colors.white70,
                                  size: 32.0,
                                )
                              ],
                            )
                          ]
                      ),
                    ),
                    const SizedBox(height: 10)
                  ],
                );
              },
              itemCount: users.length,
              shrinkWrap: true,
            )
          ),
        )
      ],
    );
  }
}
