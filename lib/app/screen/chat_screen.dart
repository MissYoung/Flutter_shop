import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:zdk_app/app/model/message_model.dart';
import 'package:zdk_app/app/screen/buy_screen.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {

  List<MessageModel> msgs=[];
  ScrollController _controller;


  Widget _item_row_1(MessageModel message){//发送给我的
    return Container(
        padding: EdgeInsets.only(right: 32),
        child:Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: CircleAvatar(
                backgroundImage: new  CachedNetworkImageProvider(message.avatar),
                radius: 18,
              ),
            ),
            Expanded(
              child: new Wrap(
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration( color: Colors.orange[100],borderRadius: BorderRadius.circular(4)),
                    padding: EdgeInsets.all(8),
                    child: Text(message.msg),
                  )
                ],),
            ),

          ],
        )
    );
  }
  Widget _item_row_2(MessageModel message){// 我发送的
    return Container(
        padding: EdgeInsets.only(left: 32),
        child:Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: CircleAvatar(
                backgroundImage: new  CachedNetworkImageProvider(message.avatar),
                radius: 18,
              ),
            ),
            Expanded(
                child: new Wrap( // 受 row 影响  需要用弹性布局 包装Container 才能根据文字自适应小
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration( color: Colors.green[100],borderRadius: BorderRadius.circular(4)),
                      padding: EdgeInsets.all(8),
                      child: Text(message.msg),
                    )
                ],),
            ),

          ],
        )
    );
  }

  Widget _item_row_3(MessageModel message){// 系统的等等++
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child:Container(
          color: Colors.white,
          padding: EdgeInsets.all(8),
          child: Text("我是系统类消息。。。"),
        )
    );
  }

  Widget _item_row_time(MessageModel message){// 时间分割
    return Container(
      margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration( color: Colors.grey[400],borderRadius: BorderRadius.circular(4)),
          padding: EdgeInsets.symmetric(horizontal: 6,vertical: 3),
          child: Text("2018-08-08 08:08:08",style: TextStyle(fontSize: 12,color: Colors.white),),
    );
  }

 Widget _itemBuilder(c,i){ // item 未封装 后期为节省时间 以后暂时都不封装
    List<Widget> rows=[];

    if(i%3==0){// 判断2个时间戳是否相隔 N 分钟 超过就添加时间分割Widget
      rows.add(_item_row_time(msgs[i]));
    }

   switch(msgs[i].type) {// 分根据类型 添加 Widget
     case 1:
       rows.add(_item_row_1(msgs[i]));
       break;
     case 2:
       rows.add(_item_row_2(msgs[i]));
       break;
     default:
       rows.add(_item_row_3(msgs[i]));

   }

    return Container(
      padding: EdgeInsets.all(8),
      child: Column(children: rows,),
    );
  }

  Random _random;

@override
  initState(){
    _random =new Random();
    _controller=new ScrollController();
    setState((){
      msgs=List.generate(10, (i){
         int type=_random.nextInt(2)+1;
        return new MessageModel(name: "昵称${type}",avatar: "https://picsum.photos/128/128?image=${type}",msg: "我是内容哦我是内容哦我是内容哦我是内容哦我是内容哦我是内容哦我是内容哦我是内容哦",type:  type);
      }).toList();

      _add_new();
      //_controller.jumpTo(3);
    });
  }

  @override
  void dispose() {
    ///页面销毁时，销毁控制器
    _controller.dispose();
    super.dispose();
  }

  _add_up(){ // 添加上一页消息
    msgs.insertAll(0, []);
  }
  _add_new(){// 添加最新消息
    List<MessageModel> msgs2 = List.generate(10, (i){ // 测试二
      int type=_random.nextInt(3)+1;
      return new MessageModel(name: "昵称${type}",avatar: "https://picsum.photos/128/128?image=${type}",msg: "我是内容",type:  type);
    }).toList();

    new Timer(Duration(milliseconds: 1200), () {
      msgs.addAll(msgs2);

    });
  }

  Widget _widget_appBar_bottom(){
    List<Widget>  _rows = [];
    _rows.add(
        CachedNetworkImage(
          width: 80,
          height: 80,
        placeholder:  CircularProgressIndicator(),
        imageUrl: 'https://picsum.photos/750/500?image=1',
        errorWidget:  Icon(Icons.error),
          fit: BoxFit.cover,
      )
    );

    _rows.add(
      Container(
          padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("￥ 35.00",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
            Text("含运费10.00元",style: TextStyle(fontSize: 12,color: Colors.grey[600]),),
            Expanded(child: SizedBox(),),
            Text("交易前聊一聊",style: TextStyle(fontSize: 12,color: Colors.grey[600]),),
          ],
        )
      )
    );
    
    _rows.add(Expanded(child: SizedBox()));// 占位

    _rows.add(RaisedButton(
      textColor: Colors.white,
      color: Colors.red[500],
      child: Text("立即购买"),
      onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return new BuyScreen(goodModel: null,);
        }));
      },
    ));
    
    return PreferredSize(
      preferredSize: Size.fromHeight(90),
      child: Container(
        height: 90,
        child: Row(children: _rows,),
        decoration: BoxDecoration(color: Colors.white,border: BorderDirectional(top: BorderSide(width: 0.2))),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text('对方昵称',),
        bottom: _widget_appBar_bottom()
      ),
      body: Container(
    child: ListView.builder(
      controller: _controller,
    itemCount:msgs.length ,
    itemBuilder: (context, index)=>_itemBuilder(context,index)
    ),
      )
    );
  }
}