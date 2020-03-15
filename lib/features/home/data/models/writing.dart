import 'package:cloud_firestore/cloud_firestore.dart';

class Writing {
  final String title;
  final String imagePath;
  final String shortDescription;
  final String linkUrl;

  Writing({this.title, this.imagePath, this.shortDescription, this.linkUrl});

  Writing.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);

  Writing.fromMap(Map<String, dynamic> map)
      : assert(map["title"] != null),
        assert(map["imagePath"] != null),
        assert(map["shortDescription"] != null),
        assert(map["linkUrl"] != null),
        title = map["title"],
        imagePath = map["imagePath"],
        shortDescription = map["shortDescription"],
        linkUrl = map["linkUrl"];
}
