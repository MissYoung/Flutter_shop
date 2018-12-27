import 'package:flutter/material.dart';
import 'package:zdk_app/app/screen/home_screen.dart';
import 'package:zdk_app/app/screen/category_screen.dart';
import 'package:zdk_app/app/screen/message_screen.dart';
import 'package:zdk_app/app/screen/mine_screen.dart';
import 'package:zdk_app/app/screen/blank_screen.dart';

class MainWiget extends StatefulWidget {
  @override
  _MainWigetState createState() => _MainWigetState();
}

class _MainWigetState extends State<MainWiget>
    with SingleTickerProviderStateMixin {
  List<StatefulWidget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    BlankScreen(),// 空白
    MessageScreen(),
    MineScreen()
  ]; // 底部导航页面

  final _bottomNavigationTextColor = Colors.black; // 导航字体颜色
  final _bottomNavigationIconColor = Colors.black; // 导航默认图标颜色
  final _bottomNavigationActiveIconColor = Colors.deepOrange; // 导航选中图标颜色


  int _currentIndex = 0; // 当前 页面 下标
  var _controller = PageController(
    initialPage: 0, // 底部 初始化页面 和状态
  );

  _onAdd(){
    setState(() {

    });
  }

  @override
  void dispose() {
    // 销毁函数
    super.dispose();
    _controller.dispose();
  }

  Widget _widget_bottom_bar(){
    /*
    *         onTap: (index) {
          var _index=index;
          if(_index==2){// tab添加被点击
            _onAdd();
            return;
          }
         // _controller.animateToPage(_index, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn); // 动画效果 切换
          _controller.jumpToPage(_index); // 无动画效果切换
          setState(() {
            _currentIndex = _index;
          });
        }
    * */


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: _pages,
        physics: NeverScrollableScrollPhysics(), // 进制滑动切换
      ),
      floatingActionButton: new Builder(builder: (BuildContext context) {
        return new FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          onPressed: _onAdd,
          child: const Icon(Icons.add, color: Colors.white),
          //tooltip: "发布", // 常按显示提示
          //heroTag: null, // 去除系统默认动画效果
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // 添加按钮位置
      bottomNavigationBar: BottomNavigationBar(//底部导航点击事件
        currentIndex: _currentIndex,
        onTap: (index) {
          var _index=index;
          if(_index==2){// tab添加被点击
            _onAdd();
            return;
          }
         // _controller.animateToPage(_index, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn); // 动画效果 切换
          _controller.jumpToPage(_index); // 无动画效果切换
          setState(() {
            _currentIndex = _index;
          });
        },
        type: BottomNavigationBarType.fixed,
        //fixedColor: Colors.white,
        items: [
          new BottomNavigationBarItem(
            activeIcon:  new Icon(Icons.home, color:_bottomNavigationActiveIconColor),
            backgroundColor: Colors.white,
            icon: new Icon(Icons.home, color:_bottomNavigationIconColor),
            title: new Text("首页",style: TextStyle(color: _bottomNavigationTextColor)),
          ),
          new BottomNavigationBarItem(
            activeIcon:  new Icon(Icons.category, color: _bottomNavigationActiveIconColor),
            icon: new Icon(
              Icons.category,
              color: _bottomNavigationIconColor,
            ),
            title: new Text("分类",style: TextStyle(color: _bottomNavigationTextColor)),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.add,
              color: Colors.black12,
            ),
            title: new Text("发布",style: TextStyle(color: _bottomNavigationTextColor)),
          ),
          new BottomNavigationBarItem(
            activeIcon:  new Icon(Icons.message, color: _bottomNavigationActiveIconColor),
            icon: new Icon(Icons.message, color: _bottomNavigationIconColor),
            title: new Text("消息",style: TextStyle(color: _bottomNavigationTextColor)),
          ),
          new BottomNavigationBarItem(
            activeIcon:  new Icon(Icons.category, color: _bottomNavigationActiveIconColor),
            icon: new Icon(Icons.person_add, color: _bottomNavigationIconColor),
            title: new Text("我的",style: TextStyle(color: _bottomNavigationTextColor)),
          ),
        ],
      ),
    );
  }
}
