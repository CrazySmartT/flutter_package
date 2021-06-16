import 'package:flutter/cupertino.dart';
import 'package:flutter_package/news_image_list_page.dart';
import 'package:plugin_base/router_factory.dart';

import 'news_video_page.dart';

class NewsFactory extends RouterFactory{
  @override
  Map<String, WidgetBuilder> getRouterMap() {
    Map<String, WidgetBuilder> map = new Map();
    map["/videoPage"] = (BuildContext context) => NewsVideoPage();
    map["/imagePage"] = (BuildContext context) => NewsImagePage();
    return map;
  }
}