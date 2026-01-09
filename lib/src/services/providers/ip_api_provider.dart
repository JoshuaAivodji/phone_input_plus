abstract class IpApiProvider {
  /// Provider name (for debugging)
  String get name;

  /// API URL
  String get apiUrl;

  /// Request timeout
  Duration get timeout => const Duration(seconds: 5);

  /// Fetches the country code (ISO 3166-1 alpha-2)
  /// Returns null if it fails
  Future<String?> fetchCountryCode();
}
