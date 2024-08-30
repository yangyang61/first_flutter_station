import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_station/pages/chat_page.dart';
import 'package:flutter_first_station/pages/final_page.dart';
import 'package:flutter_first_station/pages/home_page.dart';
import 'package:flutter_first_station/pages/my_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabPageState();
  }
  
}

class TabPageState extends State<TabPage>{
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
   return  Scaffold(
     body:  SafeArea(child: IndexedStack(
       index: currentIndex,
       children: [
         HomePage(),
         FinalPage(),
         ChatPage(),
         MyPage()
     ],),),
     bottomNavigationBar: Theme(
       data: Theme.of(context).copyWith(splashColor: Colors.transparent,highlightColor: Colors.transparent),
       child: BottomNavigationBar(
         type: BottomNavigationBarType.fixed,
         currentIndex: currentIndex,
         items:_barItemList(),
         onTap: (index) {
           currentIndex = index;
           setState(() {});
         },
       ),
     )
   );
  }

  List<BottomNavigationBarItem> _barItemList() {
      List<BottomNavigationBarItem> items =[];

      items.add(
          BottomNavigationBarItem(
            label:'首页',
            activeIcon: Image.asset('assets/images/icon_wallet_select.png',width: 32.r,height: 32.r,),
            icon: Image.asset('assets/images/icon_wallet_gray.png',width: 32.r,height: 32.r,),
        )
      );
      items.add(
          BottomNavigationBarItem(
              label:'热点',
              activeIcon: Image.asset('assets/images/icon_final_select.png',width: 32.r,height: 32.r,),
              icon: Image.asset('assets/images/icon_final_gray.png',width: 32.r,height: 32.r,)
          )
      );
      items.add(
          BottomNavigationBarItem(
              label: '体系',
              activeIcon: Image.asset('assets/images/icon_chat_select.png',width: 32.r,height: 32.r,),
              icon: Image.asset('assets/images/icon_chat_gray.png',width: 32.r,height: 32.r,)
          )
      );
      items.add(
          BottomNavigationBarItem(
              label: '我的',
              activeIcon: Image.asset('assets/images/icon_my_select.png',width: 32.r,height: 32.r,),
              icon: Image.asset('assets/images/icon_my_gray.png',width: 32.r,height: 32.r,)
          )
      );

      return items;
  }
}