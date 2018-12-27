import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'gallery_photo_view_wrapper.dart';
import 'package:zdk_app/app/screen/chat_screen.dart';
import 'package:zdk_app/app/screen/buy_screen.dart';
//产品详情
class GoodInfo extends StatefulWidget {
  final String index; //列表类型
 // final GoodModel _goodModel;
  @override
  GoodInfo({Key key, this.index}) : super(key: key);

  _GoodInfoState createState() => new _GoodInfoState();
}

class _GoodInfoState extends State<GoodInfo> {
   String index;

  void open_img(BuildContext context, final int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GalleryPhotoViewWrapper(
            backgroundDecoration: const BoxDecoration(
              color: Colors.black87,
            ),
            imageProviders: List.generate(5, (gi){
              return CachedNetworkImageProvider("https://picsum.photos/350/500?image=${gi}");
            }).toList(),
            index: index,
          ),
        ));
  }
  @override
  void initState() {
    super.initState();
    this.index = this.widget.index;
  }

  Widget _widget_price(){
    return new Padding(
      padding: EdgeInsets.only(top: 8),
      child: new Row(
        children: <Widget>[
          new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text("￥",
                  style: new TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              new Text(
                "100",
                style: new TextStyle(
                    color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          _widget_tag("不讲价"),
          _widget_tag("9成新"),
        ],
      ),
    );
  }
  Widget _widget_tag(@required String text) {

    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 6,vertical: 0),
      margin: EdgeInsets.only(left: 8),
      child: Text(text, style: new TextStyle(fontSize: 10)),
      decoration:  new BoxDecoration(
        color: Colors.grey,
        borderRadius: new BorderRadius.circular(2)
      ),
    );
  }

  Widget _widget_hd() {
    return new Container(
      padding: EdgeInsets.only(top: 16, left: 8,right: 8,bottom: 4),
      child: Column(children: <Widget>[
        Row(children: <Widget>[
          new CircleAvatar(
            backgroundImage: new NetworkImage(
                "http://img2.woyaogexing.com/2018/12/17/e2280e5a89814d96af49c98402e28cbd!400x400.jpeg"),
            radius: 20.0,
          ),
          new Padding(
              padding: new EdgeInsets.only(left: 8),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("我是昵称",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                  new Text("发布于北京",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              )),
        ]),
        new Divider(
          color: Colors.grey,
        ), //分割线控件
      _widget_price(),
      ]),
    );
  }

  List<Widget> _widget_imgs(){
    return List<Widget>.generate(4, (gi) {
      return new Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 8),
        child: GestureDetector(
          onTap: () {
            open_img(context, gi+1);
          },
        child: new CachedNetworkImage( // 图片层
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
              placeholder: new CircularProgressIndicator(),
              imageUrl: 'https://picsum.photos/350/500?image=${gi+1}',
              errorWidget: new Icon(Icons.error),

            )
    )
      );
    }).toList();
  }

  Widget _widget_bd(){
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(padding: EdgeInsets.only(bottom: 8),
          child: new Text("${index}-HP/惠普810G2 旋转变形触控笔记本电脑 手提学生商务游戏本 配置：酷睿i7 4600U处理器 8G内存 128G M.2高速固态硬盘 11.6寸可手触变形屏幕 PC平板二合一设计带背光灯键盘 手感很好 电池待机5小时左右 开机仅不到十秒瞬开 ！",textAlign: TextAlign.left,style: new TextStyle(fontSize: 16),),),
          GestureDetector(
            onTap: () {
              open_img(context, 0);
            },
            child:new Hero(
              tag:'list-info${index}',
              child: new CachedNetworkImage(// 图片层
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
                placeholder: new CircularProgressIndicator(),
                imageUrl: 'https://picsum.photos/300/500?image=${index}',
                errorWidget: new Icon(Icons.error),
              )
          ),
    ),
          new Column(
            children: _widget_imgs()
          )
        ]
      )
    );
  }

   _widget_bt(){
    List<Widget> list = <Widget>[];

    Color _icon_favorite_color=Colors.grey[800];
    Icon  _icon_favorite=Icon(Icons.favorite_border,color: _icon_favorite_color,);

    list.add(
      FlatButton.icon(
        icon: _icon_favorite,
        label: Text("想要"),
        onPressed: () {
          // Perform some action
        },
      ),
    );
    list.add(Expanded(child: SizedBox()));// 占位
    list.add(
        RaisedButton(
          textColor: Colors.white,
          color: Colors.orange[800],
          child: Text('聊一聊'),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return new ChatScreen();
            }));
          },
      )
    );
    list.add(
      Container(
        margin: EdgeInsets.only(left: 8),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.red[500],
            child: Text('立即购买'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return new BuyScreen(goodModel: null,);
              }));
            },
        )
      )
    );
    return BottomAppBar(
      child: Container(
        padding:EdgeInsets.symmetric(horizontal: 8),
        child: Row(children: list),
      ),
    );
   }
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      top: false,
      bottom: false,
      child: Builder(builder: (BuildContext context) {
        return new Scaffold(
          backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0,
              centerTitle: true,
              title: Text( '￥340', style: new TextStyle(color: Colors.red, fontWeight: FontWeight.bold), ),
              backgroundColor: Colors.grey[200],
            ),
            body: new SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _widget_hd(),
                  _widget_bd()
                ],
            )),
          bottomNavigationBar: _widget_bt(),
        );
      }),
    );
  }
}
