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
      final value = jsonDecode(raw);
      return value is Map<String, dynamic>;
    } catch (_) {
      return false;
    }
  }
}
