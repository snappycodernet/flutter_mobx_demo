import 'package:mobx/mobx.dart';
import '../models/user.dart';
import '../models/post.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  User? activeUser;

  @MakeObservable(useDeepEquality: true)
  List<Post> userPosts = [];

  @action loginUser(User userModel) {
     activeUser = userModel;
  }

  @action setUserPosts(List<Post> posts) {
    userPosts = posts;
  }
}