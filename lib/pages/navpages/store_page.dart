// import 'package:matp/pages/navpages/products_page.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'dart:async';


// class StorePage extends StatelessWidget {
//   const StorePage({Key? key}) : super(key: key);
//   @override
//   _StorePageState createState() => _StorePageState();
  
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }

// class _StorePageState extends State<ProductsPage> {

// late String _mySelection;

//   final String url = "http://localhost:3000/api/stores/list";

//   List data = List(); //edited line

//   Future<String> getSWData() async {
//     var res = await http
//         .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
//     var resBody = json.decode(res.body);

//     setState(() {
//       data = resBody;
//     });

//     print(resBody);

//     return "Sucess";
//   }

//   @override
//   void initState() {
//     super.initState();
//     this.getSWData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(
//         title: Text("Hospital Management"),
//       ),
//       body: new Center(
//         child: new DropdownButton(
//           items: data.map((item) {
//             return new DropdownMenuItem(
//               child: new Text(item['item_name']),
//               value: item['id'].toString(),
//             );
//           }).toList(),
//           onChanged: (newVal) {
//             setState(() {
//               _mySelection = newVal;
//             });
//           },
//           value: _mySelection,
//         ),
//       ),
//     );
//   }
// }

