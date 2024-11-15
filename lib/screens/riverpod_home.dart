import 'package:flutter/material.dart';
import 'package:flutter_mobx_demo/riverpod/user_provider.dart';
import 'package:flutter_mobx_demo/services/api_service.dart';
import 'package:flutter_mobx_demo/widgets/user_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodHome extends ConsumerStatefulWidget {
  const RiverpodHome({super.key});

  @override
  ConsumerState<RiverpodHome> createState() => _RiverpodHomeState();
}

class _RiverpodHomeState extends ConsumerState<RiverpodHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ApiService.getUsers().then((users) => {
      ref.read(userProvider.notifier).setUsers(users)
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Text('App Users', style: TextStyle(
          fontSize: 22
        )),
        const SizedBox(height: 10),
        UserList(users: userState.users),
      ],
    );
  }
}
