import 'package:flutter_bloc/flutter_bloc.dart';

import '../../abstracts/gemini_authentication_service.dart';
import '../../entities/gemini_login_page_content.dart';

class GeminiLoginLoaderState {
  final bool isLoading;
  final String? failure;
  final GeminiLoginPageContent? content;

  const GeminiLoginLoaderState.loading()
      : isLoading = true,
        failure = null,
        content = null;
  const GeminiLoginLoaderState.failure(this.failure)
      : isLoading = false,
        content = null;
  const GeminiLoginLoaderState.content(this.content)
      : isLoading = false,
        failure = null;
}

class GeminiLoginLoaderCubit extends Cubit<GeminiLoginLoaderState> {
  final GeminiAuthenticationService authenticationService;
  GeminiLoginLoaderCubit(this.authenticationService)
      : super(const GeminiLoginLoaderState.loading());

  Future<void> load() async {
    emit(const GeminiLoginLoaderState.loading());
    final response = await authenticationService.fetchLogin();
    if (!response.isSuccessful) {
      return emit(GeminiLoginLoaderState.failure(response.failure!.reason));
    }
    emit(GeminiLoginLoaderState.content(response.content!));
  }
}
