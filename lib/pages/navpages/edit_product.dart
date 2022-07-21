import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matp/pages/util.dart';

class EditProduct extends StatefulWidget {
  String id;
  String name;
  String description;
  EditProduct({required this.id,required this.name,required this.description});
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final TextEditingController _controllerFullName = new TextEditingController();
  final TextEditingController _controllerEmail = new TextEditingController();
  String id = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    setState(() {
      id = widget.id;
      _controllerFullName.text = widget.name;
      _controllerEmail.text = widget.description;
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
  Widget getBody(){
    return ListView(
      padding: EdgeInsets.all(30),
      children: <Widget>[
        SizedBox(height: 30,),
        TextField(
          controller: _controllerFullName,
          cursorColor: Colors.black38,
          decoration: InputDecoration(
            hintText: "name",
          ),
        ),
        SizedBox(height: 30,),
        TextField(
          controller: _controllerEmail,
          cursorColor: Colors.black38,
          decoration: InputDecoration(
            hintText: "description",
          ),
        ),
        SizedBox(height: 40,),
        FlatButton(
            color: Colors.black38,
            onPressed: (){
              editProduct();
            }, child: Text("Done",style: TextStyle(color: Colors.white),))
      ],
    );
  }
  editProduct() async {

    var name = _controllerFullName.text;
    var description = _controllerEmail.text;
    if(name.isNotEmpty && description.isNotEmpty){
      var url = Uri.parse("http://localhost:3000/api/products/edit/:$id");
      var bodyData = json.encode({
        "name" : name,
        "description" : description
      });
      var response = await http.post(url,headers: {
        "Content-Type" : "application/json",
        "Accept" : "application/json"
      },body: bodyData);
      if(response.statusCode == 200){
        var messageSuccess = json.decode(response.body)['message'];
        showMessage(context,messageSuccess);
      }else {
        var messageError = "Can not update this product!!";
        showMessage(context,messageError);
      }
    }
  }
}

