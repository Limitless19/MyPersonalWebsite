import 'dart:async';
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


//For the love of UI
class LinkButtonBloc {
  StreamController<bool> linkButtonController =
      StreamController<bool>.broadcast();

  Stream<bool> get linkButtonStream => linkButtonController.stream;

  Function(bool) get linkButtonSink => linkButtonController.sink.add;


  LinkButtonBloc() {
    linkButtonSink(false);
  }

  dispose() {
    linkButtonController.close();
  }
}

class AboutMeBloc {
  StreamController<bool> aboutMeController =
      StreamController<bool>.broadcast();

  Stream<bool> get aboutMeStream => aboutMeController.stream;

  Function(bool) get aboutMeSink => aboutMeController.sink.add;


  AboutMeBloc() {
    aboutMeSink(false);
  }

  dispose() {
    aboutMeController.close();
  }
}

class MyDescriptionBloc {
  StreamController<bool> myDescriptionController =
      StreamController<bool>.broadcast();

  Stream<bool> get  myDescriptionStream => myDescriptionController.stream;

  Function(bool) get myDescriptionSink => myDescriptionController.sink.add;


  MyDescriptionBloc() {
     myDescriptionSink(false);
  }

  dispose() {
    myDescriptionController.close();
  }
}

class OpenSourceProjectsBloc {
  StreamController<bool> openSourceProjectsController =
      StreamController<bool>.broadcast();

  Stream<bool> get openSourceProjectsStream => openSourceProjectsController.stream;

  Function(bool) get openSourceProjectsSink => openSourceProjectsController.sink.add;


  OpenSourceProjectsBloc() {
    openSourceProjectsSink(false);
  }

  dispose() {
    openSourceProjectsController.close();
  }
}

class DefaultBloc {
  StreamController<bool> defaultController =
      StreamController<bool>.broadcast();

  Stream<bool> get defaultStream => defaultController.stream;

  Function(bool) get defaultSink => defaultController.sink.add;


  DefaultBloc() {
    defaultSink(false);
  }

  dispose() {
    defaultController.close();
  }
}



final linkButtonBloc = LinkButtonBloc();
final aboutMeBloc = AboutMeBloc();
final myDescriptionBloc = MyDescriptionBloc();
final openSourceProjectsBloc = OpenSourceProjectsBloc();
final defaultBloc = DefaultBloc();