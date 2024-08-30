import 'package:flutter/material.dart';
import 'package:flutter_first_station/pages/commom_ui/web/webview_widget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebViewPage extends StatefulWidget{
  // 是否显示标题
  final bool? showTitle;
  // 标题内容
  final String? title;
  // 需要加载的内容类型
  final WebViewType webViewType;
  // 给WebView加载的数据，可以是url，也可以是html文本
  final String loadResource;
  // 与js通信的集合
  final Map<String, JsChannelCallback>? jsChannelMap;

  const WebViewPage({super.key,this.title, this.showTitle,required this.webViewType, required this.loadResource, this.jsChannelMap});

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }

}

class _WebViewPageState extends State<WebViewPage>{

  @override
  void initState(){
    super.initState();
    // 组件初始化之后执行
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   var map = ModalRoute.of(context)?.settings.arguments;
    //   if(map is Map){
    //     name = map["name"];
    //     setState(() {});
    //   }
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget?.showTitle ?? false) ? AppBar(
        title: _buildAppBarTitle(widget.showTitle, widget.title),
      ):null,
      body: SafeArea(
        child: WebViewWidget(
          webViewType: widget.webViewType,
          loadResource: widget.loadResource,
          jsChannelMap: widget.jsChannelMap,
        ),

      ),
    );
  }

  Widget _buildAppBarTitle(bool? showTitle,String? title){
    var show = showTitle ?? false;
    return show ?
        Html(data: title ??  "",style: {
          "html": Style(fontSize: FontSize(14.sp),color: Colors.black)
        },)
      : const SizedBox();
  }

  String limitStr(String? content,{int limit = 15}){
    if(content == null || content.isEmpty == true){
      return "";
    }
    if(content.length>limit){
      return content.substring(0,15);
    }else {
      return content;
    }
  }
}