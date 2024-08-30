import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_station/pages/knowledge/knowledge_detail_page.dart';
import 'package:flutter_first_station/pages/knowledge_vm.dart';
import 'package:flutter_first_station/routes/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget{
  const ChatPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatPageState();
  }

}

class ChatPageState extends State<ChatPage> {

  KnowledgeViewModal viewModal = KnowledgeViewModal();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModal.getKnowledge();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<KnowledgeViewModal>(create: (context){
        return viewModal;
      },
      child: Scaffold(
        body:
        SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 10.r),
            child: Consumer<KnowledgeViewModal>(builder: (context,vm,child){
              return ListView.builder(
                itemBuilder: ( context, int index) {
                  return GestureDetector(
                    onTap: (){
                      RouteUtils.push(context, KnowledgeDetailPage(tabList: vm.list?[index]?.children),);
                    },
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(width: 1.r,color: Colors.grey),borderRadius: BorderRadius.all(Radius.circular(4.r))),
                      width: double.infinity,
                      padding: EdgeInsets.all(10.r),
                      margin: EdgeInsets.symmetric(vertical: 5.r,horizontal: 10.r),
                      child: Row(
                        children: [
                          Expanded(child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              Text(vm.list?[index]?.name??"",style: TextStyle(fontSize: 14.sp,color: Colors.black),),
                              SizedBox(height: 5.h),
                              Text(vm.generalSubTitle(vm.list?[index]?.children),style: TextStyle(fontSize: 12.sp,color: Colors.grey),)
                            ],
                          ),),
                          Image.asset('assets/images/icon_next.png',width: 30.r,height: 30.r,)
                        ],
                      ),
                    ),
                  );
                },
                itemCount: vm.list?.length ?? 0,
              );
            },),
          ),
        ),
      ),
    );
  }


}