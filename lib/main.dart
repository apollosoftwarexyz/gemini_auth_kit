import 'package:dio/dio.dart';
import 'package:gemini_auth_kit/config.dart';
import 'package:gemini_auth_kit/data/gemini_data_layer.dart';
import 'package:gemini_auth_kit/data/gemini_response_handler.dart';
import 'package:gemini_auth_kit/pages/login/gemini_login_page_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

Future<void> configureInjection(
  GetIt locator, {
  required GeminiConfig geminiConfig,
  required GeminiResponseHandler geminiResponseHandler,
}) async {
  locator.registerFactory<GeminiConfig>(() => geminiConfig);
  locator.registerFactory<GeminiResponseHandler>(() => geminiResponseHandler);

  locator.registerSingleton(Dio());

  locator.registerFactory(() => GeminiDataLayer(locator(), locator()));
  locator.registerFactory(() => GeminiLoginPageCubit(locator(), locator()));
}
