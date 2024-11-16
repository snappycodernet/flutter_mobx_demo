import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx_demo/models/post.dart';
import 'package:flutter_mobx_demo/riverpod/app_provider.dart';
import 'package:flutter_mobx_demo/riverpod/post_provider.dart';
import 'package:flutter_mobx_demo/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import '../riverpod/user_provider.dart';

class UserDetails extends ConsumerStatefulWidget {
  final int userId;

  const UserDetails({
    required this.userId,
    super.key
  });

  @override
  ConsumerState<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends ConsumerState<UserDetails> {
  Timer? _debounce;
  final TextEditingController _nameController = TextEditingController();
  User? user;

  @override void initState() {
    Future.microtask(loadState);

    super.initState();
  }

  @override void dispose() {
    _nameController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> loadState() async {
    AppNotifier appNotifier = ref.read(appProvider.notifier);
    appNotifier.setLoading(true);

    await Future.delayed(const Duration(milliseconds: 300));

    var posts = await ApiService.getUserPosts(widget.userId);

    ref.read(postProvider.notifier).setPosts(posts);

    _nameController.value = TextEditingValue(text: user!.name);

    appNotifier.setLoading(false);
  }

  void _onNameChanged(String val) {
    UserNotifier notifier = ref.read(userProvider.notifier);

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      var newUser = User(
        id: user!.id,
        name: val,
        username: user!.username,
        email: user!.email,
        address: user!.address,
        phone: user!.phone,
        website: user!.website,
        company: user!.company,
      );
      notifier.updateUser(newUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    UserNotifier notifier = ref.read(userProvider.notifier);
    UserProviderState userState = ref.watch(userProvider);
    List<Post> posts = ref.watch(postProvider).posts;
    List<int> favorites = userState.favoriteUserIds;
    bool isLoading = ref.watch(appProvider).isLoading;
    user = userState.users.singleWhere((u) => u.id == widget.userId);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Riverpod State Management Demo')
      ),
      body: Center(
        child: (isLoading || user == null) ? const CircularProgressIndicator() : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _nameController,
                    onChanged: _onNameChanged,
                    decoration: const InputDecoration(
                      labelText: 'Change Name',
                      border: OutlineInputBorder()
                    ),
                  )
                ),
                favorites.contains(widget.userId) ?
                  ElevatedButton(
                    onPressed: () {
                      notifier.toggleUserFavorite(widget.userId);
                    },
                    child: const Text('Unmark As Favorite')
                  ) :
                  ElevatedButton(
                    onPressed: () {
                      notifier.toggleUserFavorite(widget.userId);
                    },
                    child: const Text('Mark As Favorite')
                  )
              ],
            ),
            const SizedBox(height: 10),
            Expanded(child: Column(
              children: [
                Text(user!.name),
                Text(user!.username),
                Text(user!.email),
                Text(user!.phone),
                Text(user!.website),
                const SizedBox(height: 20),
                const Text('Company', style: TextStyle(
                    fontSize: 22
                )),
                Text(user!.company.name),
                Text(user!.company.catchPhrase),
                if(user!.company.bs != null)
                  Text(user!.company.bs!),
                const SizedBox(height: 20),
                const Text('Address', style: TextStyle(
                    fontSize: 22
                )),
                Text(user!.address.street),
                Text(user!.address.city),
                Text(user!.address.zipcode),
                const SizedBox(height: 20),
                posts.isEmpty ? const Text('User has no posts...') :
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, idx) {
                      return ListTile(
                        title: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Flexible(
                              child: Text(posts[idx].title, overflow: TextOverflow.visible),
                            )
                          ]
                        ),
                        subtitle: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Flexible(
                              child: Text(posts[idx].body, overflow: TextOverflow.visible),
                            )
                          ],
                        ),
                      );
                    },
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: posts.length,
                  )
                )
              ]
            )),
          ],
        ),
      )
    );
  }
}
