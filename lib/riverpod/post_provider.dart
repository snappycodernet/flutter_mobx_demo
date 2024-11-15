import 'package:flutter_mobx_demo/models/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostProviderState {
  List<Post> posts = [];

  PostProviderState({
    this.posts = const [],
  });
}

class PostNotifier extends StateNotifier<PostProviderState> {
  PostNotifier() : super(PostProviderState());

  void setPosts(List<Post> posts) {
    state = copyWith(posts: posts);
  }

  PostProviderState copyWith({List<Post>? posts}) {
    return PostProviderState(
        posts: posts ?? [...state.posts],
    );
  }
}

final postProvider = StateNotifierProvider<PostNotifier, PostProviderState>((ref) {
  return PostNotifier();
});