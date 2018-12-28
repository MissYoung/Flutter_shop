import 'package:flutter/material.dart';
import '../widget//good_lists.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.data}) : super(key: key); //构造函数中增加参数
  final String data; //为参数分配空间
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class GoodsTab {
  //商品列表 tab包装 类
  String text;
  GoodList goodList;

  GoodsTab(this.text, this.goodList);
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 保持底部切换状态不变

  List _data_menus = [
    {'title': '菜单1', 'img': ""},
    {'title': '菜单2', 'img': ""},
    {'title': '菜单3', 'img': ""},
    {'title': '菜单4', 'img': ""},
    {'title': '菜单5', 'img': ""},
    {'title': '菜单6', 'img': ""},
    {'title': '菜单7', 'img': ""},
    {'title': '全部', 'img': ""}
  ];

 Key _key_widget_menu_card = Key("_key_widget_menu_card");

  Widget _widget_menu_item(Map v) { // 菜单 item
    return Container( // 可配置整个元素样式
      width: MediaQuery.of(context).size.width/4-4, // -4 是card 默认的
        child: new FlatButton(
            onPressed: () {},
            child: new Container( // 可配置 图标样式
              padding: EdgeInsets.all(8),
              child: new Column(
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.only(bottom: 6.0),
                    child: new CircleAvatar(
                      radius: 20.0,
                      child: new Icon(Icons.invert_colors, color: Colors.white),
                      backgroundColor: new Color(0xFFB88800),
                    ),
                  ),
                  new Container(// 可配置 文字样式
                    child: new Text(v["title"], style: new TextStyle(fontSize: 14.0)),
                  )
                ],
              ),
            )
        )
    );
  }

  Widget _widget_menu_card() {
    return new SliverToBoxAdapter(
        child: Card(
          child: new Wrap(
              alignment: WrapAlignment.center,
              children: _data_menus.map<Widget>((v){
                return _widget_menu_item(v);
              }).toList(),
          ),
        )
    );
  }

  Widget _widget_barSearch() {
    return new Container(
        child: new Row(
          children: <Widget>[
            new Expanded(
                child: new FlatButton.icon(
                  onPressed: () {
                    // 点击事件
                    Navigator.of(context)
                        .push(new MaterialPageRoute(builder: (context) {
                      return new SearchScreen();
                    }));
                  },
                  icon: new Icon(Icons.search, size: 18.0),
                  label: new Text("默认搜索文字"),
                )),
          ],
        ),
        decoration: new BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
        ));
  }

  final List<GoodsTab> myTabs = <GoodsTab>[
    new GoodsTab('最新2', new GoodList(listType: '132')), //listType是参数值
    new GoodsTab('附近', new GoodList(listType: '564')),
    new GoodsTab('推荐', new GoodList(listType: 'guonei')),
    new GoodsTab('鉴定', new GoodList(listType: 'caijing')),
    new GoodsTab('实体认证', new GoodList(listType: 'keji')),
  ];


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: new AppBar(
          elevation: 0,
          title: _widget_barSearch(),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context,
              bool innerBoxIsScrolled) {
            return <Widget>[
              _widget_menu_card(),
              SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context),
                  child: SliverAppBar(
                    //primary: true,
                    // backgroundColor: Colors.transparent,
                    pinned: true, // 是否固定头部导航栏
                    forceElevated: innerBoxIsScrolled,
                    title: TabBar(
                      isScrollable: true,
                      tabs: myTabs.map((GoodsTab item) {
                        //NewsTab可以不用声明
                        return new Tab(
                            text: item.text == null ? '错误' : item.text);
                      }).toList(),
                    ),
                  )),
            ];
          },
          body: TabBarView(
            children: myTabs.map((item) {
              return item.goodList;
            }).toList(),
          ),
        )
        ,
      ),);
  }
}
