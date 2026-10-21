import 'package:flutter/material.dart';

/// Jewel-tone palette carried over from the original design.
abstract final class JewelColors {
  static const sapphire = Color(0xFF2980B9);
  static const emerald = Color(0xFF2ECC71);
  static const amethyst = Color(0xFF9B59B6);
  static const ruby = Color(0xFFC0392B);
  static const topaz = Color(0xFFF39C12);

  /// Distinct marker/accent colors for participants, in order.
  static const List<Color> participants = [sapphire, emerald, amethyst, topaz];

  static Color forParticipant(int index) =>
      participants[index % participants.length];
}

abstract final class AppTheme {
  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: JewelColors.sapphire,
      brightness: brightness,
      primary: brightness == Brightness.light ? JewelColors.sapphire : null,
      secondary: JewelColors.emerald,
      tertiary: JewelColors.amethyst,
      error: JewelColors.ruby,
    );
    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
      ),
      cardTheme: CardThemeData(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
