import 'package:flutter/material.dart';

class GeminiLoginViewArgs {
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

  GeminiLoginViewArgs({
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
  });
}
