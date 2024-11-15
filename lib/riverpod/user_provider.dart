import 'package:flutter_mobx_demo/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProviderState {
  List<User> users = [];
  List<int> favoriteUserIds = [];

  UserProviderState({
    this.users = const [],
    this.favoriteUserIds = const []
  });
}

class UserNotifier extends StateNotifier<UserProviderState> {
  UserNotifier() : super(UserProviderState());

  void setUsers(List<User> users) {
    state = copyWith(users: users);
  }

  void updateUser(User user) {
    var users = [...state.users];

    var idx = users.indexWhere((u) => u.id == user.id);

    if (idx > -1) {
      users[idx] = user;
      state = copyWith(users: users);
    }
  }

  void toggleUserFavorite(int userId) {
    if (state.favoriteUserIds.contains(userId)) {
      var favs = [...state.favoriteUserIds, userId];
      state = copyWith(favoriteUserIds: favs);
    }
  }

  UserProviderState copyWith({List<User>? users, List<int>? favoriteUserIds}) {
    return UserProviderState(
      users: users ?? [...state.users],
      favoriteUserIds: favoriteUserIds ?? [...state.favoriteUserIds]);
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserProviderState>((ref) {
  return UserNotifier();
});