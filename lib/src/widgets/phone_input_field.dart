import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/country.dart';
import '../controllers/phone_controller.dart';
import '../core/phone_number.dart';
import '../core/country_data.dart';
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

  final TextInputType keyboardType;

  /// Locale for country names
  final String locale;

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
    this.keyboardType = TextInputType.phone,
    this.locale = 'en',
  });

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  late PhoneController _controller;
  late TextEditingController _textController;
  late FocusNode _focusNode;
  late List<Country> _availableCountries;
  bool _isInternalUpdate = false;
  bool _isDetecting = false;

  bool get _isControllerProvided => widget.controller != null;

  @override
  void initState() {
    super.initState();
    _initializeCountries();
    _initializeController();
    _initializeFocusNode();
    _initializeTextController();

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

  void _onTextChanged(String text) {
    if (_isInternalUpdate) {
      return;
    }

    var cleanText = text.replaceAll(RegExp(r'[^\d]'), '');

    if (_controller.country.code == 'FR' && cleanText.startsWith('0')) {
      cleanText = cleanText.substring(1);
    }

    _controller.updateNumber(cleanText);
  }

  void _onControllerChanged() {
    if (_isInternalUpdate) {
      return;
    }

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
    if (widget.validator != null) {
      return widget.validator!(_controller.value);
    }
    return null;
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
    _textController.dispose();

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
    return TextFormField(
      controller: _textController,
      focusNode: _focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      autovalidateMode: widget.autovalidateMode,
      validator: _validate,
      onChanged: _onTextChanged,
      onFieldSubmitted: _onSubmitted,
      decoration: (widget.decoration ?? const InputDecoration()).copyWith(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 8, right: 4),
          child: ValueListenableBuilder<PhoneNumber>(
            valueListenable: _controller,
            builder: (context, phoneNumber, child) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isDetecting)
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  else
                    CountryButton(
                      country: phoneNumber.country,
                      onPressed: _onCountryButtonPressed,
                      style:
                          widget.countryButtonStyle ??
                          const CountryButtonStyle(),
                      enabled: widget.enabled && !widget.readOnly,
                    ),
                  Container(
                    height: 24,
                    width: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Theme.of(context).dividerColor,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
