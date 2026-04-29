

import 'package:asha_pay/asha_pay.dart';

class CustomSliderThumbShape extends RoundSliderThumbShape {
  final double thumbRadius;
  final double elevation;
  final Color innerColor;
  final Color borderColor;
  final String titleValue;

  const CustomSliderThumbShape({
    required this.thumbRadius,
    required this.elevation,
    required this.innerColor,
    required this.borderColor,
    required this.titleValue,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    final double radius = thumbRadius + elevation;
    final double outerRadius = radius + 2; // Add some extra space for the border

    Paint outerCirclePaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill;

    Paint innerCirclePaint = Paint()
      ..color = innerColor
      ..style = PaintingStyle.fill;

    // Draw outer circle
    canvas.drawCircle(center, outerRadius, outerCirclePaint);

    // Draw inner circle
    canvas.drawCircle(center, radius, innerCirclePaint);


    labelPainter.text = TextSpan(
      text: titleValue.toString(), // Use the current value of the slider
      style: styleW500S15,
    );

    labelPainter.layout();

    final double textCenterX = center.dx - labelPainter.width / 2;
    final double textCenterY = center.dy - labelPainter.height / 2;

    labelPainter.paint(canvas, Offset(textCenterX, textCenterY));
  }
}
