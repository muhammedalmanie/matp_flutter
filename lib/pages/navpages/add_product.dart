import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matp/pages/navpages/products_page.dart';
import 'package:matp/pages/util.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          cursorColor: Colors.pink,
          decoration: InputDecoration(
            hintText: "Name",
          ),
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _controllerDescription,
          cursorColor: Colors.pink,
          decoration: InputDecoration(
            hintText: "Description",
          ),
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _controllerBarcode,
          cursorColor: Colors.pink,
          decoration: InputDecoration(
            hintText: "Barcode",
          ),
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _controllerStoreID,
          cursorColor: Colors.pink,
          decoration: InputDecoration(
            hintText: "Store ID",
          ),
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _controllerPrice,
          cursorColor: Colors.pink,
          decoration: InputDecoration(
            hintText: "Price",
          ),
        ),

/*
        SizedBox(height: 30,),
        //DropdownButton(items: [], onChanged:),
        DropdownButton<String>(
          items: <String>['A', 'B', 'C', 'D'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        ),
*/

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
  createNewProduct() async {
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
        var messageError = "Couldn't not connect!!";
        showMessage(context, messageError);
      }
    }
  }
  /////////////////////////////

}
