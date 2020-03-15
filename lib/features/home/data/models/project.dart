import 'package:cloud_firestore/cloud_firestore.dart';

class Project{
  final String title;
  final String imagePath;
  final String shortDescription;
  final String linkUrl;


  Project(this.linkUrl, {this.title, this.imagePath, this.shortDescription});

    Project.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);

    Project.fromMap(Map<String, dynamic> map)
      : assert(map["title"] != null),
        assert(map["imagePath"] != null),
        assert(map["shortDescription"] != null),
        assert(map["linkUrl"] != null),
        title = map["title"],
        imagePath = map["imagePath"], 
        linkUrl = map["linkUrl"],
        shortDescription= map["shortDescription"];
}