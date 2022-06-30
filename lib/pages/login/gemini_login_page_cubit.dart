import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_auth_kit/gemini_auth_kit.dart';

import '../../data/gemini_response_handler.dart';

class GeminiLoginPageState {
  final bool isLoading;
  final String? failure;

  const GeminiLoginPageState.initial()
      : isLoading = false,
        failure = null;
  const GeminiLoginPageState.loading()
      : isLoading = true,
        failure = null;

  const GeminiLoginPageState.error(this.failure) : isLoading = false;
}

class GeminiLoginPageCubit extends Cubit<GeminiLoginPageState> {
  final GeminiResponseHandler _handler;
  final GeminiAuthenticationService _authenticationService;
  GeminiLoginPageCubit(this._authenticationService, this._handler)
      : super(const GeminiLoginPageState.initial());

  Future<void> login(String email, String password) async {
    try {
      emit(const GeminiLoginPageState.loading());
      final response = await _authenticationService.login(email, password);
      if (!response.isSuccessful) {
        _handler.handleLoginFailure(response.failure!);
        return emit(GeminiLoginPageState.error(response.failure!.reason));
      }

      _handler.handleLoginResponse(response.content!);
      emit(const GeminiLoginPageState.initial());
    } catch (e) {
      return emit(const GeminiLoginPageState.error('Unknown error occurred'));
    } finally {
      emit(const GeminiLoginPageState.initial());
    }
  }
}
