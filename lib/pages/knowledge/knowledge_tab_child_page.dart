import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_station/pages/knowledge/Knowledge_detail_vm.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../repository/datas/knowledge_detail_data.dart';
import '../../routes/route_utils.dart';
import '../commom_ui/web/webview_page.dart';
import '../commom_ui/web/webview_widget.dart';

class KnowledgeTabChildPage extends StatefulWidget {
  const KnowledgeTabChildPage({super.key, this.cid});

  final String? cid;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _KnowledgeTabChildPageState();
  }

}

class _KnowledgeTabChildPageState extends State<KnowledgeTabChildPage> {

  KnowledgeDetailViewModal viewModal = KnowledgeDetailViewModal();
  RefreshController refreshController = RefreshController();

  bool loadMore = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshOrLoad(false);
  }

  void refreshOrLoad(bool loadMore){
    viewModal.getArticleList(widget.cid, loadMore).then((value) => {
      if(loadMore){
        refreshController.loadComplete()
      }else {
        refreshController.refreshCompleted()
    }
    });
  }

  @override
  Widget build(BuildContext context) {
   return ChangeNotifierProvider<KnowledgeDetailViewModal>(create: (context){
     return viewModal;
   },child: Scaffold(
     body: Consumer<KnowledgeDetailViewModal>(builder: (context, vm, child) {
       return SmartRefresher(
         controller: refreshController,
         enablePullDown: true,
         enablePullUp: true,
         header: const ClassicHeader(),
         footer: const ClassicFooter(),
         onLoading: (){
           refreshOrLoad(true);
         },
         onRefresh: (){
           refreshOrLoad(false);
         },
         child: SingleChildScrollView(
           child: ListView.builder(
             shrinkWrap: true,
             physics: const NeverScrollableScrollPhysics(),
             itemCount: vm.detailListData.length,
             itemBuilder: (context,index){
              return _item(vm.detailListData[index],onTap: (){
                RouteUtils.push(
                    context,
                    WebViewPage(
                      webViewType: WebViewType.URL,
                      loadResource:  vm.detailListData[index].link??"",
                      showTitle: true,
                      title: vm.detailListData[index].title,
                    )
                );
              });
             }),
         ),

       );
     },
     )
   )
   );
  }

  Widget _item(KnowledgeListItemData? item,{GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h,horizontal: 15.w),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5.r,color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(6.r))
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(item?.superChapterName ?? "",style: TextStyle(color: Colors.black,fontSize: 14.sp),),
                const Expanded(child: SizedBox()),
                Text(item?.niceShareDate ?? "",style: TextStyle(color: Colors.grey,fontSize: 14.sp),),
              ],
            ),
            SizedBox(height: 5.h,),
            Text("${item?.title}",style: TextStyle(fontSize: 15.sp,color: Colors.black),),
            SizedBox(height: 5.h,),
            Row(
              children: [
                Text(item?.chapterName ?? "",style: TextStyle(color: Colors.black,fontSize: 14.sp),),
                const Expanded(child: SizedBox()),
                Text(item?.shareUser ?? "",style: TextStyle(color: Colors.grey,fontSize: 14.sp),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
