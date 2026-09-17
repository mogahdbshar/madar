import 'package:flutter/material.dart';

abstract final class MadarShapes {
  static const card = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(24)),
  );
  static const sheet = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
  );
}
