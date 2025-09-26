import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_spine_animator_view.dart';
import 'package:flutter/material.dart';

class Flora121FingerView extends StatelessWidget{

  @override
  Widget build(BuildContext context) => Flora121SpineAnimatorView(
    atlasFile: "skeleton",
    skeletonFile: "skeleton",
    animatorName: "animation",
    folder: "hand",
    width: 50.w,
    height: 45.h,
  );
  // Widget build(BuildContext context) => Flora121ImagesView(imagesName: "icon_finger",width: 51.w,height: 45.h,);

}