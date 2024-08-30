import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_station/pages/commom_ui/loading.dart';
import 'package:flutter_first_station/pages/commom_ui/web/webview_widget.dart';
import 'package:flutter_first_station/routes/route_utils.dart';
import 'package:flutter_first_station/routes/routes.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../repository/datas/home_list_data.dart';
import 'commom_ui/web/webview_page.dart';
import 'home_vm.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }

}

class _HomePageState extends State<HomePage>{
  HomeViewModel viewModel = HomeViewModel();
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getBanner();
    viewModel.getHomeList(false);

  }



  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<HomeViewModel>(create: (context){
        return viewModel;
    },
      child:  Scaffold(
          body: SafeArea(
            child: SmartRefresher(
              controller: refreshController,
              enablePullDown: true,
              enablePullUp: true,
              header: const ClassicHeader(),
              footer: const ClassicFooter(),
              onLoading: (){
                viewModel.getHomeList(true).then((value) => {
                  refreshController.loadComplete()

                });
              },
              onRefresh: (){
                viewModel.getBanner().then((value) => {
                  viewModel.getHomeList(false).then((value) => {
                    refreshController.refreshCompleted()
                  })
                });
              },
              child: SingleChildScrollView(child:Column(children: [

              Consumer<HomeViewModel>(builder: (context,vm,child){
                return SizedBox(width: double.infinity,height: 150.h,
                  child: Swiper(
                    itemCount: vm.bannerList?.length ?? 0,
                    pagination: const SwiperPagination(),
                    autoplay: true,
                    control: const SwiperControl(),
                    indicatorLayout: PageIndicatorLayout.NONE,
                    itemBuilder: (content,index){
                      return Image.network(vm.bannerList?[index]?.imagePath ?? '',fit: BoxFit.fill,);
                    },),);
              }),
              Consumer<HomeViewModel>(builder: (context,vm,child){

                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: vm.listData?.length ?? 0,
                    itemBuilder: (content,index){
                      return _listItemView(vm.listData?[index],index);
                    });
              })

            ],),),))
      ),
    );
  }
 Widget _listItemView(HomeListItemData? item,int index){
    return GestureDetector(
        onTap:(){
          // Navigator.push(context, MaterialPageRoute(builder: (context){
          //     return WebViewPage();
          // }));

          RouteUtils.push(context, WebViewPage(loadResource: item?.link??"",webViewType: WebViewType.URL,showTitle: true,title: item?.title??"",) );
        },
        child: Container(
          margin: EdgeInsets.only(left: 16.w,right: 16.w,top:5.h,bottom: 5.h),
          padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 14.h,bottom: 14.h),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12,width: 0.5.r),
              borderRadius: BorderRadius.all(Radius.circular(6.r))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(15.r),child:
                  Image.network('https://imgs.699pic.com/images/500/809/588.jpg!list1x.v2',width: 30.r,height: 30.r,fit: BoxFit.fill,),
                  ),
                  SizedBox(width:5.w),
                  Text(item?.author ?? '无',style:const TextStyle(color: Colors.green)),
                  const Expanded(child: SizedBox(),),
                  Text(item?.niceShareDate ?? '',style:const TextStyle(color: Colors.black54)),
                  SizedBox(width: 5.r),
                  const Text('置顶',style: TextStyle(color: Colors.red),),
                  SizedBox(height: 5.r,)
                ],),
               Text(item?.title ?? '',style:const TextStyle(color: Colors.black,fontSize: 16)),
               SizedBox(height: 5.r,),
               Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item?.superChapterName??'',style: TextStyle(color: Colors.grey,fontSize: 13.sp) ),
                    GestureDetector(
                      onTap: (){
                          viewModel.collectedOrNo(item?.collect ==true?false:true, "${item?.id}",index);
                      },
                      child: Text(item?.collect ==true?"已收藏": '收藏',style: TextStyle(color: Colors.black,fontSize: 14.sp),),
                    )
                ])
            ],),));
    }

}