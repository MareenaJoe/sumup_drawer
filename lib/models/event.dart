class Event{
  String eventID;
  String eventTitle;
  String eventContent;
  List<String> saleItemList;
  DateTime createDateTime;

  Event({this.eventID, this.eventTitle, this.saleItemList, this.eventContent,this.createDateTime });

  factory Event.fromJson(Map<String, dynamic> item){
    return Event(
        eventID: item['eventID'],
        eventTitle: item['eventTitle'],
        saleItemList: item['saleItemList'],
        eventContent: item['eventContent'],
        createDateTime: DateTime.parse(item['createDateTime'])
    );
  }
}