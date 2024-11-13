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
  String toString() {
    return '''
activeUser: ${activeUser}
    ''';
  }
}
