import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'color_x.dart';
import 'theme_data_x.dart';

typedef ThemePair = ({ThemeData lightTheme, ThemeData darkTheme});

const _lightBase = Colors.white;
final _darkBase = Colors.black.scale(lightness: 0.09);
final _darkMenuBase = Colors.black.scale(lightness: 0.07);
const _kContainerRadius = 10.0;
final _kButtonHeight = isDesktop ? 42.0 : 48.0;
final _kButtonRadius = _kButtonHeight / 2;
const _kMenuRadius = 8.0;
const _kInputDecorationRadius = 6.0;

ThemePair phoenixTheme({
  required Color color,
  double? buttonRadius,
  double? buttonHeight,
}) {
  final darkScheme = _darkScheme(color);
  final lightScheme = _lightScheme(color);

  return (
    lightTheme: _phoenixTheme(
      colorScheme: lightScheme,
      buttonHeight: buttonHeight,
      buttonRadius: buttonRadius,
    ),
    darkTheme: _phoenixTheme(
      colorScheme: darkScheme,
      buttonHeight: buttonHeight,
      buttonRadius: buttonRadius,
    )
  );
}

ThemeData _phoenixTheme({
  required ColorScheme colorScheme,
  double? buttonRadius,
  double? buttonHeight,
}) {
  final buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(buttonRadius ?? _kButtonRadius),
  );

  final buttonSize = Size(1, buttonHeight ?? _kButtonHeight);

  return ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    splashFactory: NoSplash.splashFactory,
    dividerColor: _dividerColor(colorScheme),
    cardColor: _cardColor(colorScheme),
    menuTheme: _menuTheme(colorScheme),
    popupMenuTheme: _popupMenuTheme(colorScheme),
    dialogTheme: _dialogTheme(colorScheme),
    dialogBackgroundColor: _menuBg(colorScheme),
    dropdownMenuTheme: _dropdownMenuTheme(colorScheme),
    sliderTheme: _sliderTheme(colorScheme),
    dividerTheme: _dividerTheme(colorScheme),
    progressIndicatorTheme: _progressIndicatorTheme(colorScheme),
    switchTheme: _switchTheme(colorScheme),
    checkboxTheme: _checkBoxTheme(colorScheme),
    floatingActionButtonTheme: _floatingActionButtonTheme(colorScheme),
    elevatedButtonTheme: _elevatedButtonTheme(
      colorScheme: colorScheme,
      buttonShape: buttonShape,
      buttonSize: buttonSize,
    ),
    outlinedButtonTheme: _outlinedButtonThemeData(
      colorScheme: colorScheme,
      buttonShape: buttonShape,
      buttonSize: buttonSize,
    ),
    filledButtonTheme: _filledButtonThemeData(
      colorScheme: colorScheme,
      buttonShape: buttonShape,
      buttonSize: buttonSize,
    ),
    textButtonTheme: _textButtonThemeData(
      colorScheme: colorScheme,
      buttonShape: buttonShape,
      buttonSize: buttonSize,
    ),
    navigationRailTheme: _naviRailTheme(colorScheme),
    navigationBarTheme: _naviBarTheme(colorScheme),
    appBarTheme: _appBarTheme(colorScheme),
    snackBarTheme: _snackBarThemeData(colorScheme),
    cardTheme: _cardTheme(colorScheme),
    drawerTheme: _drawerTheme(colorScheme),
    inputDecorationTheme: _inputDecorationTheme(colorScheme),
  );
}

ColorScheme _darkScheme(Color color) {
  return ColorScheme.fromSeed(
    seedColor: color,
    brightness: Brightness.dark,
    surfaceTint: _darkBase,
    surface: _darkBase,
    // ignore: deprecated_member_use
    background: _darkBase,
    outline: _darkBase.scale(lightness: 0.28),
  );
}

ColorScheme _lightScheme(Color color) {
  return ColorScheme.fromSeed(
    seedColor: color,
    brightness: Brightness.light,
    surface: _lightBase,
    surfaceTint: _lightBase,
    outline: Colors.white.scale(lightness: -0.3),
  );
}

DividerThemeData _dividerTheme(ColorScheme colorScheme) => DividerThemeData(
      color: _dividerColor(colorScheme),
      space: 1.0,
      thickness: 1.0,
    );

Color _dividerColor(ColorScheme colorScheme) {
  return colorScheme.outline.scale(lightness: colorScheme.isLight ? 0.3 : -0.4);
}

DialogTheme _dialogTheme(ColorScheme colorScheme) {
  final bgColor = _menuBg(colorScheme);
  return DialogTheme(
    backgroundColor: bgColor,
    surfaceTintColor: bgColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_kContainerRadius),
      side: colorScheme.isLight
          ? BorderSide.none
          : BorderSide(
              color: Colors.white.withOpacity(0.2),
            ),
    ),
  );
}

CardTheme _cardTheme(ColorScheme colorScheme) {
  return CardTheme(
    color: _cardColor(colorScheme),
  );
}

Color _cardColor(ColorScheme colorScheme) {
  return colorScheme.surface.scale(
    lightness: colorScheme.isLight ? -0.06 : 0.05,
  );
}

PopupMenuThemeData _popupMenuTheme(ColorScheme colorScheme) {
  final bgColor = _menuBg(colorScheme);
  return PopupMenuThemeData(
    color: bgColor,
    surfaceTintColor: bgColor,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(_kContainerRadius),
      borderSide: BorderSide(
        color: colorScheme.onSurface.withOpacity(
          colorScheme.isLight ? 0.3 : 0.2,
        ),
        width: 1,
      ),
    ),
  );
}

MenuStyle _menuStyle(ColorScheme colorScheme) {
  final bgColor = _menuBg(colorScheme);

  return MenuStyle(
    surfaceTintColor: WidgetStateColor.resolveWith((states) => bgColor),
    shape: WidgetStateProperty.resolveWith(
      (states) => RoundedRectangleBorder(
        side: BorderSide(
          color: colorScheme.onSurface.withOpacity(
            colorScheme.isLight ? 0.3 : 0.2,
          ),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(_kMenuRadius),
      ),
    ),
    side: WidgetStateBorderSide.resolveWith(
      (states) => BorderSide(
        color: colorScheme.onSurface.withOpacity(
          colorScheme.isLight ? 0.3 : 0.2,
        ),
        width: 1,
      ),
    ),
    elevation: WidgetStateProperty.resolveWith((states) => 1),
    backgroundColor: WidgetStateProperty.resolveWith((states) => bgColor),
  );
}

Color _menuBg(ColorScheme colorScheme) =>
    colorScheme.isLight ? _lightBase : _darkMenuBase;

MenuThemeData _menuTheme(ColorScheme colorScheme) {
  return MenuThemeData(
    style: _menuStyle(colorScheme),
  );
}

DropdownMenuThemeData _dropdownMenuTheme(ColorScheme colorScheme) {
  return DropdownMenuThemeData(
    menuStyle: _menuStyle(colorScheme),
  );
}

SliderThemeData _sliderTheme(ColorScheme colorScheme) {
  return SliderThemeData(
    overlayShape: const RoundSliderOverlayShape(
      overlayRadius: 13,
    ),
    overlayColor:
        colorScheme.primary.withOpacity(colorScheme.isLight ? 0.4 : 0.7),
    inactiveTrackColor: colorScheme.primary.withOpacity(0.5),
    trackShape: CustomTrackShape(),
  );
}

InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
  return InputDecorationTheme(
    isDense: isDesktop ? true : false,
    filled: true,
    fillColor: colorScheme.surface
        .scale(lightness: colorScheme.isLight ? -0.07 : 0.03),
    border: _inputBorder(colorScheme: colorScheme),
    enabledBorder: _inputBorder(
      colorScheme: colorScheme,
    ),
    focusedBorder: _inputBorder(
      colorScheme: colorScheme,
      state: WidgetState.focused,
    ),
  );
}

OutlineInputBorder _inputBorder({
  required ColorScheme colorScheme,
  WidgetState? state,
}) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      color: switch (state) {
        WidgetState.focused => colorScheme.primary,
        WidgetState.hovered => colorScheme.primary,
        _ =>
          colorScheme.outline.scale(lightness: colorScheme.isLight ? 0 : 0.1),
      },
    ),
    borderRadius:
        const BorderRadius.all(Radius.circular(_kInputDecorationRadius)),
  );
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 0,
  }) {
    super.paint(
      context,
      offset,
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      enableAnimation: enableAnimation,
      textDirection: textDirection,
      thumbCenter: thumbCenter,
      isDiscrete: isDiscrete,
      isEnabled: isEnabled,
      additionalActiveTrackHeight: 0,
    );
  }
}

SwitchThemeData _switchTheme(ColorScheme colorScheme) {
  return SwitchThemeData(
    trackOutlineColor: WidgetStateColor.resolveWith(
      (states) => switch (states.toList()) {
        [WidgetState.disabled] ||
        [WidgetState.disabled, WidgetState.selected] =>
          colorScheme.onSurface.withOpacity(0.3),
        _ => colorScheme.primary,
      },
    ),
    thumbColor: WidgetStateProperty.resolveWith(
      (states) => _getSwitchThumbColor(states, colorScheme),
    ),
    trackColor: WidgetStateProperty.resolveWith(
      (states) => _getSwitchTrackColor(states, colorScheme),
    ),
  );
}

Color _getSwitchThumbColor(Set<WidgetState> states, ColorScheme colorScheme) {
  if (states.contains(WidgetState.disabled)) {
    if (states.contains(WidgetState.selected)) {
      return colorScheme.onSurface.withOpacity(0.5);
    }
    return colorScheme.onSurface.withOpacity(0.5);
  } else {
    return colorScheme.isLight ? colorScheme.primary : colorScheme.primaryFixed;
  }
}

Color _getSwitchTrackColor(Set<WidgetState> states, ColorScheme colorScheme) {
  return switch (states.toList()) {
    [WidgetState.disabled] ||
    [WidgetState.disabled, WidgetState.selected] =>
      colorScheme.onSurface.withOpacity(0.3),
    [WidgetState.hovered] => Colors.transparent,
    [] => colorScheme.surface,
    _ => colorScheme.primaryContainer,
  };
}

CheckboxThemeData _checkBoxTheme(ColorScheme colorScheme) {
  return CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
  );
}

ProgressIndicatorThemeData _progressIndicatorTheme(ColorScheme colorScheme) {
  return ProgressIndicatorThemeData(
    circularTrackColor: colorScheme.primary.withOpacity(0.4),
    linearTrackColor: colorScheme.primary.withOpacity(0.4),
  );
}

FloatingActionButtonThemeData _floatingActionButtonTheme(
  ColorScheme colorScheme,
) {
  const elevation = 1.0;
  return FloatingActionButtonThemeData(
    elevation: elevation,
    focusElevation: elevation,
    hoverElevation: elevation,
    disabledElevation: elevation,
    highlightElevation: elevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  );
}

ElevatedButtonThemeData _elevatedButtonTheme({
  required ColorScheme colorScheme,
  required Size buttonSize,
  required RoundedRectangleBorder buttonShape,
}) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: buttonShape,
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.primary.contrastColor,
      minimumSize: buttonSize,
    ),
  );
}

OutlinedButtonThemeData _outlinedButtonThemeData({
  required ColorScheme colorScheme,
  required Size buttonSize,
  required RoundedRectangleBorder buttonShape,
}) {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: buttonShape,
      minimumSize: buttonSize,
      backgroundColor: colorScheme.primary.withOpacity(0.03),
      side: BorderSide(
        color: colorScheme.primary.withOpacity(0.4),
      ),
    ),
  );
}

FilledButtonThemeData _filledButtonThemeData({
  required ColorScheme colorScheme,
  required Size buttonSize,
  required RoundedRectangleBorder buttonShape,
}) {
  return FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: buttonShape,
      minimumSize: buttonSize,
    ),
  );
}

TextButtonThemeData _textButtonThemeData({
  required ColorScheme colorScheme,
  required Size buttonSize,
  required RoundedRectangleBorder buttonShape,
}) {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: buttonShape,
      minimumSize: buttonSize,
    ),
  );
}

NavigationRailThemeData _naviRailTheme(ColorScheme colorScheme) {
  return NavigationRailThemeData(
    indicatorColor: _indicatorColor(colorScheme),
  );
}

NavigationBarThemeData _naviBarTheme(ColorScheme colorScheme) {
  return NavigationBarThemeData(
    indicatorColor: _indicatorColor(colorScheme),
    backgroundColor: colorScheme.surface,
  );
}

Color _indicatorColor(ColorScheme colorScheme) =>
    _dividerColor(colorScheme).withOpacity(0.8);

AppBarTheme _appBarTheme(ColorScheme colorScheme) {
  return AppBarTheme(
    backgroundColor: colorScheme.surface,
    surfaceTintColor: colorScheme.surface,
  );
}

DrawerThemeData _drawerTheme(ColorScheme colorScheme) {
  return DrawerThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadiusDirectional.only(
        topEnd: Radius.circular(_kContainerRadius),
        bottomEnd: Radius.circular(_kContainerRadius),
      ),
      side: colorScheme.isLight
          ? BorderSide.none
          : BorderSide(
              color: _dividerColor(colorScheme),
            ),
    ),
    backgroundColor: colorScheme.surface,
  );
}

SnackBarThemeData _snackBarThemeData(ColorScheme colorScheme) {
  return SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    actionTextColor: colorScheme.primary.scale(
      saturation: 0.5,
      lightness: (colorScheme.isLight ? 0.2 : -0.5),
    ),
  );
}

bool get isMobile =>
    !kIsWeb && Platform.isAndroid || Platform.isIOS || Platform.isFuchsia;

bool get isDesktop =>
    !kIsWeb && (Platform.isLinux || Platform.isMacOS || Platform.isWindows);
