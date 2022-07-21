import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matp/pages/navpages/products_page.dart';
import 'package:matp/pages/util.dart';

//const String BASE_API = "http://docker101.tk/api/products/add";


class AddPrice extends StatefulWidget {
  const AddPrice({Key? key}) : super(key: key);

  @override
  _AddPriceState createState() => _AddPriceState();
}

class _AddPriceState extends State<AddPrice> {
  final TextEditingController _controllerName = new TextEditingController();
  final TextEditingController _controllerDescription = new TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Add Price"),
      ),
      body: getBody(),
    );
  }

  Widget getBody(){
    return ListView(
      padding: EdgeInsets.all(30),
      children: <Widget>[
        SizedBox(height: 30,),
        TextField(
          controller: _controllerName,
          cursorColor: Colors.pink,
          decoration: InputDecoration(
            hintText: "Store",
          ),
        ),

        SizedBox(height: 40,),
        TextField(
          controller: _controllerDescription,
          cursorColor: Colors.pink,
          decoration: InputDecoration(
            hintText: "Price",
          ),
        ),
        SizedBox(height: 50,),
        FlatButton(
            color: Colors.blue,
            onPressed: (){
              createNewProduct();
            }, child: Text("Save",style: TextStyle(color: Colors.white),))
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
    if(name.isNotEmpty && description.isNotEmpty){
      var url = Uri.parse("http://localhost:3000/api/products/add");
      var bodyData = json.encode({
        "name" : name,
        "description" : description
      });
      var response = await http.post(url,headers: {
        "Content-Type" : "application/json",
        "Accept" : "application/json"
      },body: bodyData);
      if(response.statusCode == 200){
        var message = json.decode(response.body)['message'];
        showMessage(context,message);
        setState(() {
          _controllerName.text = "";
          _controllerDescription.text = "";
        });
      }else {
        var messageError = "Can not create new user!!";
        showMessage(context,messageError);
      }

    }
  }
/////////////////////////////



}

