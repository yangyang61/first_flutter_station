import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_first_station/pages/commom_ui/loading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


// 需要加载类容的类型
enum WebViewType {
  // html 文本
  HTMLTEXT,
  // 链接
  URL,
}

// 定义js通信回调方法
typedef dynamic JsChannelCallback(List<dynamic> arguments);

// 封装WebView组件
class WebViewWidget  extends StatefulWidget{
  const WebViewWidget({
    super.key,
    required this.webViewType,
    required this.loadResource,
    this.clearAllCache,
    this.jsChannelMap,
    this.onWebViewCreated
  });

  // 需要加载的内容类型
  final WebViewType webViewType;

  // 给WebView加载的数据，可以是url，也可以是html文本
  final String loadResource;

  // 是否清除缓存后在加载
  final bool? clearAllCache;

  // 与js通信的集合
  final Map<String, JsChannelCallback>? jsChannelMap;

  final Function(InAppWebViewController controller)? onWebViewCreated;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WebViewWidgetState();
  }
  
}

class _WebViewWidgetState extends State<WebViewWidget> {
  // WebView控制器
  late InAppWebViewController webViewController;
  final GlobalKey globalKey = GlobalKey();

  // WebView配置
  InAppWebViewSettings settings  = InAppWebViewSettings(
    allowsInlineMediaPlayback:true,
    useShouldOverrideUrlLoading: true,
    mediaPlaybackRequiresUserGesture: true,
    // 不允许缩放
    builtInZoomControls: true,
    // 支持HybridComposition
    useHybridComposition: true,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return InAppWebView(
     key: globalKey,
     initialSettings: settings,
     onWebViewCreated: (InAppWebViewController controller){
       // WebView 初始完成之后再加载数据
       webViewController = controller;

       // 是否清除缓存后再加载数据
       if(widget.clearAllCache ==true){
          controller.clearCache();
       }

       if(widget.onWebViewCreated  == null) {
         if(widget.webViewType == WebViewType.HTMLTEXT){
           webViewController.loadData(data: widget.loadResource);
         }else if(widget.webViewType == WebViewType.URL){
           webViewController.loadUrl(urlRequest: URLRequest(url: WebUri(Uri.parse(widget.loadResource).toString())));
         }
       }else {
         widget.onWebViewCreated?.call(controller);
       }

      // 注册与js通信回调
       widget.jsChannelMap?.forEach((handlerName, callback) {
          webViewController.addJavaScriptHandler(handlerName: handlerName, callback: callback);
       });
     },
     onConsoleMessage: (controller,consoleMessage){
       log("consoleMessage: from js console.log  =========>\n $consoleMessage");
     },
     onProgressChanged: (InAppWebViewController controller,int progress){
        log("progress ==========> $progress");
     },
     onLoadStart: (controller,url){
       Loading.showLoading(duration: const Duration(seconds: 45));
     },
     onReceivedError: (controller,request, error){
       Loading.dismissAll();
     },
     onLoadStop: (controller, url){
       Loading.dismissAll();
     },
     onPageCommitVisible: (controller,url){
       log("onPageCommitVisible ==========> $url");
     },
   );
  }

}