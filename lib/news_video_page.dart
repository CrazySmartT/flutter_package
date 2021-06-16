import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_package/bean/image_bean.dart';

import 'news_image_list_page.dart';

class NewsVideoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewsVideoPage();
  }
}

class _NewsVideoPage extends State<NewsVideoPage>{
  // MethodChannel methodChannel = MethodChannel('com.yiche.flutter.methodChannel');
  // EventChannel eventChannel = EventChannel('com.yiche.flutter.eventChannel');
  List<ImageBean> _listData;
  Size size;

  //创建 BasicMessageChannel
  // flutter_and_native_100 为通信标识
  // StandardMessageCodec() 为参数传递的 编码方式
  static const messageChannel = const BasicMessageChannel(
      'com.yiche.flutter.methodChannel', StandardMessageCodec());

  //接收消息监听
  void receiveMessage() {
    messageChannel.setMessageHandler((result) async {
      setState(() {
        final parsed = jsonDecode(result.toString()).cast<Map<String, dynamic>>();
        setState(() {
          _listData = parsed.map<ImageBean>((json) => ImageBean.fromJson(json)).toList();
        });
      });
      return 'Flutter 已收到消息';
    });
  }


  @override
  void initState() {
    super.initState();
    // eventChannel.receiveBroadcastStream().listen(_onEvent);
    receiveMessage();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(_listData != null ? " 首页推荐数据 " : "视频列表"),),
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
                Text(imageBean == null ? "视频测试第 $position 条" : "首页Banner ${imageBean.title}"),
                Offstage(
                    child: GestureDetector(
                      onTap: (){
                        messageChannel.send("跳转页面");
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return NewsImagePage(imageBean.image);
                        }));
                        // methodChannel.invokeMethod("跳转页面",imageBean != null ? imageBean.urlschema : "");
                      },
                      child: FadeInImage.assetNetwork(
                        placeholder: "images/common_default_holder_light_normal.9.png",
                        width: size.width,
                        height: size.width / 3 * 2,
                        fit: BoxFit.fill,
                        image: imageBean != null ? imageBean.image == null ? " " : imageBean.image : "",
                      ),
                    ),
                    offstage: imageBean == null,
                  ),
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