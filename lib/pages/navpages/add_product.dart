import 'dart:developer';
import 'dart:html';

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

  late Future<List<StoreModel>> _future;
  // late List<StoreModel> stores = [
  //   StoreModel.fromJson(json.decode('{"_id": "2", "name": "A"}')),
  //   StoreModel.fromJson(
  //       json.decode('{"_id": "1", "name": "B", "location": "B"}'))
  // ];
  late String _selectedStore;
  // final stores = List<String>.generate(10000, (i) => "Item $i");

// final stores = List<StoreModel>.generate(
//   1000,
//   (i) => i % 6 == 0
//       ? HeadingItem('Heading $i')
//       : MessageItem('Sender $i', 'Message body $i'),
// );
  @override
  void initState() {
    super.initState();
    _future = _getStores();
  }

  Future<List<StoreModel>> _getStores() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/api/stores/list'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization":
            "Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJnXy14azJucGJfM1lwQWo1VzFDVE1wU1ZJbUlzZkgxSFVWVUZ2VnBUSjFNIn0.eyJleHAiOjE2NjAxMTk1ODIsImlhdCI6MTY2MDExOTI4MiwianRpIjoiYmZjNGMyZjUtZDEwOC00MGUxLWI4ODMtMzk0NGE1YWU2OTYyIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgwL2F1dGgvcmVhbG1zL21hdHAiLCJhdWQiOlsiTUFUUCIsImFjY291bnQiXSwic3ViIjoiNmU4OGZmZTAtZjcyYS00ZDhiLThlZjYtNWM1N2VmMDlkNzE3IiwidHlwIjoiQmVhcmVyIiwiYXpwIjoiTUFUUCIsInNlc3Npb25fc3RhdGUiOiI0YjQ2YjkxNC1hNmY2LTQ2ODktOGUxOS1lMGQ5NTA4MDYzMzIiLCJhY3IiOiIxIiwiYWxsb3dlZC1vcmlnaW5zIjpbImh0dHA6Ly9sb2NhbGhvc3Q6MzAwMCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy1tYXRwIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiIsImFwcC11c2VyIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiTUFUUCI6eyJyb2xlcyI6WyJ1c2VyIl19LCJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6InByb2ZpbGUgbXktYXBwbGljYXRpb24tc2NvcGUgZW1haWwiLCJzaWQiOiI0YjQ2YjkxNC1hNmY2LTQ2ODktOGUxOS1lMGQ5NTA4MDYzMzIiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwicHJlZmVycmVkX3VzZXJuYW1lIjoidXNlcjEifQ.IxBFAiTHCG-UVtitzPwJfgLhueAYy1_pkbVBoX4feLPK_l_Ve-AOBtR2i0zUCPDm_5ZQYwFpDUMpkRYUolREnAPbHoN7aucridcFklTJdcWNv_QMbloN5x7zv9k4fvQD9uBjH632dFnvG00N0X0CNmdhjM56o1rF7splctypbh80VqQwUhWBjTi6UrHKDCRKNByFQIUZaEQdGBCv4tYY-Z4io1VreHrMDrQ61875QdP1pucg6dVLQc12kv3awpYfCbvkrXwtKL9PqxpY9Kcl62CBjD-VnxS-StihUq_HnLnbheqabc7brqsIqZteSVa78W5bKpoyRNNegBkxY0fs3A"
      },
    );

    List<dynamic> jsonResponse = jsonDecode(response.body);

    final Iterable<StoreModel> storesList =
        jsonResponse.map((item) => StoreModel.fromJson(item));

    // final storesResponse = json.map(( value) {
    //   return StoreModel.fromJson(value);
    // });
    return storesList.toList();
  }

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
        FutureBuilder<List<StoreModel>>(
            future: _future,
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.data == null) {
                return const CircularProgressIndicator();
              }
              _selectedStore = "";
              return DropdownButton<String>(
                  // style: new TextStyle(
                  //   color: Colors.white,
                  // ),
                  value: _selectedStore,
                  items: [
                    DropdownMenuItem<String>(
                      value: "",
                      enabled: false,
                      child: Text("Select a store..."),
                    ),
                    ...snapshot.data!.map((StoreModel store) {
                      return DropdownMenuItem<String>(
                        value: store.id,
                        // key: Key(store.id ?? ""),
                        child: Text(
                          store.Name ?? "",
                          // style: TextStyle(color: Colors.red),
                        ),
                      );
                    })
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedStore = value!;
                    });
                    print(_selectedStore);
                  });
            })),
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
                  color: Color.fromARGB(255, 239, 123, 87),
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
            color: Color.fromARGB(255, 239, 123, 87),
            onPressed: () {
              createNewProduct();
            },
            child: Text(
              "Done",
              style: TextStyle(color: Colors.black),
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
    //var storeID = _selectedStore;
    var price = _controllerPrice.text;

    // && barcode.isNotEmpty && storeID.isNotEmpty && price.isNotEmpty

    if (name.isNotEmpty && description.isNotEmpty) {
      var url = Uri.parse("http://localhost:3000/api/products/add");
      var bodyData = json.encode({
        "name": name,
        "description": description,
        "barcode": barcode,
        "storeID": _selectedStore,
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
                    color: Color.fromARGB(255, 239, 123, 87),
                    padding: const EdgeInsets.all(14),
                    child:
                        const Text("OK", style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ));
  }
}
