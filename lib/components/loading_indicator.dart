import 'package:flutter/material.dart';

import 'loading_spinner.dart';

class LoadingIndicator extends StatelessWidget {
  final String? text;
  final String? semanticSpinnerLabel;
  final Color activeColor;
  final Color inactiveColor;

  /// Creates branded loading status indicator
  const LoadingIndicator({
    Key? key,
    this.text,
    this.semanticSpinnerLabel,
    required this.activeColor,
    required this.inactiveColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Semantics(
            label: 'Loading',
            child: LoadingSpinner(
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
          ),
          if (text?.isNotEmpty == true) ...[
            Container(
              margin: const EdgeInsets.only(top: 12),
              child: Text(
                text!,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
