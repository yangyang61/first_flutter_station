import 'package:flutter/material.dart';
import 'package:flutter_first_station/pages/chat_page.dart';
import 'package:flutter_first_station/pages/commom_ui/web/webview_widget.dart';
import 'package:flutter_first_station/pages/final_page.dart';
import 'package:flutter_first_station/pages/knowledge/knowledge_detail_page.dart';
import 'package:flutter_first_station/pages/login_page.dart';
import 'package:flutter_first_station/pages/my_page.dart';
import 'package:flutter_first_station/pages/register_page.dart';
import 'package:flutter_first_station/pages/search_page.dart';
import 'package:flutter_first_station/pages/commom_ui/web/webview_page.dart';

import '../pages/tabbar_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){
      switch(settings.name) {
        case RoutesPath.tab :
          return pageRoute(TabPage(),settings: settings);
        case RoutesPath.webViewPage:
          return pageRoute( WebViewPage(loadResource: "",webViewType: WebViewType.URL,),settings: settings);
        case RoutesPath.chatPage:
          return pageRoute(ChatPage(),settings: settings);
        case RoutesPath.hotPage:
          return pageRoute(FinalPage(),settings: settings);
        case RoutesPath.myPage:
          return pageRoute(MyPage(),settings: settings);
        case RoutesPath.loginPage:
          return pageRoute(LoginPage(),settings: settings);
        case RoutesPath.registerPage:
          return pageRoute(RegisterPage(),settings: settings);
        case RoutesPath.knowledgeDetailPage:
          return pageRoute(KnowledgeDetailPage(),settings: settings);
        case RoutesPath.searchPage:
          return pageRoute(SearchPage(),settings: settings);
      }
      return pageRoute(Scaffold(body: SafeArea(child: Center(child: Text('路由：${settings.name} 不存在'),),),)) ;
  }
  static MaterialPageRoute pageRoute(Widget page, {
    RouteSettings? settings,
    bool? fullscreenDialog,
    bool? allowSnapshotting,
    bool? maintainState
  }){
    return MaterialPageRoute(builder: (context){
      return  page;
    },
    settings:settings,
    fullscreenDialog: fullscreenDialog ?? false,
    maintainState: maintainState ?? true,
        allowSnapshotting: allowSnapshotting ?? true
    );
  }

}

class RoutesPath {
  static  const String tab = '/' ;
  static const String webViewPage = '/web_view_page';
  static const String hotPage = '/final_page';
  static const String chatPage = '/chat_page';
  static const String myPage = '/my_page';
  static const String loginPage = '/login_page';
  static const String registerPage = '/register_page';
  static const String knowledgeDetailPage = '/knowledge_detail_page';
  static const String searchPage = '/search_page';

}