import 'package:flutter/material.dart';

class Flora121ImagesView extends StatelessWidget{
  String imagesName;
  double? width;
  double? height;
  BoxFit? fit;

  Flora121ImagesView({
    required this.imagesName,
    this.width,
    this.height,
    this.fit,
});

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/flora121_images/$imagesName.webp",width: width,height: height,fit: fit??BoxFit.fill,);
  }
}