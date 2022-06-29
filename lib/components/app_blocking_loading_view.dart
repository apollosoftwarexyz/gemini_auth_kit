import 'package:flutter/material.dart';

import 'loading_indicator.dart';

/// A loading view that blocks the underlying view with an opaque modal barrier.
///
/// See also:
/// * [AppLoadingView], a full screen loading view
///
class AppBlockingLoadingView extends StatelessWidget {
  final String? text;
  final String? semanticSpinnerLabel;
  final bool isBlocking;
  final Widget child;
  final bool darkMode;
  final Widget? loadingIndicator;

  const AppBlockingLoadingView({
    Key? key,
    this.text,
    this.darkMode = false,
    this.semanticSpinnerLabel,
    required this.isBlocking,
    required this.child,
    this.loadingIndicator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(!isBlocking),
      child: Stack(
        children: [
          child,
          if (isBlocking) ...[
            ModalBarrier(
              color: darkMode ? Colors.grey[900]!.withOpacity(0.8) : Colors.white.withOpacity(0.8),
              dismissible: false,
            ),
            SafeArea(
              child: Center(
                child: loadingIndicator != null
                    ? loadingIndicator!
                    : LoadingIndicator(
                        text: text,
                        semanticSpinnerLabel: semanticSpinnerLabel,
                        activeColor: darkMode ? Colors.white : Colors.black,
                        inactiveColor: Colors.grey,
                      ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
