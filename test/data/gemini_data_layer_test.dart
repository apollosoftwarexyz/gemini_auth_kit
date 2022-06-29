import 'package:dio/dio.dart';
import 'package:gemini_auth_kit/config.dart';
import 'package:gemini_auth_kit/data/gemini_data_layer.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'gemini_data_layer_test.mocks.dart';

@GenerateMocks([Dio, GeminiConfig])
void main() {
  late MockGeminiConfig config;
  late GeminiDataLayer sut;
  late MockDio dio;
  final requestOptions = RequestOptions(path: 'url');

  setUp(() {
    dio = MockDio();
    config = MockGeminiConfig();

    when(config.geminiOverrideBaseUrl).thenReturn('url');

    sut = GeminiDataLayer(config, dio);
  });

  group('Errors', () {
    test('When there is a dio timeout then we get a timeout failure', () async {
      // arrange
      when(dio.post('url', data: anyNamed('data'))).thenThrow(
        DioError(
            requestOptions: requestOptions, type: DioErrorType.receiveTimeout),
      );
      // act
      final response = await sut.login('email', 'password');

      // assert
      expect(response.failure, isNotNull);
      expect(response.failure!.error, 'TIMEOUT_ERROR');
    });

    test('When there is a dio timeout then we get a timeout failure', () async {
      // arrange
      when(dio.post('url', data: anyNamed('data'))).thenThrow(
        DioError(
            requestOptions: requestOptions, type: DioErrorType.connectTimeout),
      );
      // act
      final response = await sut.login('email', 'password');

      // assert
      expect(response.failure, isNotNull);
      expect(response.failure!.error, 'TIMEOUT_ERROR');
    });

    test('When there is a dio error then we get a dio failure', () async {
      // arrange
      when(dio.post('url', data: anyNamed('data'))).thenThrow(
        DioError(requestOptions: requestOptions, type: DioErrorType.cancel),
      );
      // act
      final response = await sut.login('email', 'password');

      // assert
      expect(response.failure, isNotNull);
      expect(response.failure!.error, 'INTERNAL_SERVER_ERROR');
    });
  });

  group('Gemini error', () {
    const error = <String, dynamic>{
      "success": false,
      "code": 400,
      "error": "ERR_INCORRECT_USERNAME",
      "message": "Username provided was incorrect"
    };
    test('Incorrect username', () async {
      // arrange
      when(dio.post('url', data: anyNamed('data'))).thenAnswer(
          (realInvocation) async =>
              Response<dynamic>(requestOptions: requestOptions, data: error));
      // act
      final response = await sut.login('email', 'password');

      // assert
      expect(response.failure, isNotNull);
      expect(response.failure!.error, 'ERR_INCORRECT_USERNAME');
    });
  });

  group('Successful response', () {
    const successResponse = <String, dynamic>{
      "success": true,
      "payload": {
        "session": {"token": "mockToken"},
        "user": {},
        "brand": {}
      }
    };

    test('Successful login response', () async {
      // arrange
      when(dio.post('url', data: anyNamed('data'))).thenAnswer(
          (realInvocation) async => Response<dynamic>(
              requestOptions: requestOptions, data: successResponse));
      // act
      final response = await sut.login('email', 'password');

      expect(response.isSuccessful, true);
    });
  });
}
