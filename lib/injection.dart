import 'package:dio/dio.dart';
import 'package:gemini_auth_kit/data/gemini_data_layer.dart';
import 'package:gemini_auth_kit/gemini_auth_kit.dart';
import 'package:gemini_auth_kit/pages/login/gemini_login_page_cubit.dart';
import 'package:gemini_auth_kit/services/gemini_authentication_service.dart';
import 'package:get_it/get_it.dart';

import 'pages/login/gemini_login_loader_cubit.dart';

final GetIt locator = GetIt.instance;

/// Configures the dependencies for this package
///
/// Requires that an implementation for the following classes
/// have been registered: [GeminiConfig] [GeminiResponseHandler]
///
/// An instance of Dio will be used as the API client - one is
/// created if not provided
Future<void> configureInjection(GetIt locator) async {
  if (!locator.isRegistered<Dio>()) {
    locator.registerSingleton(Dio());
  }

  locator.registerFactory(() => GeminiDataLayer(locator(), locator()));
  locator.registerLazySingleton<GeminiAuthenticationService>(
      () => GeminiAuthenticationServiceImpl(locator()));
  locator.registerFactory(() => GeminiLoginPageCubit(locator(), locator()));
  locator.registerFactory(() => GeminiLoginLoaderCubit(locator()));
}
