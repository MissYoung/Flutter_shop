import 'dart:convert';

class GoodModel {
  final String name; // 用户名
  final String avatar; // 用户头像
  final String title;
  final String cover; // 封面
  final String coverType; // 封面类型
  final String descriptor; // 说明描述
  final String city; //市
  final String district; //区

  GoodModel(
      {this.name,
      this.avatar,
      this.title,
      this.cover,
      this.coverType,
      this.descriptor,
      this.city,
      this.district});

  static List<GoodModel> fromJson(String json) {
    return jsonDecode(json)['list']
        .map((obj) => GoodModel.fromMap(obj))
        .toList();
  }

  static GoodModel fromMap(Map map) {
    return new GoodModel(
      name: map['name'],
      avatar: map['avatar'],
      title: map['title'],
      cover: map['cover'],
      coverType: map['coverType'],
      descriptor: map['descriptor'],
      city: map['city'],
      district: map['district'],
    );
  }
}
