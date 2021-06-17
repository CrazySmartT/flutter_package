import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_package/bean/image_bean.dart';
import 'package:plugin_base/flutter_params.dart';
import 'package:plugin_base/message_channel_single.dart';

class NewsImagePage extends StatefulWidget{
  String _imageUrl;
  NewsImagePage([this._imageUrl]);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewsImagePage(_imageUrl);
  }
}

class _NewsImagePage extends State<NewsImagePage>{
  Size size;
  String _imageUrl;

  _NewsImagePage([this._imageUrl]);

  var messageChannel = MessageChannelSingle().getMessageChannel();

  //接收消息监听
  void receiveMessage() {
    messageChannel.setMessageHandler((result) async {
      if(result != null){
        FlutterParams params = FlutterParams.fromJson(jsonDecode(result));
        if(params != null){
          setState(() {
            _imageUrl = params.params["imageUrl"];
          });
        }
      }

      return 'Flutter 已收到消息';
    });
  }


  @override
  void initState() {
    super.initState();
    receiveMessage();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("图片展示")),
      body: GestureDetector(
        onTap: (){
          Map<String,Object> params = HashMap();
          params["event"] = "返回上一个页面";
          FlutterParams flutterParams = FlutterParams(100,params);
          messageChannel.send(jsonEncode(flutterParams));
        },
        child: FadeInImage.assetNetwork(
          placeholder: "images/common_default_holder_light_normal.png",
          width: size.width,
          height: size.width / 3 * 2,
          fit: BoxFit.fill,
          image: _imageUrl == null ? "" : _imageUrl,
        ),
      ) ,
    );
  }
}