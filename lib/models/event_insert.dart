import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class EventInsert {
  String eventTitle;
  String eventContent;

  EventInsert({@required this.eventTitle, @required this.eventContent});

  Map<String,dynamic> toJson(){
    return{
      "eventID" : Uuid().v4().toString(),
      "eventTitle" : eventTitle,
      "eventContent" : eventContent,
      "createDateTime" : DateTime.now().toIso8601String()
    };
  }
}
