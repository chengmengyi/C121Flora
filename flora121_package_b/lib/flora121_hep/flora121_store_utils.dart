import 'dart:convert';

import 'package:flora121_base/flora121_hep/flora121_hep.dart';
import 'package:flora121_base/flora121_hep/flora121_local_info.dart';
import 'package:flora121_package_b/flora121_bean/flora121_store_bean.dart';

class Flora121StoreUtils{
  static final Flora121StoreUtils _utils = Flora121StoreUtils();
  static Flora121StoreUtils get instance => _utils;

  List<Flora121StoreBean> getList(){
    try{
      List<Flora121StoreBean> list=[];
      var json = jsonDecode(Flora121LocalInfo.storeBase64.base64());
      for(var value in json){
        list.add(Flora121StoreBean.fromJson(value));
      }
      return list;
    }catch(e){
      return [];
    }
  }
}