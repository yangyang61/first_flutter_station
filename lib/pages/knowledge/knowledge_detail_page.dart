import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_station/pages/knowledge/Knowledge_detail_vm.dart';
import 'package:flutter_first_station/pages/knowledge/knowledge_tab_child_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../repository/datas/knowledge_list_data.dart';

class KnowledgeDetailPage extends StatefulWidget {
  const KnowledgeDetailPage({super.key, this.tabList});

  final List<KnowledgeChildren>? tabList;

   @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _KnowledgeDetailPageState();
  }

}

class _KnowledgeDetailPageState extends State<KnowledgeDetailPage> with SingleTickerProviderStateMixin {

  KnowledgeDetailViewModal viewModal = KnowledgeDetailViewModal();
  
  late TabController tabController;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: widget.tabList?.length??0, vsync: this);
    viewModal.initTabs(widget.tabList);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<KnowledgeDetailViewModal>(create: (context){
      return viewModal;
      },
      child: Scaffold(
      appBar: AppBar(
        title: TabBar(
          splashBorderRadius: BorderRadius.all(Radius.circular(10.r)),
          tabs: viewModal.tabs ,
          controller: tabController,
          labelColor: Colors.blue,
          indicatorColor: Colors.blue,
          isScrollable:true
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: children()
      ),
    ));
  }

  List<Widget> children() {
    return widget.tabList?.map((e) {
      return KnowledgeTabChildPage(cid:"${e.id??""}");
    }).toList() ?? [];
  }

}