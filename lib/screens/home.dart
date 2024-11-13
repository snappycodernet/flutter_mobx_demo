import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_demo/mobx/user_store.dart';
import 'package:flutter_mobx_demo/models/post.dart';
import 'package:flutter_mobx_demo/services/api_service.dart';

import '../models/User.dart';

final userStore = UserStore();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? _userIdLoaded;

  void _incrementUserId() {
    setState(() {
      if(_userIdLoaded != null) {
        _userIdLoaded = _userIdLoaded! + 1;
      }
      else {
        _userIdLoaded = 1;
      }

      _onStateChange();
    });
  }

  void _decrementUserId() {
    setState(() {
      if(_userIdLoaded != null && _userIdLoaded! > 1) {
        _userIdLoaded = _userIdLoaded! - 1;
      }
      else {
        _userIdLoaded = 1;
      }

      _onStateChange();
    });
  }

  Future<void> _onStateChange() async {
    if(_userIdLoaded != null) {
      User apiUser = await ApiService.getUser(_userIdLoaded!);
      List<Post> posts = await ApiService.getUserPosts(_userIdLoaded!);

      userStore.loginUser(apiUser);
      userStore.setUserPosts(posts);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('MobX State Management Demo')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Expanded(child: Observer(
              builder: (_) {
                return userStore.activeUser != null ? Column(
                  children: [
                    Text(userStore.activeUser!.name),
                    Text(userStore.activeUser!.username),
                    Text(userStore.activeUser!.email),
                    Text(userStore.activeUser!.phone),
                    Text(userStore.activeUser!.website),
                    const SizedBox(height: 20),
                    const Text('Company', style: TextStyle(
                      fontSize: 22
                    )),
                    Text(userStore.activeUser!.company.name),
                    Text(userStore.activeUser!.company.catchPhrase),
                    if(userStore.activeUser!.company.bs != null)
                      Text(userStore.activeUser!.company.bs!),
                    const SizedBox(height: 20),
                    const Text('Address', style: TextStyle(
                        fontSize: 22
                    )),
                    Text(userStore.activeUser!.address.street),
                    Text(userStore.activeUser!.address.city),
                    Text(userStore.activeUser!.address.zipcode),
                    const SizedBox(height: 20),
                    userStore.userPosts.isEmpty ? const Text('User has no posts...') :
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, idx) {
                          return ListTile(
                            title: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Flexible(
                                  child: Text(userStore.userPosts[idx].title, overflow: TextOverflow.visible),
                                )
                              ]
                            ),
                            subtitle: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Flexible(
                                  child: Text(userStore.userPosts[idx].body, overflow: TextOverflow.visible),
                                )
                              ],
                            ),
                          );
                        },
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: userStore.userPosts.length,
                      )
                    )
                  ],
                ) : const Text('No user loaded.');
              }
            )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _decrementUserId,
                  child: const Text('-'),
                ),
                const SizedBox(width: 20),
                Text(_userIdLoaded?.toString() ?? 'None'),
                const SizedBox(width: 20), // Add some space between the buttons
                ElevatedButton(
                  onPressed: _incrementUserId,
                  child: const Text('+'),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}
