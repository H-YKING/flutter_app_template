import 'package:flutter/material.dart';

import 'Colors.dart';

class Styles {}

class TextStyles {
  static const TextStyle textSize12 = const TextStyle(
    fontSize: 12,
  );
  static const TextStyle textSize16 = const TextStyle(
    fontSize: 16,
  );
  static const TextStyle textBold14 =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  static const TextStyle textBold16 =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static const TextStyle textBold18 =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static const TextStyle textBold24 =
      const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);
  static const TextStyle textBold26 =
      const TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold);

  static const TextStyle textWhite14 = const TextStyle(
    fontSize: 14,
    color: Colors.white,
  );

  static const TextStyle text = const TextStyle(
      fontSize: 14,
      color: Colours.text,
      // https://github.com/flutter/flutter/issues/40248
      textBaseline: TextBaseline.alphabetic);

  static const TextStyle textTitle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      textBaseline: TextBaseline.alphabetic);

  static const TextStyle textSubTitle = const TextStyle(fontSize: 12);

  static const TextStyle textDark = const TextStyle(
      fontSize: 14,
      color: Colours.dark_text,
      textBaseline: TextBaseline.alphabetic);

  static const TextStyle textHint14 =
      const TextStyle(fontSize: 14, color: Colours.dark_text_sub_title);
}
