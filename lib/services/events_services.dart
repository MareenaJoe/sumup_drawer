import 'dart:convert';
import 'dart:developer';
import 'package:flutterdrawer/models/api_response.dart';
import 'package:flutterdrawer/models/event.dart';
import 'package:flutterdrawer/models/event_insert.dart';
import 'package:flutterdrawer/models/events_for_listing.dart';
import 'package:http/http.dart' as http;

class EventsServices {
  static const API = 'http://192.168.0.178:8080';
  static const headers = {'apiKey': 'someKey', 'Content-Type': 'application/json', 'Accept': 'application/json'};

  Future<APIResponse<List<EventsForListing>>> getEventList() {
    print("About to get events");
    return http.get(API + '/events', headers: headers).then((data) {
      print("Data returned");
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <EventsForListing>[];
        for (var item in jsonData) {
          events.add(EventsForListing.fromJson(item));
        }
        return APIResponse<List<EventsForListing>>(data: events);
      }
      print("Data error");
      return APIResponse<List<EventsForListing>>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) => APIResponse<List<EventsForListing>>(
        error: true, errorMessage: "An error occured during http get"));
  }

  Future<APIResponse<Event>> getEvent(String eventID) {
    return http.get(API + '/events/' + eventID, headers: headers).then((data) {
      print("Data returned");
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Event>(data: Event.fromJson(jsonData));
      }
      return APIResponse<Event>(error: true, errorMessage: "An error occured");
    }).catchError((_) => APIResponse<Event>(
        error: true, errorMessage: "An error occured during http GET"));
  }


  Future<APIResponse<bool>> createEvent(EventInsert item) {
    var itemJson = json.encode(item.toJson());
    print("About to add new event" + itemJson.toString());
    return http.post(API + '/events', headers: headers, body: itemJson).then((data) {
      print("Data returned");
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    }).catchError((_) => APIResponse<bool>(
        error: true, errorMessage: "An error occured during http POST"));
  }


  Future<APIResponse<bool>> deleteEvent(String eventID) {
    return http.delete(API + '/events/'+eventID, headers: headers).then((data) {
      print("Data returned");
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    }).catchError((_) => APIResponse<bool>(
        error: true, errorMessage: "An error occured during http POST"));
  }


}
