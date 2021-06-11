import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_package/bean/image_bean.dart';

class NewsVideoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewsVideoPage();
  }
}

class _NewsVideoPage extends State<NewsVideoPage>{
  MethodChannel methodChannel = MethodChannel('com.yiche.flutter.methodChannel');
  EventChannel eventChannel = EventChannel('com.yiche.flutter.eventChannel');
  List<ImageBean> _listData;

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_onEvent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("视频列表"),),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification){
          if(notification is OverscrollNotification){
            print("OverScrollNotification");
          }
          return false;
        },
        child: ListView.builder(itemBuilder: (context,position){
          ImageBean imageBean;
          if(_listData != null && _listData.length > 0){
            imageBean = _listData[position];
          }

          return Container(
            child: Column(
              children: <Widget>[
                Text("视频测试第 $position 条 "),
                Offstage(child: Image.network(imageBean != null ? imageBean.urlschema : ""),offstage: imageBean == null,)
              ],
            ),
          );
        },itemCount: _listData != null && _listData.length > 0 ? _listData.length : 100,),
      ) ,
    );
  }

  _onEvent(Object event){
    if(event != null){
      final parsed = jsonDecode(event.toString()).cast<Map<String, dynamic>>();
      setState(() {
        _listData = parsed.map<ImageBean>((json) => ImageBean.fromJson(json)).toList();
      });
    }
  }
}