import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      return '.env.production';
    }

      return '.env.development';
  }

  static String get googleApiKey {
    return dotenv.env['GOOGLE_API_KEY'] ?? 'API_KEY not found';
  }

   static String get googleApiKey2 {
    return dotenv.env['GOOGLE_API_KEY2'] ?? 'API_KEY not found';
  }

    static String get appBaseUrl {
    return dotenv.env['API_BASE_URL'] ?? 'API_BASE_URL not found';
  }

   static String get paymentUrl {
    return dotenv.env['PAYMENT_URL'] ?? 'PAYMENT_BASE_URL not found';
  }
}
