import 'package:flora121_base/flora121_hep/flora121_music_hep.dart';
import 'package:flutter/material.dart';

class Flora121Click extends StatelessWidget{
  Widget? child;
  Function()? onTap;
  Flora121Click({
    this.child,
    this.onTap,
});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: (){
        Flora121MusicHep.instance.playOtherAudio(AudioName.click);
        onTap?.call();
      },
      child: child??Container(),
    );
  }
}