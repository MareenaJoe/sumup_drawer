import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdrawer/models/event.dart';
import 'package:flutterdrawer/models/event_insert.dart';
import 'package:flutterdrawer/services/events_services.dart';
import 'package:get_it/get_it.dart';

class EventModify extends StatefulWidget {
  final String eventID;
  EventModify({this.eventID});

  @override
  _EventModifyState createState() => _EventModifyState();
}

class _EventModifyState extends State<EventModify> {
  bool get isEditing => widget.eventID != null;

  EventsServices get eventsService => GetIt.I<EventsServices>();

  String errorMessage;
  Event event;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  void initState() {
    super.initState();
    if (isEditing) {
      setState(() {
        _isLoading = true;
      });

      eventsService.getEvent(widget.eventID).then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occured';
        }
        event = response.data;
        _titleController.text = event.eventTitle;
        _contentController.text = event.eventContent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Event' : 'Create Event')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(hintText: 'Event Title'),
                  ),
                  Container(height: 8),
                  TextField(
                    controller: _contentController,
                    decoration: InputDecoration(hintText: 'Event Description'),
                  ),
                  Container(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: RaisedButton(
                      child:
                          Text('Submit', style: TextStyle(color: Colors.white)),
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        if (isEditing) {
                          // update event in api
                        } else {
                          // create event in api
                          setState(() {
                            _isLoading = true;
                          });

                          final event = EventInsert(
                              eventTitle: _titleController.text,
                              eventContent: _contentController.text);
                          final result = await eventsService.createEvent(event);

                          setState(() {
                            _isLoading = false;
                          });

                          final title = 'Done';
                          final text = result.error
                              ? (result.errorMessage ?? 'An error occured')
                              : 'Event created';

                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text(title),
                                    content: Text(text),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  )).then((data) {
                                    //navigating back to event list
                            if (result.data) {
                              Navigator.of(context).pop();
                            }
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
