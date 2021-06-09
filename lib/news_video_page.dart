import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsVideoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewsVideoPage();
  }
}

class _NewsVideoPage extends State<NewsVideoPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
          return ListTile(title: Text("视频测试第 $position 条"),);
        },itemCount: 100,),
      ) ,
    );
  }
}