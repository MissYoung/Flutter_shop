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

  Widget _widget_menu_card() {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
    child: new Card(
      //color: GlobalConfig.cardBackgroundColor,
      child:  new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Container(
            child: new FlatButton(
                onPressed: (){},
                child: new Container(
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
                      new Container(
                        child: new Text("菜单", style: new TextStyle( fontSize: 14.0)),
                      )
                    ],
                  ),
                )
            ),
          ),
          new Container(
            child: new FlatButton(
                onPressed: (){},
                child: new Container(
                  padding: EdgeInsets.all(8),
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.only(bottom: 6.0),
                        child: new CircleAvatar(
                          radius: 20.0,
                          child: new Icon(Icons.golf_course, color: Colors.white),
                          backgroundColor: new Color(0xFF63616D),
                        ),
                      ),
                      new Container(
                        child: new Text("菜单2", style: new TextStyle( fontSize: 14.0)),
                      )
                    ],
                  ),
                )
            ),
          ),
          new Container(
            child: new FlatButton(
                onPressed: (){
                  setState((){

                  });
                },
                child: new Container(
                  padding: EdgeInsets.all(8),
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.only(bottom: 6.0),
                        child: new CircleAvatar(
                          radius: 20.0,
                          child: new Icon( Icons.wb_sunny, color: Colors.white),
                          backgroundColor: new Color(0xFFB86A0D),
                        ),
                      ),
                      new Container(
                        child: new Text("菜单3", style: new TextStyle(fontSize: 14.0)),
                      )
                    ],
                  ),
                )
            ),
          ),
          new Container(
            child: new FlatButton(
                onPressed: (){},
                child: new Container(
                  padding: EdgeInsets.all(8),
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.only(bottom: 6.0),
                        child: new CircleAvatar(
                          radius: 20.0,
                          child: new Icon(Icons.category, color: Colors.white),
                          backgroundColor: Colors.deepOrange,
                        ),
                      ),
                      new Container(
                        child: new Text("全部分类", style: new TextStyle(fontSize: 14.0)),
                      )
                    ],
                  ),
                )
            ),
          ),
        ],
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
                SliverToBoxAdapter(
                  child: _widget_menu_card(),
                ),
                SliverToBoxAdapter(
                  child: _widget_menu_card(),
                ),
              SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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
