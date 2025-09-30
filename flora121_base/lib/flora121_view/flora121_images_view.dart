import 'package:flutter/material.dart';

class Flora121ImagesView extends StatelessWidget{
  String imagesName;
  double? width;
  double? height;
  BoxFit? fit;
  String? ext;

  Flora121ImagesView({
    required this.imagesName,
    this.width,
    this.height,
    this.fit,
    this.ext,
});

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/flora121_images/$imagesName.${ext??"webp"}",width: width,height: height,fit: fit??BoxFit.fill,);
  }
}