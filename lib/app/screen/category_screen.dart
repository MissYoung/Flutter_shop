import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/* 分类 */
class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true; // 保持状态不变

  List _list_left = []; // List<CategoryModel>
  List _list_right = [];

  int _list_left_selected = 0;

  _test_data(List list, int len) {
    List.generate(len, (i) {
      //
      list.add(i);
    });
  }

  @override
  initState() {
    super.initState();
    _test_data(_list_left, 20);
    _test_data(_list_right, 20);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _list_left_onTap(int i) {
    //左侧点击事件
    print("点击了第 ${i} 个");
    setState(() {
      _list_left_selected = i; // 更新左侧选中状态
      // 更新右侧数据
    });
  }

  void _list_right_onTap(String data) {
    // 右侧点击事件
    print("点击了" + data);
  }

  Widget _widget_left() {
    return ListView.builder(
        itemCount: _list_left.length, itemBuilder: _widget_left_item);
  }

  Widget _widget_right() {
    List<Widget> _slivers = []; //sliver 家族集合

    /* begin 模拟数据----------------------------------------- */

    _slivers.add(_widget_right_item_title("我是标题")); // 添加 标题

    Widget _sliverGrid = SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
      delegate: SliverChildBuilderDelegate(_widget_right_item, childCount: 9),
    );
    _slivers.add(_sliverGrid); // 添加 item

    _slivers.add(_widget_right_item_title("我是标题2"));
    // 添加 标题
    _sliverGrid = SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
      delegate: SliverChildBuilderDelegate(_widget_right_item, childCount: 9),
    );
    _slivers.add(_sliverGrid); // 添加 item

    _slivers.add(_widget_right_item_title("我是标题3"));
    // 添加 标题
    _sliverGrid = SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
      delegate: SliverChildBuilderDelegate(_widget_right_item, childCount: 5),
    );
    _slivers.add(_sliverGrid); // 添加 item

    /* begin 模拟数据----------------------------------------- */

    _slivers.add(SliverPadding(
      padding: EdgeInsets.only(top: 32),
    )); // 添加底部边距 解决底部 发布按钮遮挡item

    return CustomScrollView(slivers: _slivers);
  }

  Widget _widget_left_item(BuildContext context, int i) {
    Widget _item = SizedBox();

    if (_list_left_selected == i) {
      // 是否选中
      _item = Container(
          child: FlatButton(
              child: Text("我是分类${i}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              onPressed: () {
                _list_left_onTap(i);
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.symmetric(vertical: 15),
              color: Colors.red));
    } else {
      _item = Container(
          child: FlatButton(
        child: Text("我是分类${i}"),
        onPressed: () {
          _list_left_onTap(i);
        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.symmetric(vertical: 15),
      ));
    }

    return _item;
  }

  Widget _widget_right_item_title(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Text(
          title,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Widget _widget_right_item(BuildContext context, int i) {
    Widget _item = SizedBox();
    _item = GestureDetector(
        onTap: () {
          _list_right_onTap(i.toString());
        },
        child: Container(
          child: Column(
            children: <Widget>[
              new CachedNetworkImage(
                width: 64,
                height: 64,
                placeholder: new CircularProgressIndicator(),
                imageUrl: 'https://picsum.photos/64/64?image=${i}',
                // 图片引用
                errorWidget: new Icon(Icons.error),
              ),
              SizedBox(
                height: 5,
              ),
              Text("小标题")
            ],
          ),
        ));

    return _item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.5,
          title: Text("分类选择"),
        ),
        body: Row(
          children: <Widget>[
            new Container(
                width: 120,
                decoration: BoxDecoration(
                    border: Border(
                        right:
                            BorderSide(color: Colors.grey[300], width: 0.8))),
                child: _widget_left()),
            new Expanded(child: _widget_right())
          ],
        )

        // _widget_right()

        );
  }
}
