import 'package:flutter/material.dart';
import 'package:flutterdrawer/models/api_response.dart';
import 'package:flutterdrawer/models/events_for_listing.dart';
import 'package:flutterdrawer/screens/screens/event_delete_notify.dart';
import 'package:flutterdrawer/screens/screens/event_modify.dart';
import 'package:flutterdrawer/services/events_services.dart';
import 'package:get_it/get_it.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = '/details_screen';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  EventsServices get service => GetIt.I<EventsServices>();
  APIResponse<List<EventsForListing>> _apiResponse;
  List<EventsForListing> events = [];
  bool _isLoading = false;
  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }


  @override
  void initState() {
    _fetchEvents();
    super.initState();
  }

  _fetchEvents() async{
    setState(() {
      _isLoading = true;
    });
    print ("getting eventsList");
    _apiResponse = await service.getEventList();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List of events')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => EventModify()))
          // for refreshing the list with newly added event | refetches the whole event list
              .then((_){ _fetchEvents();
              });
        },
        child: Icon(Icons.add),
      ),
      body: Builder(
        builder: (_) {
          if (_isLoading){
            return CircularProgressIndicator();
          }
          if (_apiResponse?.error){
            return Center(child: Text(_apiResponse.errorMessage));
          }
          return ListView.separated(
            separatorBuilder: (_, __) => Divider(height: 1, color: Colors.amber),
            itemBuilder: (_, index) {
              return Dismissible(
                key: ValueKey(_apiResponse.data[index].eventID),
                onDismissed: (direction) {

                },
                confirmDismiss: (direction) async {
                  final result = await showDialog(
                      context: context, builder: (_) => EventDelete());

                  if(result){
                    final deleteResult = await service.deleteEvent(_apiResponse.data[index].eventID);

                    var message;
                    if(deleteResult != null && deleteResult.data == true){
                      message = 'Event successfully deleted';
                    }else{
                      message = deleteResult?.errorMessage ?? 'An error occured';
                    }
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Done'),
                          content: Text(message),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              })
                          ],
                        ));
                    return deleteResult?.data ?? false;
                  }

                  print(result);
                  return result;
                },
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                child: ListTile(
                  title: Text(
                    _apiResponse.data[index].eventTitle,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  subtitle: Text(
                      'Created at ${formatDateTime(_apiResponse.data[index].createDateTime)}'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            EventModify(eventID: _apiResponse.data[index].eventID)));
                  },
                ),
              );
            },
            itemCount: _apiResponse.data.length,
          );
        },
      )
    );
  }
}
