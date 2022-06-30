import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../abstracts/gemini_login_view_args.dart';
import '../../components/loading_indicator.dart';
import '../../injection.dart';
import 'gemini_login_loader_cubit.dart';
import 'gemini_login_page.dart';

class GeminiLoginPage extends StatelessWidget {
  const GeminiLoginPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<GeminiLoginLoaderCubit>()..load(),
      child: BlocBuilder<GeminiLoginLoaderCubit, GeminiLoginLoaderState>(
          builder: (context, state) {
        if (state.failure != null) {
          return Scaffold(
            body: Center(
              child: Text(state.failure!),
            ),
          );
        }
        if (state.isLoading) {
          return const Scaffold(
            body: Center(
              child: LoadingIndicator(
                activeColor: Colors.black,
                inactiveColor: Colors.white,
                text: 'Fetching app information from Gemini',
              ),
            ),
          );
        }

        return GeminiLoginPageView(GeminiLoginViewArgs(
          appName: state.content!.application.displayName,
          brandName: state.content!.brand.displayName,
        ));
      }),
    );
  }
}
