import 'package:cloud_firestore/cloud_firestore.dart';

class Project{
  final String title;
  final String imagePath;
  final String shortDescription;
  final String linkUrl;
  final String githubUrl;
  final String appType;


  Project({this.linkUrl, this.appType, this.githubUrl, this.title, this.imagePath, this.shortDescription});

    Project.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);

    Project.fromMap(Map<String, dynamic> map)
      : assert(map["title"] != null),
        assert(map["imagePath"] != null),
        assert(map["shortDescription"] != null),
        assert(map["githubUrl"] != null),
        assert(map["linkUrl"] != null),
        assert(map["appType"] != null),
        title = map["title"],
        imagePath = map["imagePath"], 
        githubUrl = map["githubUrl"],
        linkUrl = map["linkUrl"],
        appType = map["appType"], 
        shortDescription= map["shortDescription"];
}