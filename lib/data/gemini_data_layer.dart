import 'package:dio/dio.dart';
import 'package:gemini_auth_kit/config/gemini_config.dart';
import 'package:gemini_auth_kit/data/failure.dart';

import '../entities/gemini_login_response.dart';
import 'data_response.dart';

class GeminiDataLayer {
  final GeminiConfig config;
  final Dio dio;

  GeminiDataLayer(this.config, this.dio);

  Future<DataResponse<RawGeminiLoginResponse>> login(String email, String password) async {
    try {
      final response = await dio.post(
          config.geminiOverrideBaseUrl == null ? 'https://api.gemini.xyz:2070' : config.geminiOverrideBaseUrl!,
          data: {
            "email": email,
            "password": password,
          },
          options: Options(sendTimeout: config.connectionTimeout, receiveTimeout: config.recieveTimeout));

      final successResponse = handleResponse(response);
      return DataResponse.success(RawGeminiLoginResponse.fromJson(successResponse.payload));
    } on DioError catch (dioError) {
      if (dioError.type == DioErrorType.connectTimeout || dioError.type == DioErrorType.receiveTimeout) {
        return const DataResponse.failure(GeminiTimeoutFailure());
      } else if (dioError.message.contains('SocketException')) {
        return const DataResponse.failure(GeminiServerConnectionFailure());
      }

      return const DataResponse.failure(GeminiInternalServerFailure());
    } on ApiError {
      return const DataResponse.failure(GeminiInternalServerFailure());
    } on GeminiError catch (geminiError) {
      return DataResponse.failure(GeminiErrorResponseFailure(geminiError.error, geminiError.message));
    } catch (e, st) {
      print('$e $st');
      return const DataResponse.failure(GeminiUnknownFailure());
    }
  }

  SuccessResponse handleResponse(Response response) {
    if (response.data['success'] == true) {
      return SuccessResponse(response.data['payload']);
    } else if (response.data['success'] == false || response.data['payload'] == null) {
      throw GeminiError(
        response.data['code'],
        response.data['error'],
        response.data['message'],
      );
    }
    throw const ApiError();
  }
}

class SuccessResponse {
  Map<String, dynamic> payload;
  SuccessResponse(this.payload);
}

class GeminiError implements Exception {
  final int code;
  final String error;
  final String message;
  GeminiError(this.code, this.error, this.message) : super();
}

class ApiError implements Exception {
  final bool wasTimeout;
  const ApiError([this.wasTimeout = false]);
}
