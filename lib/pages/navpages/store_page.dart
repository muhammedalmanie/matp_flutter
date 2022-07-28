import 'dart:developer';
import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matp/pages/util.dart';

//const String BASE_API = "http://docker101.tk/api/products/add";

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final TextEditingController _controllerName = new TextEditingController();
  final TextEditingController _controllerLocation = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store Creation"),
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
            hintText: "Store Name",
          ),
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _controllerLocation,
          cursorColor: Colors.blue,
          decoration: InputDecoration(
            hintText: "Location",
          ),
        ),
        SizedBox(
          height: 40,
        ),
        FlatButton(
            color: Colors.blue,
            onPressed: () {
              createNewStore();
            },
            child: Text(
              "Done",
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }

  ///////////////////////////////////////////
  createNewStore() async {
    Future.delayed(Duration.zero, () => showAlert(context));
    log("Hdsddswwdddgs");

    var name = _controllerName.text;
    var location = _controllerLocation.text;

    if (name.isNotEmpty && location.isNotEmpty) {
      var url = Uri.parse("http://localhost:3000/api/stores/add");
      var bodyData = json.encode({
        "name": name,
        "location": location,
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
          _controllerLocation.text = "";
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
              content: Text("You Have Added a Store Successfully"),
            ));
  }
}
