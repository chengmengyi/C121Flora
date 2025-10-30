import 'dart:io';

import 'package:flora121_base/flora121_base/flora121_base_con.dart';
import 'package:flora121_base/flora121_hep/flora121_export.dart';
import 'package:flora121_base/flora121_hep/flora121_router/flora121_routers_hep.dart';
import 'package:flora121_package_b/flora121_package_b.dart';

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
    controller=WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..runJavaScript("PlantFortune")
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {

          },
          onPageStarted: (String url) {

          },
          onPageFinished: (String url) {

          },
          onWebResourceError: (WebResourceError error) {

          },
          onNavigationRequest: (NavigationRequest request) {
            String url = request.url;
            bool result = _isPrevent(url);
            if(result){
              _jumpNext(url);
            }
            return result ? NavigationDecision.prevent : NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  bool _isPrevent(String url) {
    if (url.startsWith("market:") ||
        url.startsWith("http://play.google.com/store/") ||
        url.contains("lz_open_browser=1") ||
        url.startsWith("https://play.google.com/store/") ||
        (url.startsWith("intent://") && Platform.isAndroid) ||
        url.endsWith(".apk")) {
      return true;
    }
    return false;
  }

  _jumpNext(String url) {
    try {
      if (url.startsWith("intent://")) {
        Flora121Package_b.instance.intentAc(url);
      }else{
        String url2 = url;
        if (url2.startsWith("market://details?id=")) {
          url2 = url2.replaceAll("market://details", "https://play.google.com/store/apps/details",);
        }
        launchUrl(Uri.parse(url2), mode: LaunchMode.externalApplication);
      }

    }catch (e) {

    }
  }
}