import 'package:flutter/cupertino.dart';

import '../repository/api.dart';
import '../repository/datas/knowledge_list_data.dart';

class KnowledgeViewModal with ChangeNotifier{
    List<KnowledgeListData?>? list;

    Future getKnowledge() async {
      List<KnowledgeListData?>? listData = await Api.instance.getKnowledge();
      list = listData ?? [];
    }

    String generalSubTitle(List<KnowledgeChildren?>? children) {
      if(children==null || children.isEmpty ==true){
        return "";
      }
      StringBuffer stringBuffer = StringBuffer();
      for (var element in children) {
        stringBuffer.write("${element?.name} ");
      }
      return stringBuffer.toString();
    }
}