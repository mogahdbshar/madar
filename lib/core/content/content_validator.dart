import 'dart:convert';
import 'package:crypto/crypto.dart';

class ContentValidator {
  const ContentValidator._();

  static String sha256OfBytes(List<int> bytes) =>
      sha256.convert(bytes).toString();

  static bool hasRequiredProvenance({
    required String sourceId,
    required String reference,
    required String license,
  }) =>
      sourceId.trim().isNotEmpty &&
      reference.trim().isNotEmpty &&
      license.trim().isNotEmpty;

  static bool isValidJsonPackage(String raw) {
    try {
      return jsonDecode(raw) is Map<String, dynamic>;
    } catch (_) {
      return false;
    }
  }

  static bool matchesSha256(List<int> bytes, String expected) =>
      sha256OfBytes(bytes).toLowerCase() == expected.trim().toLowerCase();
}
