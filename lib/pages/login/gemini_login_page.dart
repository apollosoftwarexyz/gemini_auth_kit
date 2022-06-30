import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_auth_kit/components/apollo_primary_button.dart';
import 'package:gemini_auth_kit/components/app_blocking_loading_view.dart';
import 'package:gemini_auth_kit/injection.dart';

import '../../components.dart';
import '../../components/error_dialog.dart';
import 'gemini_login_page_cubit.dart';

class GeminiLoginPage extends StatelessWidget {
  final String appName;
  final String brandName;

  final Color backgroundColor;
  final Color primaryColor;
  final Color fontColor;
  final bool isLoading;

  final double maxContentWidth;
  final double headerPadding;
  final EdgeInsets outerPadding;

  final Widget headerBanner;

  final String? Function(String? text)? emailValidator;
  final String? Function(String? text)? passwordValidator;
  final String emailHintText;
  final String passwordHintText;

  const GeminiLoginPage({
    this.appName = 'Unknown Application',
    this.brandName = 'Unknown Brand',
    this.isLoading = false,
    this.backgroundColor = const Color(0xFFF9F9F9),
    this.primaryColor = const Color(0xFF7440F6),
    this.fontColor = const Color(0xFF0D0D0D),
    this.maxContentWidth = 450,
    this.headerPadding = 90,
    this.outerPadding = const EdgeInsets.only(top: 90),
    this.headerBanner = const SizedBox.shrink(),
    this.emailValidator,
    this.passwordValidator,
    this.emailHintText = 'joebloggs@gmail.com',
    this.passwordHintText = '*********',
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
              onSignIn: (email, password) =>
                  context.read<GeminiLoginPageCubit>().login(email, password),
              appName: appName,
              brandName: brandName,
              isLoading: isLoading,
              backgroundColor: backgroundColor,
              primaryColor: primaryColor,
              fontColor: fontColor,
              maxContentWidth: maxContentWidth,
              headerPadding: headerPadding,
              outerPadding: outerPadding,
              headerBanner: headerBanner,
              emailValidator: emailValidator,
              passwordValidator: passwordValidator,
              emailHintText: emailHintText,
              passwordHintText: passwordHintText,
              failure: state.failure,
            ),
          );
        },
      ),
    );
  }
}

class GeminiLoginView extends StatefulWidget {
  final Function(String email, String password) onSignIn;
  final String appName;
  final String brandName;

  final Color backgroundColor;
  final Color primaryColor;
  final Color fontColor;
  final bool isLoading;

  final double maxContentWidth;
  final double headerPadding;
  final EdgeInsets outerPadding;

  final Widget headerBanner;

  final String? Function(String? text)? emailValidator;
  final String? Function(String? text)? passwordValidator;
  final String emailHintText;
  final String passwordHintText;
  final String? failure;

  const GeminiLoginView({
    required this.onSignIn,
    this.appName = 'Unknown Application',
    this.brandName = 'Unknown Brand',
    this.isLoading = false,
    this.backgroundColor = const Color(0xFFF9F9F9),
    this.primaryColor = const Color(0xFF7440F6),
    this.fontColor = const Color(0xFF0D0D0D),
    this.maxContentWidth = 450,
    this.headerPadding = 90,
    this.outerPadding = const EdgeInsets.only(top: 90),
    this.headerBanner = const SizedBox.shrink(),
    this.emailValidator,
    this.passwordValidator,
    this.emailHintText = 'joebloggs@gmail.com',
    this.passwordHintText = '*********',
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
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        bottom: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: widget.maxContentWidth),
          child: Container(
            margin: widget.outerPadding,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.headerBanner,
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
                              color: widget.fontColor,
                            ),
                          ),
                          Container(height: 10),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  color: widget.fontColor,
                                  fontFamily: "Jost",
                                  fontSize: 18),
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'Please sign in to access',
                                ),
                                TextSpan(
                                  text: " ${widget.appName} ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                    text:
                                        'with your ${widget.brandName} account.')
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
                            hintText: widget.emailHintText,
                            validator: widget.emailValidator,
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
                            hintText: widget.passwordHintText,
                            obscureText: true,
                            validator: widget.passwordValidator,
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
                      text: 'Sign in to ${widget.appName}',
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
                            color: widget.fontColor,
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
