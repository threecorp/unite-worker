import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../interceptor.dart';

import 'extremo_response.dart';

part 'extremo.g.dart';

@riverpod
Dio apiClient(ApiClientRef ref) {
  final dio = Dio();
  dio.interceptors.add(LoggerInterceptor());
  return dio;
}

@RestApi(baseUrl: 'http://localhost:8888/api/mypage/v1')
abstract class MypageApi {
  factory MypageApi(Dio dio, {String baseUrl}) = _MypageApi;

  @GET('/artifacts/{id}')
  Future<GetResponse<ArtifactResponse>> getArtifact(@Path('id') int id);

  @GET('/artifacts')
  Future<ListResponse<ArtifactResponse>> listArtifacts(
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  // @GET("/-species/{id}")
  // Future<SpeciesResponse> getSpecies(@Path("id") int id);
}

@RestApi(baseUrl: 'http://localhost:8888/api/public/v1')
abstract class PublicApi {
  factory PublicApi(Dio dio, {String baseUrl}) = _PublicApi;

  @GET('/users/{id}')
  Future<GetResponse<UserResponse>> getUser(@Path('id') int id);

  @GET('/users')
  Future<ListResponse<UserResponse>> listUsers(
    @Query('page') int page,
    @Query('page_size') int pageSize,
  );

  // @GET("/-species/{id}")
  // Future<SpeciesResponse> getSpecies(@Path("id") int id);
}

@riverpod
MypageApi mypageApi(MypageApiRef ref) => MypageApi(ref.read(apiClientProvider));

@riverpod
PublicApi publicApi(PublicApiRef ref) => PublicApi(ref.read(apiClientProvider));
// Same above
// final Api = Provider<Api>((ref) =>
//  Api(ref.read(ApiClientProvider)));
//
