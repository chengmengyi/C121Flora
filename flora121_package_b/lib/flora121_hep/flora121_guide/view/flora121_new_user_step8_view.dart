import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_bean/flora121_task_bean.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flutter/material.dart';

class Flora121NewUserStep8View extends StatelessWidget{
  Offset offset;
  Function() dismissCallback;
  Flora121NewUserStep8View({
    required this.offset,
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
                        margin: EdgeInsets.only(bottom: 25.h),
                        // child: Flora121TextView(text: "Great start! Now grab your \$50 today!", color: "#3B6204", size: 12.sp,fontWeight: FontWeight.bold,),
                        child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Great start! Now grab your ",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: "#3B6204".toColor(),
                                  ),
                                ),
                                TextSpan(
                                  text: "\$50",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: "#EF5D00".toColor(),
                                  ),
                                ),
                                TextSpan(
                                  text: " today!",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: "#3B6204".toColor(),
                                  ),
                                ),
                              ]
                          ),
                        ),
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
      height: 75.h,
      margin: EdgeInsets.only(left: 18.w,right: 18.w),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Flora121ImagesView(imagesName: "home17",width: double.infinity,height: double.infinity,),
          Row(
            children: [
              SizedBox(width: 16.w,),
              Flora121ImagesView(imagesName: "home18",width: 50.w,height: 50.h,),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flora121TextView(text: getTitleStr(), color: "#313831", size: 10.sp,fontWeight: FontWeight.bold,),
                    SizedBox(height: 8.h,),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(right: 66.w),
                      child: LayoutBuilder(
                        builder: (context,bc){
                          var maxWidth = bc.maxWidth-2.w;
                          return Container(
                            width: double.infinity,
                            height: 10.h,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 1.w,right: 1.w),
                            decoration: BoxDecoration(
                                color: "#084708".toColor(),
                                borderRadius: BorderRadius.circular(10.w),
                                border: Border.all(
                                  width: 1.w,
                                  color: "#FFA81C".toColor(),
                                )
                            ),
                            child: Container(
                              width: maxWidth*getProgress(),
                              height: 8.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: ["#B3FF3A".toColor(),"#489923".toColor(),]
                                  )
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(right: 36.w),
              child: Flora121ImagesView(imagesName: "home19",width: 58.w,height: 35.h,),
            ),
          )
        ],
      ),
    ),
  );

  String getTitleStr(){
    var data = bMyMoneyNum.getData();
    if(data<25){
      return "Your First \$50 Today! I'll Guide You!";
    }else if (data<49){
      return "Great Progress! Chase That \$50!";
    }else if(data<50){
      var d = (Decimal.fromInt(50)-Decimal.fromJson("$data")).toDouble();
      return "Final Step：+\$$d=To withdraw \$50 today!";
    }else{
      return "Earnings ready! Withdraw now.";
    }
  }

  double getProgress(){
    var d = bMyMoneyNum.getData()/50;
    if(d<0){
      return 0.0;
    }else if(d>1){
      return 1.0;
    }else{
      return d;
    }
  }

}