
class SaleItem{
  String itemID;
  String itemName;
  double itemPrice;

  SaleItem({this.itemID, this.itemName, this.itemPrice});

  factory SaleItem.fromJson(Map<String, dynamic> item){
    return SaleItem(
        itemID: item['itemID'],
        itemName: item['itemName'],
        itemPrice: item['itemPrice'],
    );
  }

}


