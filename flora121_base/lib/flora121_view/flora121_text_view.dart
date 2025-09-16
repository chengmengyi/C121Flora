import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outlined_text/outlined_text.dart';

class Flora121TextView extends StatelessWidget{
  String text;
  String color;
  double size;
  FontWeight? fontWeight;
  TextOverflow? overflow;
  int? maxLines;
  String? outlineColor;
  TextDecoration? decoration;
  Color? decorationColor;
  String? fontFamily;

  Flora121TextView({
    required this.text,
    required this.color,
    required this.size,
    this.fontWeight,
    this.overflow,
    this.maxLines,
    this.outlineColor,
    this.decoration,
    this.decorationColor,
    this.fontFamily,
});

  @override
  Widget build(BuildContext context) {
    return OutlinedText(
      text: Text(
        text,
        style: TextStyle(
          fontSize: size,
          color: color.toColor(),
          fontWeight: fontWeight,
          overflow: overflow,
          decoration: decoration,
          decorationColor: decorationColor,
          fontFamily: fontFamily,
        ),
        maxLines: maxLines,
      ),
      strokes: outlineColor==null?
      []:
      [
        OutlinedTextStroke(
          color: (outlineColor??"#FFFFFF").toColor(),
          width: 2.w,
        ),
      ],
    );
  }
}