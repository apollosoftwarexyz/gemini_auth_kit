import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gemini_auth_kit/data/gemini_data_layer.dart';
import 'package:gemini_auth_kit/gemini_auth_kit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
    when(config.appId).thenReturn('');
    when(config.redirectUrl).thenReturn('');

    sut = GeminiDataLayer(config, dio);
  });

  group('Errors', () {
    test('When there is a dio timeout then we get a timeout failure', () async {
      // arrange
      when(dio.post(
        any,
        data: anyNamed('data'),
        queryParameters: anyNamed('queryParameters'),
      )).thenThrow(
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
      when(
        dio.post(
          any,
          data: anyNamed('data'),
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenThrow(
        DioError(
            requestOptions: requestOptions, type: DioErrorType.connectTimeout),
      );
      // act
      final response = await sut.login('email', 'password');

      // assert
      expect(response.failure, isNotNull);
      expect(response.failure!.error, 'TIMEOUT_ERROR');
    });

    test('When there is a dio error then we get a dio cancel', () async {
      // arrange
      when(dio.post(
        any,
        data: anyNamed('data'),
        queryParameters: anyNamed('queryParameters'),
      )).thenThrow(
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
      when(dio.post(
        any,
        data: anyNamed('data'),
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((realInvocation) async =>
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
      when(dio.post(
        any,
        data: anyNamed('data'),
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((realInvocation) async => Response<dynamic>(
          requestOptions: requestOptions, data: successResponse));
      // act
      final response = await sut.login('email', 'password');

      expect(response.isSuccessful, true);
    });
  });

  group('testing redirects', () {
    test('test 1', () async {
      when(
        dio.post(
          any,
          data: anyNamed('data'),
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenAnswer((_) async => Response<dynamic>(
            requestOptions: requestOptions,
            statusCode: 302,
            data:
                'Redirecting to <a href="http://localhost:2070/auth/done">http://localhost:2070/auth/done</a>.',
          ));

      // act
      final response = await sut.login('email', 'password');
    });
  });
}
