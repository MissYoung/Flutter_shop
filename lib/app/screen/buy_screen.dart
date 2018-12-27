import 'package:flutter/material.dart';
import 'package:zdk_app/app/model/good_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

/**
 * 购买页面
 * */
class BuyScreen extends StatefulWidget {
  final GoodModel goodModel;
  @override
  BuyScreen({Key key, this.goodModel}) : super(key: key);

  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen>{

  // 价格样式
  TextStyle _style_price= TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18);

  @override
  initState(){
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  Widget _widget_good_info(){ // 商品信息 Widget
    List<Widget>  _rows = [];
    _rows.add(
        CachedNetworkImage(
          width: 120,
          height: 120,
          placeholder:  CircularProgressIndicator(),
          imageUrl: 'https://picsum.photos/120/120?image=1',
          errorWidget:  Icon(Icons.error),
          fit: BoxFit.cover,
        )
    );

    List<Widget> _rows_price=[];

    _rows_price.add(Text("￥35.00",style: _style_price));

    if(true){ //是否显示 原价
      _rows_price.add(
        Padding(
            padding: EdgeInsets.only(left: 16),
            child:  Text("￥75.00",style: TextStyle(fontSize: 12,color: Colors.grey[600],decoration: TextDecoration.lineThrough,)
        )
        )
      );
    }


    _rows.add(
        Expanded(child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget>[
              Text("我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题我是标题",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),maxLines: 2,overflow: TextOverflow.ellipsis),
              Row(children: _rows_price)
              ],
            )
        )
        )
    );


    return Container(
      color: Colors.white,
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Row(children: _rows),
    );
  }

  Widget _widget_addres(){ // 收货地址 Widget

    return GestureDetector(
    child: Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 16),
      child: Row(
          children: <Widget>[
            Expanded(child: Text("收货地址"),flex: 2,),
            Expanded(child: Text("杨勇 18899999999\n北京市朝阳区建国路清华园16栋3单元1808室",textAlign: TextAlign.right,style: TextStyle(color: Colors.grey[600]),),flex: 5,),
            Expanded(child: Icon(Icons.chevron_right,size: 40,color: Colors.grey,),),
          ],
        ),
      ),
      onTap: (){

        showDialog(context: context,builder: (_){
          return AlertDialog(
              title: new Text("我是标题"),
              content: new Text("我将要跳转addrs 并带回数据"),
              actions:<Widget>[
                new FlatButton(child:new Text("我是按钮1"), onPressed: (){
                  Navigator.of(context).pop();

                },),
                new FlatButton(child:new Text("我是按钮2"), onPressed: (){
                  Navigator.of(context).pop();

                },)
              ]
          );

        });

      },
    );
  }

  Widget _widget_yunfei(){ // 运费Widget
    return Container(
      decoration: BoxDecoration(  color: Colors.white,border: Border(top: BorderSide(color: Colors.grey[300]))),
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 16),
      child: Row(
        children: <Widget>[
          Text("运费"),
          Expanded(child: Text("￥0.00",textAlign: TextAlign.right,style:_style_price,)),
        ],
      ),
    );

}
 Widget _widget_body(){ // 整体内容 cloumn 用于控制 生成 Widget 子组件
    List<Widget> cols=[];
    cols.add(_widget_good_info());// 商品信息 Widget

    cols.add(_widget_addres()); // 收货地址 Widget

    if(true){ // 是否创建运费 Widget
      cols.add(_widget_yunfei());
    }

    return Column(children: cols);

  }

  Widget _widget_bottomAppBar(){

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
       Expanded(
         child: Container(
           color: Colors.white,
           padding: EdgeInsets.symmetric(horizontal: 8),
           height: 50,
           child: Row(
           children: <Widget>[
             Text("实付款："),
             Text("￥35.00",style: _style_price,)
           ],
         ) ,
       )
       ),
         GestureDetector(
           child:  Container(
             color: Colors.red,
             alignment: Alignment.center,
             height: 50,
             width: 120,
             child:Text("确定",style: TextStyle(color: Colors.white))
         ),
          onTap: (){
           showDialog(context: context,builder: (_){
             return AlertDialog(
                 title: new Text("我是标题"),
                 content: new Text("我是内容"),
                 actions:<Widget>[
                   new FlatButton(child:new Text("我是按钮1"), onPressed: (){
                     Navigator.of(context).pop();

                   },),
                   new FlatButton(child:new Text("我是按钮2"), onPressed: (){
                     Navigator.of(context).pop();

                   },)
                 ]
             );

           });

          },
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('购买宝贝',)
        ),
        body: Container(
          child: _widget_body(),
        ),
        bottomNavigationBar:_widget_bottomAppBar()
    );
  }
}