import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    // TODO: Add Logic
  }
}


// class FirebaseBloc {
//   StreamController<QuerySnapshot> listController =
//       StreamController<QuerySnapshot>.broadcast();

//     StreamController<QuerySnapshot> writingsController =
//       StreamController<QuerySnapshot>.broadcast();    

//   Stream<QuerySnapshot> get projectsListStream => listController.stream;
//     Stream<QuerySnapshot> get writingsListStream => writingsController.stream;


//   StreamSink<QuerySnapshot> get projectsListSink => listController.sink;
//     StreamSink<QuerySnapshot> get writingsListSink => writingsController.sink;

//   Stream<QuerySnapshot> getProjectsList() {
//     return Firestore.instance.collection("Projects").snapshots();
//   }

//  Stream<QuerySnapshot> getWritingsList() {
//     return Firestore.instance.collection("Writings").snapshots();
//   }

//   FirebaseBloc() {
//     getProjectsList().listen((value) {
//       projectsListSink.add(value);
//     });
//     getWritingsList().listen((event) {
//       writingsListSink.add(event);
//     });
//   }
//   dispose() {
//     listController.close();
//     writingsController.close();
//   }
// }
// final firebaseBloc = FirebaseBloc();
