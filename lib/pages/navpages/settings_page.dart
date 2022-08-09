// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:http/http.dart' as http;
// import 'package:matp/pages/navpages/add_product.dart';
// import 'package:matp/pages/navpages/edit_product.dart';
// import 'package:flutter/cupertino.dart';

// /*
// class SettingsPage extends StatefulWidget {
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   List products = [];
//   bool isLoading = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     this.fetchProduct();
//   }
//   fetchProduct() async {
//     setState(() {
//       isLoading = true;
//     });
//     var url = Uri.parse("http://localhost:3000/api/products");
//     var response = await http.get(url);
//     if(response.statusCode == 200){
//       var items = json.decode(response.body)['data'];
//       setState(() {
//         products = items;
//         isLoading = false;
//       });
//     }else{
//       setState(() {
//         products = [];
//         isLoading = false;
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Peoducts"),
//         actions: <Widget>[
//           FlatButton(onPressed: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
//           }, child: Icon(Icons.add,color: Colors.white,))
//         ],
//       ),
//       body: getBody(),
//     );
//   }
//   Widget getBody(){
//     if(isLoading || products.length == 0){
//       return Center(child: CircularProgressIndicator(
//           valueColor: new AlwaysStoppedAnimation<Color>(Colors.pink)
//       ));
//     }
//     return ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (context,index){
//           return cardItem(products[index]);
//         });
//   }
//   Widget cardItem(item){
//     var name = item['name'];
//     var description = item['description'];

//     return Card(

//     child: Slidable(
//         actionPane: SlidableDrawerActionPane(),
//         actionExtentRatio: 0.25,
//         child: Container(
//           color: Colors.white,
//           child: ListTile(
//             title: Text(name),
//             subtitle: Text(description),
//           ),
//         ),
//         secondaryActions: <Widget>[
//           IconSlideAction(
//             caption: 'Edit',
//             color: Colors.blueAccent,
//             icon: Icons.edit,
//             onTap: () => editProduct(item),
//           ),
//           IconSlideAction(
//             caption: 'Delete',
//             color: Colors.red,
//             icon: Icons.delete,
//             onTap: () => showDeleteAlert(context,item),


//           ),
//         ],
//       ),
//     );


//   }

//   editProduct(item){
//     var id = item['_id'].toString();
//     var name = item['name'].toString();
//     var description = item['description'].toString();
//     Navigator.push(context, MaterialPageRoute(builder: (context) => EditProduct(id: id,name: name,description: description,)));
//   }
//   deleteProduct(id) async {
//     var url = Uri.parse("http://localhost:3000/api/products/delete/:$id");
//     var response = await http.post(url,headers: {
//       "Content-Type" : "application/json",
//       "Accept" : "application/json"
//     });
//     if(response.statusCode == 200){
//       this.fetchProduct();
//     }
//   }
//   showDeleteAlert(BuildContext context,item) {

//     // set up the buttons
//     Widget noButton = FlatButton(
//       child: Text("No",style: TextStyle(color: Colors.pink),),
//       onPressed:  () {
//         Navigator.pop(context);
//       },
//     );

//     Widget yesButton = FlatButton(
//       child: Text("Yes",style: TextStyle(color: Colors.pink)),
//       onPressed:  () {
//         Navigator.pop(context);

//         deleteProduct(item['_id']);
//       },
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text("Message"),
//       content: Text("Would you like to delete this user?"),
//       actions: [
//         noButton,
//         yesButton,
//       ],
//     );
//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }


// */







// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   void initState() {
//     _getStateList();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dynamic DropDownList REST API'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             alignment: Alignment.topCenter,
//             margin: EdgeInsets.only(bottom: 100, top: 100),
//             child: Text(
//               'KDTechs',
//               style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
//             ),
//           ),
//           //======================================================== State

//           Container(
//             padding: EdgeInsets.only(left: 15, right: 15, top: 5),
//             color: Colors.white,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Expanded(
//                   child: DropdownButtonHideUnderline(
//                     child: ButtonTheme(
//                       alignedDropdown: true,
//                       child: DropdownButton<String>(
//                         value: _myState,
//                         iconSize: 30,
//                         icon: (null),
//                         style: TextStyle(
//                           color: Colors.black54,
//                           fontSize: 16,
//                         ),
//                         hint: Text('Select State'),
//                         onChanged: (String newValue) {
//                           setState(() {
//                             _myState = newValue;
//                             _getCitiesList();
//                             print(_myState);
//                           });
//                         },
//                         items: statesList?.map((item) {
//                               return new DropdownMenuItem(
//                                 child: new Text(item['name']),
//                                 value: item['id'].toString(),
//                               );
//                             })?.toList() ??
//                             [],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 30,
//           ),



//   //=============================================================================== Api Calling here

// //CALLING STATE API HERE
// // Get State information by API
//   List statesList;
//   String _myState;

//   String stateInfoUrl = 'http://cleanions.bestweb.my/api/location/get_state';
//   Future<String> _getStateList() async {
//     await http.post(stateInfoUrl, headers: {
//       'Content-Type': 'application/x-www-form-urlencoded'
//     }, body: {
//       "api_key": '25d55ad283aa400af464c76d713c07ad',
//     }).then((response) {
//       var data = json.decode(response.body);

// //      print(data);
//       setState(() {
//         statesList = data['state'];
//       });
//     });
//   }

//   // Get State information by API
//   List citiesList;
//   String _myCity;

//   String cityInfoUrl =
//       'http://cleanions.bestweb.my/api/location/get_city_by_state_id';
//   Future<String> _getCitiesList() async {
//     await http.post(cityInfoUrl, headers: {
//       'Content-Type': 'application/x-www-form-urlencoded'
//     }, body: {
//       "api_key": '25d55ad283aa400af464c76d713c07ad',
//       "state_id": _myState,
//     }).then((response) {
//       var data = json.decode(response.body);

//       setState(() {
//         citiesList = data['cities'];
//       });
//     });
//   }
// }


