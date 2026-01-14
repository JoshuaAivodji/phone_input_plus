import 'package:flutter/material.dart';

class AnimatedValidationIcon extends StatelessWidget {
  final bool isValid;
  final bool isEmpty;
  final Duration animationDuration;

  const AnimatedValidationIcon({
    super.key,
    required this.isValid,
    required this.isEmpty,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    if (isEmpty) {
      return const SizedBox.shrink();
    }

    return AnimatedSwitcher(
      duration: animationDuration,
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Icon(
        isValid ? Icons.check_circle : Icons.cancel,
        key: ValueKey(isValid),
        color: isValid ? Colors.green : Colors.red,
        size: 24,
      ),
    );
  }
}
