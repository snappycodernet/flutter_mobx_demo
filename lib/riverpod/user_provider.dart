import 'package:flutter_mobx_demo/models/post.dart';
import 'package:flutter_mobx_demo/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProviderState {
  User? user;
  List<Post> posts;

  UserProviderState({this.posts = const [], this.user});
}

class UserNotifier extends StateNotifier<UserProviderState> {
  UserNotifier() : super(UserProviderState());

  void toggleUser(User user) {
    state = UserProviderState(posts: [...state.posts], user: user);
  }

  void setUserPosts(List<Post> posts) {
    state = UserProviderState(posts: posts, user: state.user);
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserProviderState>((ref) {
  return UserNotifier();
});