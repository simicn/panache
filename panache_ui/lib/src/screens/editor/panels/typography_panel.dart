import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import '../controls/text_style_control.dart';

class TypographyThemePanel extends StatelessWidget {
  final TextTheme txtTheme;
  final String themeRef;
  final ThemeModel model;

  const TypographyThemePanel({
    Key key,
    @required this.txtTheme,
    @required this.themeRef,
    @required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.grey.shade200,
        padding: kPadding,
        child: Column(
          children: _buildTextThemeEditorFields(model),
        ),
      );

  List<Widget> _buildTextThemeEditorFields(ThemeModel model) {
    final headline6 = txtTheme.headline6;
    final headline5 = txtTheme.headline5;
    final headline4 = txtTheme.headline4;
    final headline3 = txtTheme.headline3;
    final headline2 = txtTheme.headline2;
    final headline1 = txtTheme.headline1;
    final subtitle1 = txtTheme.subtitle1;
    final subtitle2 = txtTheme.subtitle2;
    final bodyText2 = txtTheme.bodyText2;
    final bodyText1 = txtTheme.bodyText1;
    final caption = txtTheme.caption;
    final overline = txtTheme.overline;
    final button = txtTheme.button;

    final styleNames = [
      TextStyleControlData(styleName: 'headline6', style: headline6),
      TextStyleControlData(styleName: 'headline5', style: headline5),
      TextStyleControlData(styleName: 'headline4', style: headline4),
      TextStyleControlData(styleName: 'headline3', style: headline3),
      TextStyleControlData(styleName: 'headline2', style: headline2),
      TextStyleControlData(styleName: 'headline1', style: headline1),
      TextStyleControlData(styleName: 'subtitle1', style: subtitle1),
      TextStyleControlData(styleName: 'subtitle2', style: subtitle2),
      TextStyleControlData(styleName: 'bodyText2', style: bodyText2),
      TextStyleControlData(styleName: 'bodyText1', style: bodyText1),
      TextStyleControlData(styleName: 'caption', style: caption),
      TextStyleControlData(styleName: 'overline', style: overline),
      TextStyleControlData(styleName: 'button', style: button),
    ];

    return styleNames.map((data) {
      return TextStyleControl(
        data.styleName,
        style: data.style,
        onColorChanged: (color) =>
            apply(data.style.copyWith(color: color), data.styleName),
        onSizeChanged: (size) {
          print(
              'TypographyThemePanel._buildTextThemeEditorFields... $size ${data.style}');
          apply(data.style.copyWith(fontSize: size), data.styleName);
        },
        onWeightChanged: (isBold) => apply(
          data.style.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          data.styleName,
        ),
        onFontStyleChanged: (isItalic) => apply(
          data.style.copyWith(
              fontStyle: isItalic ? FontStyle.italic : FontStyle.normal),
          data.styleName,
        ),
        onLetterSpacingChanged: (double spacing) =>
            apply(data.style.copyWith(letterSpacing: spacing), data.styleName),
        onWordSpacingChanged: (double spacing) =>
            apply(data.style.copyWith(wordSpacing: spacing), data.styleName),
        onLineHeightChanged: (double lineHeight) =>
            apply(data.style.copyWith(height: lineHeight), data.styleName),
        onDecorationChanged: (TextDecoration decoration) =>
            apply(data.style.copyWith(decoration: decoration), data.styleName),
        onDecorationStyleChanged: (TextDecorationStyle decorationStyle) =>
            apply(data.style.copyWith(decorationStyle: decorationStyle),
                data.styleName),
        onDecorationColorChanged: (Color color) =>
            apply(data.style.copyWith(decorationColor: color), data.styleName),
      );
    }).toList();
  }

  void apply(TextStyle style, String styleName) {
    final styleArgs = <Symbol, dynamic>{};
    styleArgs[Symbol(styleName)] = style;

    final args = <Symbol, dynamic>{};
    args[Symbol(themeRef)] = Function.apply(txtTheme.copyWith, null, styleArgs);
    model.updateTheme(Function.apply(model.theme.copyWith, null, args));
  }
}

class TextStyleControlData {
  final TextStyle style;
  final String styleName;

  TextStyleControlData({this.style, this.styleName});
}
