import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matp/pages/util.dart';
import 'package:matp/pages/navpages/products_page.dart';

class EditProduct extends StatefulWidget {
  String id;
  String name;
  String description;
  String barcode;
  //String storeID;
  String price;

  EditProduct(
      {required this.id,
      required this.name,
      required this.description,
      required this.barcode,
      //required this.storeID,
      required this.price});
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final TextEditingController _controllerName = new TextEditingController();
  final TextEditingController _controllerDescription =
      new TextEditingController();
  final TextEditingController _controllerBarcode = new TextEditingController();
  //final TextEditingController _controllerStoreID = new TextEditingController();
  final TextEditingController _controllerPrice = new TextEditingController();

  String id = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      id = widget.id;
      _controllerName.text = widget.name;
      _controllerDescription.text = widget.description;
      _controllerBarcode.text = widget.barcode;
      //_controllerStoreID.text = widget.storeID;
      _controllerPrice.text = widget.price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editing Product"),
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
          cursorColor: Colors.black38,
          decoration: InputDecoration(
            hintText: "name",
          ),
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _controllerDescription,
          cursorColor: Colors.black38,
          decoration: InputDecoration(
            hintText: "description",
          ),
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _controllerBarcode,
          cursorColor: Colors.black38,
          decoration: InputDecoration(
            hintText: "barcode",
          ),
        ),
        SizedBox(
          height: 30,
        ),
        // TextField(
        //   controller: _controllerStoreID,
        //   cursorColor: Colors.black38,
        //   decoration: InputDecoration(
        //     hintText: "Store ID",
        //   ),
        // ),
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _controllerPrice,
          cursorColor: Colors.black38,
          decoration: InputDecoration(
            hintText: "price",
          ),
        ),
        SizedBox(
          height: 40,
        ),
        FlatButton(
            color: Colors.black38,
            onPressed: () {
              editProduct();
            },
            child: Text(
              "Done",
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }

  editProduct() async {
    Future.delayed(Duration.zero, () => showAlert(context));

    var name = _controllerName.text;
    var description = _controllerDescription.text;
    var barcode = _controllerBarcode.text;
    //var storeID = _controllerStoreID.text;
    var price = _controllerPrice.text;

    if (name.isNotEmpty && description.isNotEmpty) {
      // var url = Uri.http("localhost:3000", "/api/products/edit/", {'id': item['_id']});
      var url = Uri.parse("http://localhost:3000/api/products/edit/$id");

      var bodyData = json.encode({"name": name, "description": description});
      var response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: bodyData);
      if (response.statusCode == 200 && !json.decode(response.body)['error']) {
        var messageSuccess = json.decode(response.body)['message'];
        showMessage(context, messageSuccess);
      } else if (json.decode(response.body)['error']) {
        var message = json.decode(response.body)['message'];
        showMessage(context, message);
      } else {
        var messageError = "Couldn't connect!!";
        showMessage(context, messageError);
      }
    }
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("succsess"),
            ));
  }
}
