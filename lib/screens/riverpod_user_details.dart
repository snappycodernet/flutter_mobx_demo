import 'package:flutter/material.dart';
import 'package:flutter_mobx_demo/models/post.dart';
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

  @override void initState() {
    super.initState();

    ApiService.getUserPosts(widget.userId).then((posts) => {
      ref.read(postProvider.notifier).setPosts(posts)
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = ref.watch(userProvider).users.singleWhere((u) => u.id == widget.userId);
    List<Post> posts = ref.watch(postProvider).posts;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Riverpod State Management Demo')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Expanded(child: Column(
              children: [
                Text(user.name),
                Text(user.username),
                Text(user.email),
                Text(user.phone),
                Text(user.website),
                const SizedBox(height: 20),
                const Text('Company', style: TextStyle(
                    fontSize: 22
                )),
                Text(user.company.name),
                Text(user.company.catchPhrase),
                if(user.company.bs != null)
                  Text(user.company.bs!),
                const SizedBox(height: 20),
                const Text('Address', style: TextStyle(
                    fontSize: 22
                )),
                Text(user.address.street),
                Text(user.address.city),
                Text(user.address.zipcode),
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
