
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first_station/pages/commom_ui/loading.dart';
import 'package:flutter_first_station/pages/commom_ui/web/webview_page.dart';
import 'package:flutter_first_station/pages/commom_ui/web/webview_widget.dart';
import 'package:flutter_first_station/pages/search_vm.dart';
import 'package:flutter_first_station/routes/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_html/flutter_html.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.keyword});

  final String? keyword;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchPageState();
  }

}

class _SearchPageState extends State<SearchPage> {
  SearchViewModal viewModal = SearchViewModal();

  TextEditingController controller = TextEditingController();
  RefreshController refreshController = RefreshController();

 @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TextEditingController(text: widget.keyword ?? "");
    viewModal.search(controller.text, false);
  }

  void refreshOrLoad(bool loadMore) {
   viewModal.search(controller.text,loadMore).then((value) => {
     if(loadMore){
       refreshController.loadComplete()
     }else {
       refreshController.refreshCompleted()
     },
    Loading.showLoading()
   });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModal>(create: (context){
      return viewModal;
    },child: Scaffold(
      body: SafeArea(
        child: Consumer<SearchViewModal>(builder: (context, vm, child) {
          return SmartRefresher(
            onRefresh: (){
              refreshOrLoad(false);
            },
            onLoading: (){
              refreshOrLoad(true);
            },
            enablePullDown: true,
            enablePullUp: true,
            header: const ClassicHeader(),
            footer: const ClassicFooter(),
            controller: refreshController,
            child: Column(
              children: [
                _searchBar(
                    onBack:(){
                      RouteUtils.pop(context);
                    },
                    onSubmitted:(value){
                      viewModal.search(value,false);
                    },
                    onCancel: (){
                      controller.text='';
                      viewModal.searchList.clear();
                      SystemChannels.textInput.invokeMethod("TextInput.hide");
                    }
                ),
                Expanded(child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: vm.searchList.length,
                  itemBuilder: (context,index){
                    return _listItem(title: vm.searchList[index].title,onTap: (){
                      RouteUtils.push(
                          context,
                          WebViewPage(
                            webViewType: WebViewType.URL,
                            loadResource:  vm.searchList[index].link??"",
                            showTitle: true,
                            title: vm.searchList[index].title,
                          )
                      );
                    });
                  }
              ))
            ],
          ),);
        },),
      ),
    ),);
  }

  Widget _searchBar({GestureTapCallback? onBack,ValueChanged<String>? onSubmitted, GestureTapCallback? onCancel}) {
    return Container(
      color: Colors.teal,
      height: 50.h,
      width: double.infinity,
      padding: EdgeInsets.only(right: 10.w,top: 10.h,bottom: 10.h),
      child: Row(
        children: [
          GestureDetector(onTap: onBack,child: Image.asset('assets/images/icon_back.png',width: 30.w,height: 30.h,),),
          SizedBox(width: 5.w,),
          Expanded(child: TextField(
            controller: controller ,
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            onSubmitted: onSubmitted,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                labelStyle: const TextStyle(color: Colors.black),
                contentPadding: EdgeInsets.only(left: 10.w),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.r)),
                  borderSide: BorderSide(color: Colors.white,width: 0.5.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.r)),
                  borderSide: BorderSide(color: Colors.white,width: 0.5.r),
                )
            ),
          )),
          SizedBox(width: 5.w,),
          GestureDetector(onTap: onCancel,child: Text('取消',style: TextStyle(fontSize: 14.sp,color: Colors.black),),)
        ],
      ),
    );
  }

  Widget _listItem({String? title, GestureTapCallback? onTap}) {
   return GestureDetector(
     onTap: onTap,
     child: Container(
       decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5.r,color: Colors.black12))),
       padding: EdgeInsets.symmetric(vertical: 5.w,horizontal: 10.h),
       child: Html(
         data: title,
         style: {
         "html":Style(fontSize: FontSize(14.sp), color: Colors.black),
       },)
     )

   );

  }
}