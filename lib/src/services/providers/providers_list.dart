import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ip_api_provider.dart';

/// Provider ipapi.co
class IpApiCoProvider implements IpApiProvider {
  @override
  String get name => 'ipapi.co';

  @override
  String get apiUrl => 'https://ipapi.co/json/';

  @override
  Future<String?> fetchCountryCode() async {
    try {
      final headers = {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
      };

      final response = await http
          .get(Uri.parse(apiUrl), headers: headers)
          .timeout(timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return data['country'] as String?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Duration get timeout => Duration(seconds: 5);
}

/// Provider ipinfo.io
class IpInfoProvider implements IpApiProvider {
  @override
  String get name => 'ipinfo.io';

  @override
  String get apiUrl => 'https://ipinfo.io/json';

  @override
  Duration get timeout => Duration(seconds: 5);

  @override
  Future<String?> fetchCountryCode() async {
    try {
      final headers = {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
      };

      final response = await http
          .get(Uri.parse(apiUrl), headers: headers)
          .timeout(timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return data['country'] as String?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

/// Provider ip-api.com
class IpApiComProvider implements IpApiProvider {
  @override
  String get name => 'ip-api.com';

  @override
  String get apiUrl => 'http://ip-api.com/json/';

  @override
  Duration get timeout => Duration(seconds: 5);

  @override
  Future<String?> fetchCountryCode() async {
    try {
      final response = await http.get(Uri.parse(apiUrl)).timeout(timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return data['countryCode'] as String?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

/// List of default providers
class DefaultProviders {
  static List<IpApiProvider> get all => [
    IpApiCoProvider(),
    IpInfoProvider(),
    IpApiComProvider(),
  ];
}
