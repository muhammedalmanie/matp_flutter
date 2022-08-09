import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matp/models/store_model.dart';
import 'package:matp/pages/navpages/home_page.dart';
import 'package:matp/pages/navpages/product_data.dart';
import 'package:matp/pages/navpages/products_page.dart';
import 'package:matp/pages/navpages/store_page.dart';
import 'package:matp/pages/util.dart';
import 'package:matp/models/store_model.dart';
import 'package:gestures/gestures.dart';
import 'package:auto_reload/auto_reload.dart';

//const String BASE_API = "http://docker101.tk/api/products/add";

showMessage(BuildContext context, String contentMessage) {
  Widget yesButton = FlatButton(
    child: Text("OK", style: TextStyle(color: Colors.blue)),
    onPressed: () {
      Navigator.pop(context);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ProductsPage()),
          (Route<dynamic> route) => false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Message"),
    content: Text(contentMessage),
    actions: [
      yesButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _controllerName = new TextEditingController();
  final TextEditingController _controllerDescription =
      new TextEditingController();
  final TextEditingController _controllerBarcode = new TextEditingController();
  final TextEditingController _controllerStoreID = new TextEditingController();
  final TextEditingController _controllerPrice = new TextEditingController();

  late List<StoreModel> stores = [
    // StoreModel ({id: "123", Name: "A"}),
    // StoreModel({id: "123", Name: "A", Location: "B"})
  ];

  // final stores = List<String>.generate(10000, (i) => "Item $i");

// final stores = List<StoreModel>.generate(
//   1000,
//   (i) => i % 6 == 0
//       ? HeadingItem('Heading $i')
//       : MessageItem('Sender $i', 'Message body $i'),
// );

  Future<http.Response> fetchAlbum() {
    return http.get(Uri.parse('http://localhost:3000/api/stores/list'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 239, 123, 87),
        title: Text("Product Creation"),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return ListView(
      padding: EdgeInsets.all(30),
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _controllerName,
          cursorColor: Colors.blue,
          decoration: InputDecoration(
            hintText: "Name",
          ),
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _controllerDescription,
          cursorColor: Colors.blue,
          decoration: InputDecoration(
            hintText: "Description",
          ),
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _controllerBarcode,
          cursorColor: Colors.blue,
          decoration: InputDecoration(
            hintText: "Barcode",
          ),
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _controllerStoreID,
          cursorColor: Colors.blue,
          decoration: InputDecoration(
            hintText: "Store ID",
          ),
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _controllerPrice,
          cursorColor: Colors.blue,
          decoration: InputDecoration(
            hintText: "Price",
          ),
        ),

        SizedBox(
          height: 30,
        ),
        // DropdownButton(items: [], onChanged:),
        DropdownButton<String>(
          items: stores.map((StoreModel store) {
            return DropdownMenuItem<String>(
              value: store.id,
              child: Text(store.Name ?? ""),
            );
          }).toList(),
          onChanged: (_) {},
        ),

        // Container(
        //   padding: EdgeInsets.only(left: 15, right: 15, top: 5),
        //   color: Colors.white,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: <Widget>[
        //       Expanded(
        //         child: DropdownButtonHideUnderline(
        //           child: ButtonTheme(
        //             alignedDropdown: true,
        //             child: DropdownButton<String>(
        //               value: _myState,
        //               iconSize: 30,
        //               icon: (null),
        //               style: TextStyle(
        //                 color: Colors.black54,
        //                 fontSize: 16,
        //               ),
        //               hint: Text('Select State'),
        //               onChanged: (String newValue) {
        //                 setState(() {
        //                   _myState = newValue;
        //                   _getCitiesList();
        //                   print(_myState);
        //                 });
        //               },
        //               items: statesList?.map((item) {
        //                     return new DropdownMenuItem(
        //                       child: new Text(item['name']),
        //                       value: item['id'].toString(),
        //                     );
        //                   })?.toList() ??
        //                   [],
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        SizedBox(
          height: 30,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'Did not find a store?',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StorePage(),
                        ));
                  }),
          ]),
        ),

        // SizedBox(
        //   height: 30,
        // ),
        // FlatButton(
        //     color: Colors.grey,
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => StorePage(),
        //           ));
        //     },
        //     child: Text(
        //       "Did not find a store?",
        //       style: TextStyle(color: Colors.white),
        //     )),

        SizedBox(
          height: 40,
        ),
        FlatButton(
            color: Colors.blue,
            onPressed: () {
              createNewProduct();
            },
            child: Text(
              "Done",
              style: TextStyle(color: Colors.white),
            ))
      ],
    );

    /*
    Widget buildTextfield(String hint, TextEditingController controller ){
      return Container(
        margin: EdgeInsets.all(4),
        child: TextField(
          decoration: InputDecoration(
            labelText: hint,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black38,
              ),
            ),
          ),
          controller: controller,
        ),
      );
    }

    var nameController = TextEditingController();
    var barcodeController = TextEditingController();
    var aboutController = TextEditingController();
    var storeController = TextEditingController();
    var dateController = TextEditingController();


    return Container(
      padding: EdgeInsets.all(8),
      height: 400,
      width: 350,
      child: Column(
        children: [
          Text(
            'Add a Product',
            style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Colors.blueGrey,

          ),),
          buildTextfield('Product Name', nameController),
          buildTextfield('Barcode', barcodeController),
          buildTextfield('About', aboutController),
          buildTextfield('Store Name', storeController),
          buildTextfield('Date Updated', dateController),
          ElevatedButton(
            onPressed: () {createNewProduct();},
            child: Text('Add Product'),
          ),

        ],

      ),

    );
*/
  }

  ///////////////////////////////////////////

  //int _countOfReload = 0;

  createNewProduct() async {
    Future.delayed(Duration.zero, () => showAlert(context));
    //startAutoReload();

    var name = _controllerName.text;
    var description = _controllerDescription.text;
    var barcode = _controllerBarcode.text;
    var storeID = _controllerStoreID.text;
    var price = _controllerPrice.text;

    // && barcode.isNotEmpty && storeID.isNotEmpty && price.isNotEmpty

    if (name.isNotEmpty && description.isNotEmpty) {
      var url = Uri.parse("http://localhost:3000/api/products/add");
      var bodyData = json.encode({
        "name": name,
        "description": description,
        "barcode": barcode,
        "storeID": storeID,
        "price": price,
      });
      var response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: bodyData);
      if (response.statusCode == 200 && !json.decode(response.body)['error']) {
        setState(() {
          _controllerName.text = "";
          _controllerDescription.text = "";
        });
      } else if (json.decode(response.body)['error']) {
        var message = json.decode(response.body)['message'];
        showMessage(context, message);
      } else {
        var messageError = "Couldn't connect!!";
        showMessage(context, messageError);
      }
    }
  }
  /////////////////////////////

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("You Have Added a Product Successfully"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    //Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductsPage()),
                    );
                  },
                  child: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(14),
                    child:
                        const Text("OK", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ));
  }
}
