import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/phone_controller.dart';

class CopyButtonWidget extends StatefulWidget {
  final PhoneController controller;
  final IconData icon;
  final String? copiedMessage;

  const CopyButtonWidget({
    super.key,
    required this.controller,
    this.icon = Icons.copy,
    this.copiedMessage,
  });

  @override
  State<CopyButtonWidget> createState() => _CopyButtonWidgetState();
}

class _CopyButtonWidgetState extends State<CopyButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _copied = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _copyToClipboard() async {
    final phoneNumber = widget.controller.value;

    if (phoneNumber.isEmpty) return;

    await _controller.forward();
    await _controller.reverse();

    await Clipboard.setData(ClipboardData(text: phoneNumber.international));

    setState(() => _copied = true);

    if (mounted) {
      final message =
          widget.copiedMessage ?? 'Copied: ${phoneNumber.international}';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(child: Text(message)),
            ],
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
        ),
      );
    }

    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() => _copied = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller,
      builder: (context, phoneNumber, child) {
        if (phoneNumber.isEmpty) {
          return const SizedBox.shrink();
        }

        return ScaleTransition(
          scale: _scaleAnimation,
          child: IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                _copied ? Icons.check : widget.icon,
                key: ValueKey(_copied),
                color: _copied ? Colors.green : Colors.grey[600],
                size: 20,
              ),
            ),
            tooltip: _copied ? 'Copied!' : 'Copy number',
            onPressed: _copyToClipboard,
          ),
        );
      },
    );
  }
}
