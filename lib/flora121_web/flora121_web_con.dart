import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';

class Flora121WebCon extends Flora121BaseCon{
  var title="",url="";
  late WebViewController controller;
  
  @override
  void onInit() {
    super.onInit();
    var map = Flora121RoutersHep.getParams();
    title=map["title"];
    url=map["url"];
    _loadWeb();
  }

  _loadWeb(){
    controller=WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)..loadRequest(Uri.parse(url));
  }
}