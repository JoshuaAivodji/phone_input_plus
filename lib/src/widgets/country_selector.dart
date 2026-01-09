import 'package:flutter/material.dart';
import '../models/country.dart';
import '../core/country_data.dart';

enum CountrySelectorType { bottomSheet, dialog, page }

class CountrySelectorConfig {
  /// Selector type
  final CountrySelectorType type;

  /// Selector title
  final String? title;

  /// Search bar placeholder
  final String? searchHint;

  /// Show search bar?
  final bool showSearch;

  /// Locale for country names (en/fr)
  final String locale;

  /// Custom style
  final CountrySelectorStyle? style;

  /// BottomSheet height (if type = bottomSheet)
  final double? bottomSheetHeight;

  const CountrySelectorConfig({
    this.type = CountrySelectorType.bottomSheet,
    this.title,
    this.searchHint,
    this.showSearch = true,
    this.locale = 'en',
    this.style,
    this.bottomSheetHeight,
  });
}

class CountrySelectorStyle {
  final TextStyle? titleStyle;
  final TextStyle? searchStyle;
  final TextStyle? countryNameStyle;
  final TextStyle? dialCodeStyle;
  final Color? backgroundColor;
  final double itemHeight;
  final EdgeInsetsGeometry? itemPadding;

  const CountrySelectorStyle({
    this.titleStyle,
    this.searchStyle,
    this.countryNameStyle,
    this.dialCodeStyle,
    this.backgroundColor,
    this.itemHeight = 56,
    this.itemPadding,
  });
}

/// Displays the country selector and returns the selected country
Future<Country?> showCountrySelector({
  required BuildContext context,
  required List<Country> countries,
  Country? selectedCountry,
  CountrySelectorConfig config = const CountrySelectorConfig(),
}) {
  switch (config.type) {
    case CountrySelectorType.bottomSheet:
      return _showBottomSheet(context, countries, selectedCountry, config);
    case CountrySelectorType.dialog:
      return _showDialog(context, countries, selectedCountry, config);
    case CountrySelectorType.page:
      return _showPage(context, countries, selectedCountry, config);
  }
}

Future<Country?> _showBottomSheet(
  BuildContext context,
  List<Country> countries,
  Country? selectedCountry,
  CountrySelectorConfig config,
) {
  return showModalBottomSheet<Country>(
    context: context,
    isScrollControlled: true,
    backgroundColor: config.style?.backgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => SizedBox(
      height:
          config.bottomSheetHeight ?? MediaQuery.of(context).size.height * 0.75,
      child: _CountrySelectorContent(
        countries: countries,
        selectedCountry: selectedCountry,
        config: config,
      ),
    ),
  );
}

Future<Country?> _showDialog(
  BuildContext context,
  List<Country> countries,
  Country? selectedCountry,
  CountrySelectorConfig config,
) {
  return showDialog<Country>(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: config.style?.backgroundColor,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: _CountrySelectorContent(
          countries: countries,
          selectedCountry: selectedCountry,
          config: config,
        ),
      ),
    ),
  );
}

Future<Country?> _showPage(
  BuildContext context,
  List<Country> countries,
  Country? selectedCountry,
  CountrySelectorConfig config,
) {
  return Navigator.of(context).push<Country>(
    MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: Text(config.title ?? 'Select Country')),
        body: _CountrySelectorContent(
          countries: countries,
          selectedCountry: selectedCountry,
          config: config,
        ),
      ),
    ),
  );
}

/// Selector content
class _CountrySelectorContent extends StatefulWidget {
  final List<Country> countries;
  final Country? selectedCountry;
  final CountrySelectorConfig config;

  const _CountrySelectorContent({
    required this.countries,
    this.selectedCountry,
    required this.config,
  });

  @override
  State<_CountrySelectorContent> createState() =>
      _CountrySelectorContentState();
}

class _CountrySelectorContentState extends State<_CountrySelectorContent> {
  late List<Country> _filteredCountries;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredCountries = widget.countries;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    setState(() {
      _filteredCountries = CountryData.search(
        query,
        locale: widget.config.locale,
      ).where((country) => widget.countries.contains(country)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.config.title != null ||
            widget.config.type == CountrySelectorType.bottomSheet)
          _buildHeader(context),
        if (widget.config.showSearch) _buildSearchBar(),
        Expanded(child: _buildCountryList()),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.config.title ?? 'Select Country',
              style:
                  widget.config.style?.titleStyle ??
                  Theme.of(context).textTheme.titleLarge,
            ),
          ),
          if (widget.config.type == CountrySelectorType.bottomSheet)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        style: widget.config.style?.searchStyle,
        decoration: InputDecoration(
          hintText: widget.config.searchHint ?? 'Search countries...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                  },
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Theme.of(context).cardColor,
        ),
      ),
    );
  }

  Widget _buildCountryList() {
    if (_filteredCountries.isEmpty) {
      return Center(
        child: Text(
          'No countries found',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return ListView.builder(
      itemCount: _filteredCountries.length,
      itemBuilder: (context, index) {
        final country = _filteredCountries[index];
        final isSelected = country == widget.selectedCountry;

        return _CountryListItem(
          country: country,
          isSelected: isSelected,
          locale: widget.config.locale,
          style: widget.config.style,
          onTap: () => Navigator.of(context).pop(country),
        );
      },
    );
  }
}

/// Country list item
class _CountryListItem extends StatelessWidget {
  final Country country;
  final bool isSelected;
  final String locale;
  final CountrySelectorStyle? style;
  final VoidCallback onTap;

  const _CountryListItem({
    required this.country,
    required this.isSelected,
    required this.locale,
    this.style,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: style?.itemHeight ?? 56,
        padding:
            style?.itemPadding ?? const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(country.flagEmoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                country.getName(locale),
                style:
                    style?.countryNameStyle ??
                    Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
              ),
            ),
            Text(
              country.dialCode,
              style:
                  style?.dialCodeStyle ??
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Icon(Icons.check, color: Theme.of(context).primaryColor),
            ],
          ],
        ),
      ),
    );
  }
}
