import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'item/good_item.dart';
//产品列表
class GoodList extends StatefulWidget {
  final String listType; //列表类型
  @override
  GoodList({Key key, this.listType}) : super(key: key);

  _GoodListState createState() => new _GoodListState();
}

class _GoodListState extends State<GoodList>
    with AutomaticKeepAliveClientMixin {

@override
  bool get wantKeepAlive => true; // 保持底部切换状态不变
  var _ipAddress = 'Unknown';

  List data;
  String listType;
  int loadState=0; // 0 不显示  1加载中  2 没有了

  int _itemCount=10;

  @override
  void initState() {
    super.initState();
    listType=widget.listType;
  }

void _getMoretEvent( ) {
       if(loadState==0){ // 可继续加载状态
         print("我开始执行加载事件了...........................................");
         setState(() {loadState= 1; });
         _getMore("");
       }
}



  //HTTP请求的函数返回值为异步控件Future
  _getMore(String category) async {

    setState(() {
      loadState= 1;
    });
/*
    var url = 'http://192.68.192/1.php';
    var httpClient = new HttpClient();
    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        print(json);
        var data = jsonDecode(json);
        result = data['reason'];
      } else {
        result =
            'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed getting IP address';
    }
    if (!mounted) return;

    setState(() {
      loadState= 2;
    });*/
    if (!mounted) return;
    new Timer(Duration(seconds: 2), () {

      // 添加数据，更新界面
        setState(() {
        print(_itemCount);
          if(_itemCount>=18){
            loadState= 2; // 没有了
            return;// 终止
          }

          _itemCount+=10;// 更新10条
          loadState= 0; // 可继续加载
        });

    });
  }

 Widget _widget_more(){
    List<Widget> list= new List();

    if(loadState==1){
      list.add( new Container(margin:EdgeInsets.only(right: 16),width:20,height: 20,child:new CircularProgressIndicator()));
      list.add(new Text("加载中..."));
    }
    if(loadState==2){
      list.add(new Text("暂时没有更多了。。。"));
    }
    return new SliverToBoxAdapter(
        child: new Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(bottom: 26),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,mainAxisSize: MainAxisSize.min,
                  children:list,
            ),
        )
    );
 }
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return NotificationListener<ScrollEndNotification>( // or  OverscrollNotification
              onNotification: (ScrollEndNotification  scroll){
                if(scroll.metrics.pixels==scroll.metrics.maxScrollExtent){ // Scroll End
                  print("我监听到我滑到底部了");
                  _getMoretEvent();
                }

              },
              child: CustomScrollView(
            slivers: <Widget>[
                SliverOverlapInjector(
                // This is the flip side of the SliverOverlapAbsorber above.
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                new SliverStaggeredGrid.countBuilder(
                  itemCount: _itemCount,
                  crossAxisCount: 4,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  itemBuilder: (context, index) => new GoodItem(index),
                  staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
                ),
              _widget_more(),
            ],
          )
          );
        },
      ),
    );
  }
}

