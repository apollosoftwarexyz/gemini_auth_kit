import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_auth_kit/components/apollo_primary_button.dart';
import 'package:gemini_auth_kit/components/app_blocking_loading_view.dart';
import 'package:gemini_auth_kit/injection.dart';

import '../../abstracts/gemini_login_view_args.dart';
import '../../components.dart';
import '../../components/error_dialog.dart';
import 'gemini_login_page_cubit.dart';

class GeminiLoginPageView extends StatelessWidget {
  final GeminiLoginViewArgs args;

  const GeminiLoginPageView(
    this.args, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<GeminiLoginPageCubit>(),
      child: BlocConsumer<GeminiLoginPageCubit, GeminiLoginPageState>(
        listener: (context, state) {
          if (state.failure != null) {
            return WidgetsBinding.instance.addPostFrameCallback(
                (_) => showErrorDialog(context, state.failure!));
          }
        },
        builder: (context, state) {
          return AppBlockingLoadingView(
            isBlocking: state.isLoading,
            child: GeminiLoginView(
              args,
              onSignIn: (email, password) =>
                  context.read<GeminiLoginPageCubit>().login(email, password),
            ),
          );
        },
      ),
    );
  }
}

class GeminiLoginView extends StatefulWidget {
  final GeminiLoginViewArgs args;
  final String? failure;
  final Function(String email, String password) onSignIn;

  const GeminiLoginView(
    this.args, {
    required this.onSignIn,
    this.failure,
    Key? key,
  }) : super(key: key);

  @override
  State<GeminiLoginView> createState() => _GeminiLoginViewState();
}

class _GeminiLoginViewState extends State<GeminiLoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.args.backgroundColor,
      body: SafeArea(
        bottom: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: widget.args.maxContentWidth),
          child: Container(
            margin: widget.args.outerPadding,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.args.headerBanner,
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.failure == null
                              ? Container(height: 40)
                              : Container(
                                  height: 40,
                                  color: Colors.red,
                                  child: Text(widget.failure!),
                                ),
                          Text(
                            "Hey! 👋",
                            style: TextStyle(
                              fontFamily: "Jost",
                              fontWeight: FontWeight.bold,
                              fontSize: 42,
                              color: widget.args.fontColor,
                            ),
                          ),
                          Container(height: 10),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  color: widget.args.fontColor,
                                  fontFamily: "Jost",
                                  fontSize: 18),
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'Please sign in to access',
                                ),
                                TextSpan(
                                  text: " ${widget.args.appName} ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                    text:
                                        'with your ${widget.args.brandName} account.')
                              ],
                            ),
                          ),
                          Container(height: 30),
                          Text(
                            "E-mail address:",
                            style: TextStyle(
                              fontFamily: "Jost",
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                              fontSize: 16,
                            ),
                          ),
                          Container(height: 7.5),
                          ApolloInputField(
                            controller: emailController,
                            hintText: widget.args.emailHintText,
                            validator: widget.args.emailValidator,
                          ),
                          Container(height: 10),
                          Text("Password:",
                              style: TextStyle(
                                fontFamily: "Jost",
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900],
                                fontSize: 16,
                              )),
                          Container(height: 7.5),
                          ApolloInputField(
                            controller: passwordController,
                            hintText: widget.args.passwordHintText,
                            obscureText: true,
                            validator: widget.args.passwordValidator,
                          ),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: const Text(
                                "Forgotten your password?",
                                style: TextStyle(
                                  color: Color(0xFF8147ff),
                                  fontFamily: "Jost",
                                  fontSize: 15,
                                ),
                              ),
                              onTap: () {}),
                        ],
                      )),
                  Container(height: 30),
                  ApolloPrimaryButton(
                      text: 'Sign in to ${widget.args.appName}',
                      onPressed: () => widget.onSignIn(
                          emailController.text, passwordController.text)),
                  Container(height: 20),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {},
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            color: widget.args.fontColor,
                            fontFamily: "Jost",
                            fontSize: 14),
                        children: const <TextSpan>[
                          TextSpan(
                            text: "Don't have an account yet?",
                          ),
                          TextSpan(
                              text: ' Sign Up',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF8147ff))),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
