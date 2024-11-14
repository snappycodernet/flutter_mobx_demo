// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  late final _$activeUserAtom =
      Atom(name: '_UserStore.activeUser', context: context);

  @override
  User? get activeUser {
    _$activeUserAtom.reportRead();
    return super.activeUser;
  }

  @override
  set activeUser(User? value) {
    _$activeUserAtom.reportWrite(value, super.activeUser, () {
      super.activeUser = value;
    });
  }

  late final _$userPostsAtom =
      Atom(name: '_UserStore.userPosts', context: context);

  @override
  List<Post> get userPosts {
    _$userPostsAtom.reportRead();
    return super.userPosts;
  }

  @override
  set userPosts(List<Post> value) {
    _$userPostsAtom.reportWrite(value, super.userPosts, () {
      super.userPosts = value;
    });
  }

  late final _$_UserStoreActionController =
      ActionController(name: '_UserStore', context: context);

  @override
  dynamic loginUser(User userModel) {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.loginUser');
    try {
      return super.loginUser(userModel);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUserPosts(List<Post> posts) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setUserPosts');
    try {
      return super.setUserPosts(posts);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
activeUser: ${activeUser},
userPosts: ${userPosts}
    ''';
  }
}
