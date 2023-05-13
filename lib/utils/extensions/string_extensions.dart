import 'dart:ui';

extension ColorParsing on String? {
  Color parseToColor() => Color(int.parse('0xff$this'));
}
