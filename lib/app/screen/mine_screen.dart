import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MineScreen extends StatefulWidget {
  @override
  _MineScreenState createState() => _MineScreenState();
}

class _MineScreenState extends State<MineScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true; // 保持底部切换状态不变

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('个人中心'),
        ),
        body: new ListView(
          children: <Widget>[
            Container(
              height: 80,
              color: Colors.white,
              child: new ListTile(
                leading: CachedNetworkImage(
                  width: 48,
                  height: 48,
                  placeholder: new CircularProgressIndicator(),
                  imageUrl: 'https://picsum.photos/64/64',
                  errorWidget: new Icon(Icons.error),
                ),
                title: new Text("Tony"),
                subtitle: new Text("各种图标显示处"),
                trailing: new Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
            new Container(
              child: new ListTile(
                leading: new Icon(Icons.add_a_photo,color: Colors.green[400],),
                title: new Text("我发布的"),
              ),
              margin: EdgeInsets.only(top: 16),
              color: Colors.white,
            ),
            new Container(
              child: new ListTile(
                leading: new Icon(Icons.business_center,color: Colors.blue[400],),
                title: new Text("我买到的"),
              ),
              color: Colors.white,
            ),
            new Container(
              child: new ListTile(
                leading: new Icon(Icons.airport_shuttle,color: Colors.deepOrangeAccent[400],),
                title: new Text("我卖出的"),
              ),
              color: Colors.white,
            ),
            new Container(
              child: new ListTile(
                leading: new Icon(Icons.favorite,color: Colors.red[400],),
                title: new Text("我喜欢的"),
              ),
              color: Colors.white,
            ),
            new Container(
              child: new ListTile(
                leading: new Icon(Icons.settings,color: Colors.orange[400],),
                title: new Text("设置"),
              ),
              color: Colors.white,
              margin: EdgeInsets.only(top: 16),
            )
          ],
        ));
  }
}
