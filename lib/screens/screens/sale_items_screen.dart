//import 'package:flutter/material.dart';
//import 'package:flutterdrawer/models/sale_item.dart';
//
//class ProductScreen extends StatelessWidget {
//  final ValueSetter<SaleItem> _valueSetter;
//
//  ProductScreen(this._valueSetter);
//
//  List<SaleItem> products = [
//    SaleItem("Mic", 50),
//    SaleItem("LED Monitor", 100),
//    SaleItem("Mouse", 5),
//    SaleItem("Keyboard", 10),
//    SaleItem("Speaker", 50),
//    SaleItem("CD", 3),
//  ];
//
//  @override
//  Widget build(BuildContext context) {
//    return ListView.separated(
//        itemBuilder: (context, index){
//          return ListTile(
//            title: Text(products[index].name),
//            trailing: Text("\$${products[index].price}", style: TextStyle(color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.w500),),
//            onTap: (){
//              _valueSetter(products[index]);
//            },
//          );
//        },
//        separatorBuilder: (context, index){
//          return Divider();
//        },
//        itemCount: products.length
//    );
//  }
//}