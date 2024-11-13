import 'package:dio/dio.dart';

import '../models/User.dart';
import '../models/post.dart';

class ApiService {
  static Future<User> getUser(int id) async {
    try {
      final dio = Dio();
      var response = await dio.get("https://jsonplaceholder.typicode.com/users/$id");

      var userJson = response.data as dynamic;
      var userModel = User.fromJson(userJson);

      return userModel;
    } catch (error) {
      // TODO: do something with error

      throw Exception('Error fetching user');
    }
  }

  static Future<List<Post>> getUserPosts(int userId) async {
    try {
      final dio = Dio();
      var response = await dio.get("https://jsonplaceholder.typicode.com/posts?userId=$userId");
      var posts = List<Post>.empty(growable: true);
      var postListJson = response.data as List<dynamic>;

      for(final postItem in postListJson) {
        posts.add(Post.fromJson(postItem));
      }

      return posts;
    } catch (error) {
      // TODO: do something with error

      throw Exception('Error fetching user posts');
    }
  }
}