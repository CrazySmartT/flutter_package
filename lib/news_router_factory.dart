import 'package:flutter/cupertino.dart';
import 'package:plugin_base/router_factory.dart';

import 'news_video_page.dart';

class NewsFactory extends RouterFactory{
  @override
  Map<String, WidgetBuilder> getRouterMap() {
    Map<String, WidgetBuilder> map = new Map();
    map["/videoPage"] = (BuildContext context) => NewsVideoPage();
    return map;
  }
}