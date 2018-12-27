import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> _list_so_type = ["宝贝", "用户"];
  int so_type = 0; // 搜索类型

  List<String> _data_history = []; // 历史记录数据
  List<String> _data_hot = []; // 热搜数据

  @override
  initState() {
    super.initState();
    _data_history = ["万国", "劳力士", "积家", "卡地亚"];
  }

  @override
  void dispose() {
    super.dispose();
  }

  on_so_type_MenuSelection(int v) {
    //更新 搜索类型选择 状态
    setState(() {
      so_type = v;
    });
  }

  Widget _widget_PopupMenuButton() {
    // 弹出搜索类型选项
    return new PopupMenuButton<int>(
        //icon: Icon(Icons.arrow_drop_up,color: Colors.white,),
        offset: Offset(0, 30),
        padding: EdgeInsets.zero,
        //initialValue: _simpleValue,
        onSelected: on_so_type_MenuSelection,
        child: Container(
          child: Row(
            children: <Widget>[
              Text(
                _list_so_type[so_type],
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.grey[800],
              ),
            ],
          ),
          margin: EdgeInsets.only(left: 8),
        ),
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<int>>[
            PopupMenuItem<int>(
                value: 0,
                child: Row(children: [
                  Icon(Icons.favorite_border, color: Colors.deepOrange),
                  SizedBox(
                    width: 8,
                  ),
                  Text('宝贝'),
                ])),
            PopupMenuItem<int>(
                value: 1,
                child: Row(children: [
                  Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('用户')
                ])),
          ];
        });
  }

  Widget searchInput() {
    // 搜索框
    return new Container(
      height: 35,
      child: new Row(
        children: <Widget>[
          _widget_PopupMenuButton(),
          new Expanded(
            child: new TextField(
              autofocus: true,
              decoration: new InputDecoration.collapsed(
                  hintText: "请输入搜索内容...",
                  hintStyle: new TextStyle(color: Colors.grey[700])),
            ),
          )
        ],
      ),
      decoration: new BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(4)),
          color: Colors.grey[300]),
    );
  }

  void _onTap_history_del() {
    // 点击 删除历史 事件
    print("点击了  删除历史按钮");
    setState(() {
      _data_history = []; // 清空历史 状态 数据
    });
  }

  void _onTap_data(String v) {
    //点击 历史或热搜 事件
    print("点击了 ${v}");
  }

  List<Widget> _widgets_history() {
    //历史搜索数据
    List<Widget> _list = [];
    _list = _data_history.map<Widget>((v) {
      // 单个数据 Widget
      return Chip(
          label: GestureDetector(
              onTap: () {
                this._onTap_data(v);
              },
              child: new Text(v)));
    }).toList();
    return _list;
  }

  List<Widget> _widget_body() {
    List<Widget> _body = [];

    if (_data_history.length > 0) {
      // 是否有历史
      _body.add(new Padding(
        // 历史 头部
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("热门搜索",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            GestureDetector(
              child: Icon(Icons.delete_forever),
              onTap: (){
                _onTap_history_del();
              },
            )
          ],
        ),
        padding: const EdgeInsets.all(16),
      ));
      _body.add(Padding(
        //  历史数据
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(spacing: 8, children: _widgets_history()),
      ));
    }
    _body.add(
      new Padding(
        // 热搜头部
        child: new Text("热门搜索",
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
        padding: const EdgeInsets.all(16),
      ),
    );
    _body.add(new Padding( // 热搜数据
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        children: <Widget>[
          Chip(
            label: GestureDetector(onTap: () {}, child: new Text("汽车关税下调")),
          ),
          Chip(label: GestureDetector(onTap: () {}, child: new Text("汽车关税下"))),
          Chip(label: GestureDetector(onTap: () {}, child: new Text("汽车关税"))),
          Chip(
              label: GestureDetector(onTap: () {}, child: new Text("汽车观赏123"))),
        ],
      ),
    ));

    return _body;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: new AppBar(
          title: searchInput(),
          actions: <Widget>[
            new Container(
              child: FlatButton(
                onPressed: () {},
                child: Text("搜索"),
              ),
              width: 60,
            )
          ],
        ),
        body: new SingleChildScrollView(
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _widget_body(),
          )),
        ));
  }
}
