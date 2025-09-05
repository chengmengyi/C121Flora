import 'package:flora121_base/flora121_base/flora121_base_stateful.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_a/flora121_bean/flora121_task_bean.dart';
import 'package:flora121_package_a/flora121_dialog/flora121_get_water_dialog/flora121_get_water_dialog.dart';
import 'package:flora121_package_a/flora121_hep/flora121_event_code.dart';
import 'package:flora121_package_a/flora121_hep/flora121_task_utils.dart';
import 'package:flora121_package_a/flora121_hep/flora121_user_info_utils.dart';
import 'package:flutter/material.dart';

class Flora121WaterView extends Flora121BaseStateful{
  @override
  State<StatefulWidget> createState() => _Flora121WaterViewState();
}

class _Flora121WaterViewState extends Flora121BaseStatefulState<Flora121WaterView>{
  Flora121TaskBean? _taskBean;

  @override
  void initState() {
    super.initState();
    _getTask();
  }

  @override
  Widget initBaseWidgetFlora121() => Container(
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
            Flora121ImagesView(imagesName: _getIcon(),width: 45.w,height: 45.w,),
            SizedBox(width: 8.w,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flora121TextView(text: _taskBean?.taskText??"", color: "#313831", size: 10.sp,fontWeight: FontWeight.bold,),
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
                              width: maxWidth*_getPor(),
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
            Flora121Click(
              onTap: (){
                clickBox();
              },
              child: Flora121ImagesView(imagesName: "icon_box",width: 55.w,height: 51.w,),
            ),
            SizedBox(width: 18.w,),
          ],
        ),
      ],
    ),
  );

  double _getPor(){
    var totalPro = _taskBean?.totalPro??0;
    if(totalPro<=0){
      return 0.0;
    }
    var d = (_taskBean?.currentPro??0)/totalPro;
    if(d<=0){
      return 0.0;
    }else if(d>=1){
      return 1.0;
    }else{
      return d;
    }
  }

  String _getIcon(){
    switch(_taskBean?.taskType){
      case TaskType.suns: return "icon_sun";
      case TaskType.water: return "icon_water";
      case TaskType.fertilizer: return "icon_f";
      default: return "icon_sun";
    }
  }

  _getTask()async{
    _taskBean = await Flora121TaskUtils.instance.getTodayTask();
    setState(() {});
  }

  clickBox()async{
    if(_getPor()<1){
      return;
    }
    Flora121RoutersHep.dialog(
      child: Flora121GetWaterDialog(
        waterNum: _taskBean?.healthReward??0,
        isHealth: true,
        taskType: _taskBean?.taskType??"",
        getCallback: ()async{
          Flora121UserInfoUtils.instance.updateHealth(_taskBean?.healthReward??0);
          await Flora121TaskUtils.instance.resetTodayTask();
          _getTask();
        },
      ),
    );
  }

  @override
  bool initFlora121Event() => true;

  @override
  receivedFlora121EventMsg(int flora121Code, int? flora121IntValue, String? flora121StringValue, Map? flora121Map) {
    switch(flora121Code){
      case Flora121EventCode.updateTask:
        _getTask();
        break;
    }
  }
}