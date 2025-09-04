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
        onTap?.call();
      },
      child: child??Container(),
    );
  }
}