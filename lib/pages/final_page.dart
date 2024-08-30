import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_station/pages/commom_ui/web/webview_widget.dart';
import 'package:flutter_first_station/pages/hot_vm.dart';
import 'package:flutter_first_station/pages/search_page.dart';
import 'package:flutter_first_station/pages/commom_ui/web/webview_page.dart';
import 'package:flutter_first_station/routes/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import '../repository/datas/hot_friend_data.dart';
import '../repository/datas/hot_key_data.dart';

class FinalPage extends StatefulWidget{
  const FinalPage({super.key});

  @override
  State<StatefulWidget> createState() {
   return FinalPageState();
  }

}

typedef WebSiteClick =  Function(String name, String link);

class FinalPageState extends State<FinalPage> {
  HotViedModal hotViedModal = HotViedModal();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hotViedModal.getHotkey();
    hotViedModal.getFriend();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<HotViedModal>(create: (context){
      return hotViedModal;
    },child: Scaffold(
      body:
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration:  BoxDecoration(border: Border(top: BorderSide(width: 0.5.r, color: Colors.grey),bottom: BorderSide(width: 0.5.r,color: Colors.grey))),
                padding: EdgeInsets.only(left: 20.w,right: 20.w,top:6.h,bottom: 6.h),
                child: Row(
                  children: [
                    Text('搜索热词',style: TextStyle(color: Colors.black,fontSize: 14.sp),),
                   const Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: (){
                        RouteUtils.push(context, SearchPage(keyword: "",));
                      },
                      child: Image.asset("assets/images/icon_search.png",width: 25.r,height: 25.r,),
                    )
                  ],
                ),
              ),
              Consumer<HotViedModal>(builder: (content,vm,child){
                  return _gridView(
                      keyData: vm.hotKeyData,
                      itemTap: (value){
                        RouteUtils.push(context, SearchPage(keyword: value));
                      },

                  );
              }),
              Container(
                height: 40.r,
                decoration:  BoxDecoration(border: Border(top: BorderSide(width: 0.5.r, color: Colors.grey),bottom: BorderSide(width: 0.5.r,color: Colors.grey))),
                padding: EdgeInsets.only(left: 20.w,right: 20.w,),
                child: Row(children: [Text('常用网站',style:  TextStyle(fontSize: 14.sp,color:Colors.black),)],),
              ),
              Consumer<HotViedModal>(builder: (context,vm,child){
                return _gridView(isWebsite: true, webSiteClick:(name,link){
                  RouteUtils.push(context, WebViewPage(showTitle: true, title:name,loadResource: link, webViewType: WebViewType.URL));
                },friendData: vm.friendData);
              })
              ],
            ),
        ),
      ),
    ),);
  }

  Widget _gridView({bool? isWebsite,ValueChanged<String>? itemTap,
      List<HotKeyData?>? keyData,
      List<HotFriendData?>? friendData,
    WebSiteClick? webSiteClick
    } ) {
    return Container(
      padding: EdgeInsets.all(20.r),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent:120.w,
            mainAxisSpacing: 10.r,
            crossAxisSpacing:10.r,
            childAspectRatio: 2
        ),
        itemBuilder: (context,index){
          if(isWebsite==true){
            return  _item(
                name:friendData?[index]?.name,
                webSiteClick: webSiteClick,
                link:friendData?[index]?.link
            );
          }else {
            return  _item(
                name:keyData?[index]?.name,
                itemTap:itemTap
            );
          }
        },
        itemCount: isWebsite==true ? friendData?.length??0:keyData?.length??0,
      ),
    );
  }

  Widget _item({String? name,ValueChanged<String>? itemTap,String? link,WebSiteClick? webSiteClick}) {
    return GestureDetector(
      onTap: () {
        if(link != null){
          // itemTap?.call(link);
          webSiteClick?.call(name??"",link);
        }else {

          itemTap?.call(name ?? '');
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          border:Border.all(width:  0.5.r,color: Colors.grey),
        ),
        child: Text(name ?? '',style:const TextStyle(color: Colors.black),),
      ),
    );

  }
}