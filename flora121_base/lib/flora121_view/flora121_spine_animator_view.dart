import 'package:flutter/material.dart';
import 'package:spine_flutter/spine_flutter.dart';

class Flora121SpineAnimatorView extends StatelessWidget{
  String atlasFile;
  String skeletonFile;
  String animatorName;
  String folder;
  double? width;
  double? height;
  SpineWidgetController? controller;
  Flora121SpineAnimatorView({
    required this.atlasFile,
    required this.skeletonFile,
    required this.animatorName,
    required this.folder,
    required this.width,
    required this.height,
    this.controller,
  });
  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    height: height,
    child: SpineWidget.fromAsset(
      "assets/flora121_spine/$folder/$atlasFile.atlas",
      "assets/flora121_spine/$folder/$skeletonFile.json",
      controller??SpineWidgetController(
        onInitialized: (controller) {
          controller.animationState.setAnimationByName(0, animatorName, true);
        },
      ),
      // fit: fit??BoxFit.fill,
    ),
  );
}