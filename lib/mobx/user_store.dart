import 'package:mobx/mobx.dart';
import '../models/User.dart';
import '../models/post.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  User? activeUser;

  @observable
  List<Post> userPosts = List.empty();

  @action loginUser(User userModel) {
     activeUser = userModel;
  }

  @action setUserPosts(List<Post> posts) {
    userPosts = posts;
  }
}