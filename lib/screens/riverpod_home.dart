import 'package:flutter/material.dart';
import 'package:flutter_mobx_demo/models/post.dart';
import 'package:flutter_mobx_demo/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import '../riverpod/user_provider.dart';

class RiverpodHome extends ConsumerStatefulWidget {
  const RiverpodHome({super.key});

  @override
  ConsumerState<RiverpodHome> createState() => _RiverpodHomeState();
}

class _RiverpodHomeState extends ConsumerState<RiverpodHome> {
  int? _userIdLoaded;
  late UserNotifier _notifier;

  @override void initState() {
    // TODO: implement initState
    super.initState();

    _notifier = ref.read(userProvider.notifier);
  }

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

      _notifier.toggleUser(apiUser);
      _notifier.setUserPosts(posts);
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProviderState state = ref.watch(userProvider);

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Riverpod State Management Demo')
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Expanded(child: state.user != null ? Column(
                children: [
                  Text(state.user!.name),
                  Text(state.user!.username),
                  Text(state.user!.email),
                  Text(state.user!.phone),
                  Text(state.user!.website),
                  const SizedBox(height: 20),
                  const Text('Company', style: TextStyle(
                      fontSize: 22
                  )),
                  Text(state.user!.company.name),
                  Text(state.user!.company.catchPhrase),
                  if(state.user!.company.bs != null)
                    Text(state.user!.company.bs!),
                  const SizedBox(height: 20),
                  const Text('Address', style: TextStyle(
                      fontSize: 22
                  )),
                  Text(state.user!.address.street),
                  Text(state.user!.address.city),
                  Text(state.user!.address.zipcode),
                  const SizedBox(height: 20),
                  state.posts.isEmpty ? const Text('User has no posts...') :
                  Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, idx) {
                          return ListTile(
                            title: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Flexible(
                                    child: Text(state.posts[idx].title, overflow: TextOverflow.visible),
                                  )
                                ]
                            ),
                            subtitle: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Flexible(
                                  child: Text(state.posts[idx].body, overflow: TextOverflow.visible),
                                )
                              ],
                            ),
                          );
                        },
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.posts.length,
                      )
                  )
                ]) : const Text('No user loaded.')
              ),
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
