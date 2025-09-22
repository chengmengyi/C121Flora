import 'package:flora121_base/flora121_base/flora121_base_stateful.dart';
import 'package:flora121_base/flora121_hep/flora121_event/flora121_event_utils.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_b/flora121_hep/flora121_storage/flora121_storage.dart';
import 'package:flutter/material.dart';

class  Flora121HomeTopRewardView extends Flora121BaseStateful{
  @override
  State<StatefulWidget> createState() => _Flora121HomeTopRewardViewState();
}

class _Flora121HomeTopRewardViewState extends Flora121BaseStatefulState<Flora121HomeTopRewardView>{
  @override
  Widget initBaseWidgetFlora121() => Flora121Click(
    onTap: (){
      Flora121EventUtils.instance.sendMsg(flora121Code: Flora121EventCode.showHomeTab,flora121IntValue: 3);
    },
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

  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.updateMyMoney:
        setState(() {});
        break;
    }
  }
}