import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_bean/flora121_task_bean.dart';
import 'package:flutter/material.dart';

class Flora121NewUserStep8View extends StatelessWidget{
  Offset offset;
  Flora121TaskBean? taskBean;
  Function() dismissCallback;
  Flora121NewUserStep8View({
    required this.offset,
    required this.taskBean,
    required this.dismissCallback,
});

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: Flora121Click(
      onTap: (){
        dismissCallback.call();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.7),
        child: Stack(
          children: [
            _widget(),
            Positioned(
              top: offset.dy+100.h,
              left: 30.w,
              child: SizedBox(
                width: 260.w,
                height: 82.h,
                child: Stack(
                  children: [
                    Flora121ImagesView(imagesName: "step1",width: double.infinity,height: double.infinity,),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 22.h),
                        child: Flora121TextView(text: "Great start! Now grab your \$50 today!", color: "#3B6204", size: 12.sp,fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );

  _widget()=>Positioned(
    top: offset.dy,
    left: 0,
    right: 0,
    child: Container(
      width: double.infinity,
      height: 82.h,
      margin: EdgeInsets.only(left: 18.w,right: 18.w),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Flora121ImagesView(imagesName: "home5",width: double.infinity,height: double.infinity,),
          Row(
            children: [
              SizedBox(width: 18.w,),
              Flora121ImagesView(imagesName: "icon_water",width: 45.w,height: 45.w,),
              SizedBox(width: 8.w,),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flora121TextView(text: taskBean?.taskText??"", color: "#313831", size: 10.sp,fontWeight: FontWeight.bold,),
                    SizedBox(height: 4.w,),
                    LayoutBuilder(
                      builder: (context,bc){
                        var maxWidth = bc.maxWidth-2.w;
                        return SizedBox(
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Flora121ImagesView(imagesName: "home6",width: double.infinity,height: 10.h,),
                              Container(
                                margin: EdgeInsets.only(left: 1.w),
                                width: 0,
                                height: 8.h,
                                decoration: BoxDecoration(
                                  color: "#3ACDFF".toColor(),
                                  borderRadius: BorderRadius.circular(8.w),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(width: 8.w,),
              Flora121ImagesView(imagesName: "icon_box",width: 55.w,height: 51.w,),
              SizedBox(width: 18.w,),
            ],
          ),
        ],
      ),
    ),
  );
}