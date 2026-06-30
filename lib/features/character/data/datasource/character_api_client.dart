import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rick_and_morty_app/core/network/api_endpoints.dart';
import 'package:rick_and_morty_app/features/character/data/model/character_response_model.dart';

part 'character_api_client.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class CharacterApiClient {
  factory CharacterApiClient(Dio dio, {String baseUrl}) = _CharacterApiClient;

  @GET(ApiEndpoints.character)
  Future<CharacterResponseModel> getCharacters({
    @Query('page') int? page,
    @Query('name') String? name,
  });
}