import 'package:cloud_firestore/cloud_firestore.dart';

class PostInfoModel {
  String? name;
  String? title;
  String? description;
  String? url;
  String? createdAt;
  String? profileUrl;

  PostInfoModel({
    this.title,
    this.description,
    this.url,
    this.createdAt,
    this.name,
    this.profileUrl,
  });

//receving data from server

  factory PostInfoModel.fromMap(map) {
    return PostInfoModel(
        title: map['title'],
        description: map['description'],
        url: map['url'],
        createdAt: map['createdAt'],
        name: map['name'],
        profileUrl : map['profileUrl']);
  }
// sending data to our server

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'createdAt': createdAt,
      'name': name,
      'profileUrl':profileUrl,
    };
  }

  toJson() {}

  static fromJson(i) {}

  PostInfoModel.fromSnapshot(DocumentSnapshot snap)
      : title = snap['title'],
        description = snap['description'],
        url = snap['url'],
        createdAt = snap['createdAt'],
        name = snap['name'],
        profileUrl = snap['profileUrl']
        ;
}
