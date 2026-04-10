import 'package:flutter/foundation.dart';
import 'package:forui/forui.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = false; // Default to dark as in main.dart

  bool get isDark => _isDark;

  FThemeData get themeData =>
      _isDark ? FThemes.neutral.dark.touch : FThemes.neutral.light.touch;

  void toggle() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
