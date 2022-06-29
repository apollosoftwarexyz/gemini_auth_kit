import 'package:dio/dio.dart';
import 'package:gemini_auth_kit/data/gemini_data_layer.dart';
import 'package:gemini_auth_kit/pages/login/gemini_login_page_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

/// Configures the dependencies for this package
///
/// Requies that an implementation for the following classes
/// have been registered: [GeminiConfig] [GeminiResponseHandler]
Future<void> configureInjection(GetIt locator) async {
  locator.registerSingleton(Dio());

  locator.registerFactory(() => GeminiDataLayer(locator(), locator()));
  locator.registerFactory(() => GeminiLoginPageCubit(locator(), locator()));
}
