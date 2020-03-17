import 'package:cloud_firestore/cloud_firestore.dart';

class Writing {
  final String title;
  final String imagePath;
  final String shortDescription;
  final String linkUrl;
  final String monthYear;
  final String minutesRead;

  Writing(this.monthYear, this.minutesRead,
      {this.title, this.imagePath, this.shortDescription, this.linkUrl});

  Writing.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);

  Writing.fromMap(Map<String, dynamic> map)
      : assert(map["title"] != null),
        assert(map["imagePath"] != null),
        assert(map["shortDescription"] != null),
        assert(map["monthYear"] != null),
        assert(map["linkUrl"] != null),
        assert(map["minutesRead"] != null),
        title = map["title"],
        imagePath = map["imagePath"],
        monthYear = map["monthYear"],
        shortDescription = map["shortDescription"],
        minutesRead = map["minutesRead"],
        linkUrl = map["linkUrl"];
}
