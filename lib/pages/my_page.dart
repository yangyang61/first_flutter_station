import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_station/pages/login_page.dart';
import 'package:flutter_first_station/pages/my_vm.dart';
import 'package:flutter_first_station/routes/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget{
  const MyPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyPageState();
  }

}

class MyPageState extends State<MyPage> {
  MyViewModal viewModal = MyViewModal();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyViewModal>(create: (context){
      return viewModal;
    },child: Scaffold(
      body:
      SafeArea(
        child: Column(
          children: [
            Consumer<MyViewModal>(builder: (context,vm,child){
              return Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 200.h,
                decoration: const BoxDecoration(color: Colors.green),
                child: GestureDetector(
                  onTap: (){
                    if(vm.isLogin ==false){
                      RouteUtils.push(context, LoginPage());
                    }
                  },
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(35.r),
                          child: Image.asset('assets/images/avatar.png',width: 70.r,height: 70.r,fit: BoxFit.fill,)),
                      Text(vm.username ?? "",style: TextStyle(fontSize: 14.sp,color: Colors.black),)
                    ],
                  ),
                ),
              );
            }),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h,bottom: 0.h),
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(width: 1.r,color: Colors.grey)
                  ),
                  child: GestureDetector(
                      onTap: (){
                        showToast('我的收藏');
                      },
                      child: Row(
                        crossAxisAlignment:CrossAxisAlignment.center,
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Text('我的收藏',style: TextStyle(fontSize: 14.sp,color: Colors.black),),
                          Image.asset('assets/images/icon_next.png',width: 20.w,height: 20.h,)
                        ],
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h,bottom: 10.h),
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(width: 1.r,color: Colors.grey)
                  ),
                  child: GestureDetector(
                      onTap: (){
                        showToast('检查更新');
                      },
                      child: Row(
                        crossAxisAlignment:CrossAxisAlignment.center,
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Text('检查更新',style: TextStyle(fontSize: 14.sp,color: Colors.black),),
                          Image.asset('assets/images/icon_next.png',width: 20.w,height: 20.h,)
                        ],
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h,bottom: 10.h),
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(width: 1.r,color: Colors.grey)
                  ),
                  child: GestureDetector(
                      onTap: (){
                        showToast('关于我们');
                      },
                      child: Row(
                        crossAxisAlignment:CrossAxisAlignment.center,
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Text('关于我们',style: TextStyle(fontSize: 14.sp,color: Colors.black),),
                          Image.asset('assets/images/icon_next.png',width: 20.w,height: 20.h,)
                        ],
                      )
                  ),
                ),
                Consumer<MyViewModal>(builder: (context,vm,child){
                  if(vm.isLogin == false) return const SizedBox();
                  return Container(
                    margin: EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h,bottom: 10.h),
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(width: 1.r,color: Colors.grey)
                    ),
                    child: GestureDetector(
                        onTap: (){
                          viewModal.logout((value) {
                            RouteUtils.pushAndRemoveUntil(context, LoginPage());
                          });
                        },
                        child: Row(
                          crossAxisAlignment:CrossAxisAlignment.center,
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            Text('退出登录',style: TextStyle(fontSize: 14.sp,color: Colors.black),),
                            Image.asset('assets/images/icon_next.png',width: 20.w,height: 20.h,)
                          ],
                        )
                    ),
                  );
                })
              ],
            )
          ],
        ),
      ),
    ),);
  }


}