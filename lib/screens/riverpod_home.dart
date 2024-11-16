import 'package:flutter/material.dart';
import 'package:flutter_mobx_demo/riverpod/app_provider.dart';
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

    Future.microtask(loadState);
  }

  Future<void> loadState() async {
    AppNotifier appNotifier = ref.read(appProvider.notifier);
    appNotifier.setLoading(true);

    await Future.delayed(const Duration(milliseconds: 300));

    var users = await ApiService.getUsers();

    ref.read(userProvider.notifier).setUsers(users);

    appNotifier.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    bool isLoading = ref.watch(appProvider).isLoading;

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
        if(isLoading)
          const Center(
            child: CircularProgressIndicator(),
          )
      ],
    );
  }
}
