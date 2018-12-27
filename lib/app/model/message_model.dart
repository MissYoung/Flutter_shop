import 'dart:convert';

class MessageModel {
  final String name; // 用户名
  final String avatar; // 用户头像
  final String msg;
  final int type;// 2系统



  MessageModel(
      {
        this.name,
        this.avatar,
        this.msg,
        this.type
      });

  static List<MessageModel> fromJson(String json) {
    return jsonDecode(json)['list']
        .map((obj) => MessageModel.fromMap(obj))
        .toList();
  }

  static MessageModel fromMap(Map map) {
    return new MessageModel(
      name: map['name'],
      avatar: map['avatar'],
      msg: map['msg'],
      type: 1
    );
  }
}
