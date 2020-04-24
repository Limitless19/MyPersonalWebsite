import 'package:cloud_firestore/cloud_firestore.dart';

class GeneralContent {
  final String about_me;
  final String profile_pic;
  final String welcome_string;
 

  GeneralContent({this.about_me, this.profile_pic,this.welcome_string});

  GeneralContent.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);

  GeneralContent.fromMap(Map<String, dynamic> map)
      : assert(map["welcome_string"] != null),
        assert(map["profile_pic"] != null),
        assert(map["about_me"] != null),
        about_me = map["about_me"],
        profile_pic = map["profile_pic"],
        welcome_string =map["welcome_string"];
}
