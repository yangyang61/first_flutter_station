/// curPage : 1
/// datas : [{"adminAdd":false,"apkLink":"","audit":1,"author":"谷歌开发者","canEdit":false,"chapterId":415,"chapterName":"谷歌开发者","collect":false,"courseId":13,"desc":"","descMd":"","envelopePic":"","fresh":false,"host":"","id":6756,"isAdminAdd":false,"link":"http://mp.weixin.qq.com/s?__biz=MzAwODY4OTk2Mg==&mid=2652046655&idx=1&sn=06accaa623bfc82a531fb7ae1e5af017&chksm=808ca57ab7fb2c6c91021ffa9973bdbd9f45c7b5b74fc54dc25f7bcfa79d58f5ddafc643d2b7&scene=38#wechat_redirect","niceDate":"2018-07-13 00:00","niceShareDate":"未知时间","origin":"","prefix":"","projectLink":"","publishTime":1531411200000,"realSuperChapterId":407,"selfVisible":0,"shareDate":null,"shareUser":"","superChapterId":408,"superChapterName":"公众号","tags":[{"name":"公众号","url":"/wxarticle/list/415/1"}],"title":"探险家开发者 Niek Bo<em class='highlight'>kke</em>rs 的故事 | #IMakeApps","type":0,"userId":-1,"visible":1,"zan":0}]
/// offset : 0
/// over : true
/// pageCount : 1
/// size : 20
/// total : 1

class SearchListData {
  SearchListData({
      this.curPage, 
      this.datas, 
      this.offset, 
      this.over, 
      this.pageCount, 
      this.size, 
      this.total,});

  SearchListData.fromJson(dynamic json) {
    curPage = json['curPage'];
    if (json['datas'] != null) {
      datas = [];
      json['datas'].forEach((v) {
        datas?.add(SearchListItemData.fromJson(v));
      });
    }
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }
  num? curPage;
  List<SearchListItemData>? datas;
  num? offset;
  bool? over;
  num? pageCount;
  num? size;
  num? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['curPage'] = curPage;
    if (datas != null) {
      map['datas'] = datas?.map((v) => v.toJson()).toList();
    }
    map['offset'] = offset;
    map['over'] = over;
    map['pageCount'] = pageCount;
    map['size'] = size;
    map['total'] = total;
    return map;
  }

}

/// adminAdd : false
/// apkLink : ""
/// audit : 1
/// author : "谷歌开发者"
/// canEdit : false
/// chapterId : 415
/// chapterName : "谷歌开发者"
/// collect : false
/// courseId : 13
/// desc : ""
/// descMd : ""
/// envelopePic : ""
/// fresh : false
/// host : ""
/// id : 6756
/// isAdminAdd : false
/// link : "http://mp.weixin.qq.com/s?__biz=MzAwODY4OTk2Mg==&mid=2652046655&idx=1&sn=06accaa623bfc82a531fb7ae1e5af017&chksm=808ca57ab7fb2c6c91021ffa9973bdbd9f45c7b5b74fc54dc25f7bcfa79d58f5ddafc643d2b7&scene=38#wechat_redirect"
/// niceDate : "2018-07-13 00:00"
/// niceShareDate : "未知时间"
/// origin : ""
/// prefix : ""
/// projectLink : ""
/// publishTime : 1531411200000
/// realSuperChapterId : 407
/// selfVisible : 0
/// shareDate : null
/// shareUser : ""
/// superChapterId : 408
/// superChapterName : "公众号"
/// tags : [{"name":"公众号","url":"/wxarticle/list/415/1"}]
/// title : "探险家开发者 Niek Bo<em class='highlight'>kke</em>rs 的故事 | #IMakeApps"
/// type : 0
/// userId : -1
/// visible : 1
/// zan : 0

class SearchListItemData {
  SearchListItemData({
      this.adminAdd, 
      this.apkLink, 
      this.audit, 
      this.author, 
      this.canEdit, 
      this.chapterId, 
      this.chapterName, 
      this.collect, 
      this.courseId, 
      this.desc, 
      this.descMd, 
      this.envelopePic, 
      this.fresh, 
      this.host, 
      this.id, 
      this.isAdminAdd, 
      this.link, 
      this.niceDate, 
      this.niceShareDate, 
      this.origin, 
      this.prefix, 
      this.projectLink, 
      this.publishTime, 
      this.realSuperChapterId, 
      this.selfVisible, 
      this.shareDate, 
      this.shareUser, 
      this.superChapterId, 
      this.superChapterName, 
      this.tags, 
      this.title, 
      this.type, 
      this.userId, 
      this.visible, 
      this.zan,});

  SearchListItemData.fromJson(dynamic json) {
    adminAdd = json['adminAdd'];
    apkLink = json['apkLink'];
    audit = json['audit'];
    author = json['author'];
    canEdit = json['canEdit'];
    chapterId = json['chapterId'];
    chapterName = json['chapterName'];
    collect = json['collect'];
    courseId = json['courseId'];
    desc = json['desc'];
    descMd = json['descMd'];
    envelopePic = json['envelopePic'];
    fresh = json['fresh'];
    host = json['host'];
    id = json['id'];
    isAdminAdd = json['isAdminAdd'];
    link = json['link'];
    niceDate = json['niceDate'];
    niceShareDate = json['niceShareDate'];
    origin = json['origin'];
    prefix = json['prefix'];
    projectLink = json['projectLink'];
    publishTime = json['publishTime'];
    realSuperChapterId = json['realSuperChapterId'];
    selfVisible = json['selfVisible'];
    shareDate = json['shareDate'];
    shareUser = json['shareUser'];
    superChapterId = json['superChapterId'];
    superChapterName = json['superChapterName'];
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags?.add(Tags.fromJson(v));
      });
    }
    title = json['title'];
    type = json['type'];
    userId = json['userId'];
    visible = json['visible'];
    zan = json['zan'];
  }
  bool? adminAdd;
  String? apkLink;
  num? audit;
  String? author;
  bool? canEdit;
  num? chapterId;
  String? chapterName;
  bool? collect;
  num? courseId;
  String? desc;
  String? descMd;
  String? envelopePic;
  bool? fresh;
  String? host;
  num? id;
  bool? isAdminAdd;
  String? link;
  String? niceDate;
  String? niceShareDate;
  String? origin;
  String? prefix;
  String? projectLink;
  num? publishTime;
  num? realSuperChapterId;
  num? selfVisible;
  dynamic shareDate;
  String? shareUser;
  num? superChapterId;
  String? superChapterName;
  List<Tags>? tags;
  String? title;
  num? type;
  num? userId;
  num? visible;
  num? zan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adminAdd'] = adminAdd;
    map['apkLink'] = apkLink;
    map['audit'] = audit;
    map['author'] = author;
    map['canEdit'] = canEdit;
    map['chapterId'] = chapterId;
    map['chapterName'] = chapterName;
    map['collect'] = collect;
    map['courseId'] = courseId;
    map['desc'] = desc;
    map['descMd'] = descMd;
    map['envelopePic'] = envelopePic;
    map['fresh'] = fresh;
    map['host'] = host;
    map['id'] = id;
    map['isAdminAdd'] = isAdminAdd;
    map['link'] = link;
    map['niceDate'] = niceDate;
    map['niceShareDate'] = niceShareDate;
    map['origin'] = origin;
    map['prefix'] = prefix;
    map['projectLink'] = projectLink;
    map['publishTime'] = publishTime;
    map['realSuperChapterId'] = realSuperChapterId;
    map['selfVisible'] = selfVisible;
    map['shareDate'] = shareDate;
    map['shareUser'] = shareUser;
    map['superChapterId'] = superChapterId;
    map['superChapterName'] = superChapterName;
    if (tags != null) {
      map['tags'] = tags?.map((v) => v.toJson()).toList();
    }
    map['title'] = title;
    map['type'] = type;
    map['userId'] = userId;
    map['visible'] = visible;
    map['zan'] = zan;
    return map;
  }

}

/// name : "公众号"
/// url : "/wxarticle/list/415/1"

class Tags {
  Tags({
      this.name, 
      this.url,});

  Tags.fromJson(dynamic json) {
    name = json['name'];
    url = json['url'];
  }
  String? name;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['url'] = url;
    return map;
  }

}