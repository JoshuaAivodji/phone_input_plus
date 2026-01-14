import 'package:flutter/material.dart';
import 'package:phone_input_plus/src/core/formatter/phone_number_text_input_formatter.dart';
import 'package:phone_input_plus/src/models/copy_button_position.dart';
import 'package:phone_input_plus/src/widgets/phone_input_decoration_builder.dart';
import '../core/formatter/phone_length_input_formatter.dart';
import '../models/country.dart';
import '../controllers/phone_controller.dart';
import '../core/phone_number.dart';
import '../core/country_data.dart';
import '../models/phone_input_style.dart';
import '../models/phone_input_theme.dart';
import '../services/composite_detector.dart';
import 'country_button.dart';
import 'country_selector.dart';

class PhoneInputField extends StatefulWidget {
  /// Optional controller
  final PhoneController? controller;

  /// Initial country (ignored if controller is provided)
  final Country? initialCountry;

  /// List of available countries
  final List<Country> countries;

  /// Automatic country detection at startup
  final bool autoDetect;

  /// Cache duration for detection (in hours)
  final int detectionCacheDuration;

  /// Automatic formatting while typing
  final bool autoFormat;

  /// Custom validator
  final String? Function(PhoneNumber?)? validator;

  /// Automatic validation mode
  final AutovalidateMode? autovalidateMode;

  /// Callback when the phone number changes
  final void Function(PhoneNumber)? onChanged;

  /// Callback when the country changes
  final void Function(Country)? onCountryChanged;

  /// Callback on submission (enter/done)
  final void Function(PhoneNumber)? onSubmitted;

  /// Field decoration
  final InputDecoration? decoration;

  /// Country button style
  final CountryButtonStyle? countryButtonStyle;

  /// Country selector configuration
  final CountrySelectorConfig? countrySelectorConfig;

  /// Is the field enabled?
  final bool enabled;

  /// Is the field read-only?
  final bool readOnly;

  final FocusNode? focusNode;

  final TextInputAction? textInputAction;

  /// Locale for country names
  final String locale;

  /// Enable intelligent paste detection
  final bool enablePasteDetection;

  /// Keyboard type to display
  final TextInputType? keyboardType;

  /// Predefined style for the input field
  final PhoneInputStyle? style;

  /// Custom theme configuration
  final PhoneInputTheme? theme;

  /// Show copy button to copy formatted phone number
  final bool showCopyButton;

  /// Position of the copy button
  final CopyButtonPosition copyButtonPosition;

  /// Custom copy button icon
  final IconData? copyButtonIcon;

  /// Message to show when number is copied
  final String? copiedMessage;

  const PhoneInputField({
    super.key,
    this.controller,
    this.initialCountry,
    this.countries = const [],
    this.autoDetect = true,
    this.detectionCacheDuration = 24,
    this.autoFormat = true,
    this.validator,
    this.autovalidateMode,
    this.onChanged,
    this.onCountryChanged,
    this.onSubmitted,
    this.decoration,
    this.countryButtonStyle,
    this.countrySelectorConfig,
    this.enabled = true,
    this.readOnly = false,
    this.focusNode,
    this.textInputAction,
    this.locale = 'en',
    this.enablePasteDetection = true,
    this.keyboardType,
    this.style,
    this.theme,
    this.showCopyButton = false,
    this.copyButtonPosition = CopyButtonPosition.suffix,
    this.copyButtonIcon,
    this.copiedMessage,
  });

  TextInputType get effectiveKeyboardType {
    if (keyboardType != null) return keyboardType!;
    return enablePasteDetection ? TextInputType.text : TextInputType.phone;
  }

  PhoneInputTheme get effectiveTheme {
    if (theme != null) return theme!;
    if (style != null) return PhoneInputTheme.fromStyle(style!);
    return PhoneInputTheme.standard();
  }

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField>
    with SingleTickerProviderStateMixin {
  late PhoneController _controller;
  late TextEditingController _textController;
  late FocusNode _focusNode;
  late List<Country> _availableCountries;
  late PhoneLengthInputFormatter _lengthFormatter;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  bool _isInternalUpdate = false;
  bool _isDetecting = false;
  bool _hasInteracted = false;
  String _lastText = '';

  bool get _isControllerProvided => widget.controller != null;

  @override
  void initState() {
    super.initState();
    _initializeCountries();
    _initializeController();
    _initializeFocusNode();
    _initializeTextController();
    _initializeFormatter();
    _initializeAnimations();

    if (widget.enablePasteDetection) {
      _textController.addListener(_detectPaste);
    }

    if (widget.autoDetect) {
      _detectCountry();
    }
  }

  void _initializeCountries() {
    _availableCountries = widget.countries.isEmpty
        ? CountryData.allCountries
        : widget.countries;
  }

  void _initializeController() {
    if (_isControllerProvided) {
      _controller = widget.controller!;
    } else {
      final defaultCountry = widget.initialCountry ?? _availableCountries.first;
      _controller = PhoneController(initialCountry: defaultCountry);
    }
    _controller.addListener(_onControllerChanged);
  }

  void _initializeFocusNode() {
    _focusNode = widget.focusNode ?? FocusNode();
  }

  void _initializeTextController() {
    _textController = TextEditingController(
      text: widget.autoFormat
          ? _controller.formatted
          : _controller.nationalNumber,
    );
  }

  void _initializeFormatter() {
    _lengthFormatter = PhoneLengthInputFormatter(_controller.country);
  }

  void _initializeAnimations() {
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _shakeAnimation =
        Tween<double>(
            begin: 0,
            end: 10,
          ).chain(CurveTween(curve: Curves.elasticIn)).animate(_shakeController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _shakeController.reverse();
            }
          });
  }

  Future<void> _detectCountry() async {
    if (_isDetecting) return;

    setState(() => _isDetecting = true);

    try {
      final detector = CompositeDetector(
        cacheDurationHours: widget.detectionCacheDuration,
      );

      final detectedCountry = await detector.detectCountry(_availableCountries);

      if (detectedCountry != null && mounted) {
        _controller.changeCountry(detectedCountry);
      }
    } catch (e) {
      debugPrint('[PhoneInputField] Error during detection: $e');
    } finally {
      if (mounted) {
        setState(() => _isDetecting = false);
      }
    }
  }

  void _detectPaste() {
    final currentText = _textController.text;

    if (currentText.startsWith('+') &&
        currentText.length > _lastText.length + 5) {
      debugPrint('Paste event detected via listener');
      _handlePastedInternationalNumber(currentText);
    }

    _lastText = currentText;
  }

  void _handlePastedInternationalNumber(String pastedText) {
    try {
      final cleanText = pastedText.replaceAll(RegExp(r'[^\d+]'), '');

      if (!cleanText.startsWith('+')) return;

      final phoneNumber = PhoneNumber.fromInternational(
        cleanText,
        _availableCountries,
      );

      _isInternalUpdate = true;
      _controller.setValue(phoneNumber);

      final formattedText = widget.autoFormat
          ? phoneNumber.formatted
          : phoneNumber.nationalNumber;

      _textController.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );

      _isInternalUpdate = false;

      if (widget.onCountryChanged != null) {
        widget.onCountryChanged!(phoneNumber.country);
      }

      if (widget.onChanged != null) {
        widget.onChanged!(phoneNumber);
      }

      debugPrint('Paste detected: ${phoneNumber.international}');
    } catch (e) {
      debugPrint('Unable to parse pasted number: $e');
      _isInternalUpdate = true;
      final cleanNumber = pastedText.replaceAll(RegExp(r'[^\d]'), '');
      _textController.text = cleanNumber;
      _isInternalUpdate = false;
      _controller.updateNumber(cleanNumber);
    }
  }

  void _onTextChanged(String text) {
    if (_isInternalUpdate) return;

    if (!_hasInteracted && text.isNotEmpty) {
      setState(() => _hasInteracted = true);
    }

    if (widget.enablePasteDetection &&
        text.startsWith('+') &&
        !_lastText.startsWith('+')) {
      _handlePastedInternationalNumber(text);
      return;
    }

    var cleanText = text.replaceAll(RegExp(r'[^\d]'), '');

    if (_controller.country.code == 'FR' && cleanText.startsWith('0')) {
      cleanText = cleanText.substring(1);
    }

    _controller.updateNumber(cleanText);
  }

  void _onControllerChanged() {
    if (_isInternalUpdate) return;

    _lengthFormatter.updateCountry(_controller.country);

    final newText = widget.autoFormat
        ? _controller.formatted
        : _controller.nationalNumber;

    if (_textController.text != newText) {
      _isInternalUpdate = true;
      _textController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
      _isInternalUpdate = false;
    }

    if (widget.onChanged != null) {
      widget.onChanged!(_controller.value);
    }
  }

  Future<void> _onCountryButtonPressed() async {
    if (!widget.enabled || widget.readOnly) return;

    _focusNode.unfocus();

    final selectedCountry = await showCountrySelector(
      context: context,
      countries: _availableCountries,
      selectedCountry: _controller.country,
      config:
          widget.countrySelectorConfig ??
          CountrySelectorConfig(
            title: widget.locale == 'fr'
                ? 'Sélectionner un pays'
                : 'Select Country',
            searchHint: widget.locale == 'fr' ? 'Rechercher...' : 'Search...',
            locale: widget.locale,
          ),
    );

    if (selectedCountry != null && mounted) {
      _controller.changeCountry(selectedCountry);
      if (widget.onCountryChanged != null) {
        widget.onCountryChanged!(selectedCountry);
      }
      _focusNode.requestFocus();
    }
  }

  void _onSubmitted(String value) {
    if (widget.onSubmitted != null) {
      widget.onSubmitted!(_controller.value);
    }
  }

  String? _validate(String? value) {
    final theme = widget.effectiveTheme;
    final result = widget.validator != null
        ? widget.validator!(_controller.value)
        : null;

    if (result != null && theme.enableShakeAnimation && _hasInteracted) {
      _shakeController.forward(from: 0);
    }

    return result;
  }

  @override
  void didUpdateWidget(PhoneInputField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.countries != oldWidget.countries) {
      _initializeCountries();
    }

    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller == null) {
        _controller.dispose();
      }
      _initializeController();
    }
  }

  @override
  void dispose() {
    if (widget.enablePasteDetection) {
      _textController.removeListener(_detectPaste);
    }

    _textController.dispose();
    _shakeController.dispose();

    if (widget.focusNode == null) {
      _focusNode.dispose();
    }

    if (!_isControllerProvided) {
      _controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.effectiveTheme;

    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: theme.enableShakeAnimation
              ? Offset(_shakeAnimation.value, 0)
              : Offset.zero,
          child: child,
        );
      },
      child: TextFormField(
        controller: _textController,
        focusNode: _focusNode,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        textInputAction: widget.textInputAction ?? TextInputAction.done,
        keyboardType: widget.effectiveKeyboardType,
        inputFormatters: [
          PhoneNumberTextInputFormatter(allowPlus: widget.enablePasteDetection),
          _lengthFormatter,
        ],
        autovalidateMode: widget.autovalidateMode,
        validator: _validate,
        onChanged: _onTextChanged,
        onFieldSubmitted: _onSubmitted,
        decoration: PhoneInputDecorationBuilder.build(
          userDecoration: widget.decoration,
          theme: theme,
          controller: _controller,
          isDetecting: _isDetecting,
          onCountryButtonPressed: _onCountryButtonPressed,
          focusNode: _focusNode,
          hasInteracted: _hasInteracted,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          context: context,
          countryButtonStyle: widget.countryButtonStyle,
          showCopyButton: widget.showCopyButton,
          copyButtonIcon: widget.copyButtonIcon,
          copiedMessage: widget.copiedMessage,
        ),
      ),
    );
  }
}
