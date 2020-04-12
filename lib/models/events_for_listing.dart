class EventsForListing{
  String eventID;
  String eventTitle;
  List<String> saleItemList;
  DateTime createDateTime;

  EventsForListing({this.eventID,
                     this.eventTitle,
                     this.saleItemList,
                     this.createDateTime});

  factory EventsForListing.fromJson(Map<String, dynamic> item){
    return EventsForListing(
        eventID: item['eventID'],
        eventTitle: item['eventTitle'],
        createDateTime: DateTime.parse(item['createDateTime'])
    );
  }

}