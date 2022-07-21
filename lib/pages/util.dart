import 'package:flutter/material.dart';
import 'package:matp/pages/navpages/products_page.dart';

showMessage(BuildContext context,String contentMessage) {


  Widget yesButton = FlatButton(
    child: Text("OK",style: TextStyle(color: Colors.grey)),
    onPressed:  () {
      Navigator.pop(context);

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          ProductsPage()), (Route<dynamic> route) => false);
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