import 'package:dio/dio.dart';
import 'package:proyekaplikasikoskosan/models/user_model_firebase.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/posts')
  Future<List<PostModels>> getAllPosts();
}
