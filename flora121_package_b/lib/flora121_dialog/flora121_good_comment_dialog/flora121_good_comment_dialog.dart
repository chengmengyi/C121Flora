import 'package:flora121_base/flora121_base/flora121_base_dialog.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_base/flora121_view/flora121_click.dart';
import 'package:flora121_base/flora121_view/flora121_images_view.dart';
import 'package:flora121_base/flora121_view/flora121_text_view.dart';
import 'package:flora121_package_b/flora121_dialog/flora121_good_comment_dialog/flora121_good_comment_dialog_con.dart';
import 'package:flutter/material.dart';

class Flora121GoodCommentDialog extends Flora121BaseDialog<Flora121GoodCommentDialogCon>{
  @override
  Flora121GoodCommentDialogCon initBaseConFlora121() => Flora121GoodCommentDialogCon();

  @override
  Widget initBaseWidgetFlora121() =>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        margin: EdgeInsets.only(left: 34.w,right: 34.w),
        decoration: BoxDecoration(
          color: "#F9FFF2".toColor(),
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flora121TextView(text: "Five-Star Review", color: "#7A5040", size: 20.sp,fontWeight: FontWeight.bold,),
            SizedBox(height: 8.h,),
            Flora121ImagesView(imagesName: "good_comment1",width: 91.w,height: 91.w,),
            SizedBox(height: 8.h,),
            SizedBox(
              height: 38.w,
              child: GetBuilder<Flora121GoodCommentDialogCon>(
                id: "list",
                builder: (_)=>ListView.separated(
                  shrinkWrap: true,
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index)=>Flora121Click(
                    onTap: (){
                      baseCon.clickItem(index);
                    },
                    child: Flora121ImagesView(imagesName: baseCon.index>=index?"good3":"good2", width: 38.w, height: 38.w,),
                  ),
                  separatorBuilder: (BuildContext context, int index) => SizedBox(width: 8.w,),
                ),
              ),
            ),
            SizedBox(height: 8.h,),
            Flora121TextView(text: "Your encouragement makes us better", color: "#4C7D0A", size: 14.sp),
            SizedBox(height: 16.h,),
            Flora121Click(
              onTap: (){
                baseCon.clickFeed();
              },
              child: Container(
                width: double.infinity,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: "#4C7D0A".toColor(),
                  borderRadius: BorderRadius.circular(15.w),
                ),
                child: Flora121TextView(text: "Feedback", color: "#FFFFFF", size: 16.sp,fontWeight: FontWeight.bold,),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 26.h,),
      Flora121Click(
        onTap: (){
          Flora121RoutersHep.back();
        },
        child: Flora121ImagesView(imagesName: "icon_close",width: 30.w,height: 30.w,),
      ),
    ],
  );
}