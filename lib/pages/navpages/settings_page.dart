import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:matp/pages/navpages/add_product.dart';
import 'package:matp/pages/navpages/edit_product.dart';
import 'package:flutter/cupertino.dart';

/*
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List products = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchProduct();
  }
  fetchProduct() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse("http://localhost:3000/api/products");
    var response = await http.get(url);
    if(response.statusCode == 200){
      var items = json.decode(response.body)['data'];
      setState(() {
        products = items;
        isLoading = false;
      });
    }else{
      setState(() {
        products = [];
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Peoducts"),
        actions: <Widget>[
          FlatButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
          }, child: Icon(Icons.add,color: Colors.white,))
        ],
      ),
      body: getBody(),
    );
  }
  Widget getBody(){
    if(isLoading || products.length == 0){
      return Center(child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.pink)
      ));
    }
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context,index){
          return cardItem(products[index]);
        });
  }
  Widget cardItem(item){
    var name = item['name'];
    var description = item['description'];

    return Card(

    child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: ListTile(
            title: Text(name),
            subtitle: Text(description),
          ),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Edit',
            color: Colors.blueAccent,
            icon: Icons.edit,
            onTap: () => editProduct(item),
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => showDeleteAlert(context,item),


          ),
        ],
      ),
    );


  }

  editProduct(item){
    var id = item['_id'].toString();
    var name = item['name'].toString();
    var description = item['description'].toString();
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProduct(id: id,name: name,description: description,)));
  }
  deleteProduct(id) async {
    var url = Uri.parse("http://localhost:3000/api/products/delete/:$id");
    var response = await http.post(url,headers: {
      "Content-Type" : "application/json",
      "Accept" : "application/json"
    });
    if(response.statusCode == 200){
      this.fetchProduct();
    }
  }
  showDeleteAlert(BuildContext context,item) {

    // set up the buttons
    Widget noButton = FlatButton(
      child: Text("No",style: TextStyle(color: Colors.pink),),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    Widget yesButton = FlatButton(
      child: Text("Yes",style: TextStyle(color: Colors.pink)),
      onPressed:  () {
        Navigator.pop(context);

        deleteProduct(item['_id']);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text("Would you like to delete this user?"),
      actions: [
        noButton,
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


*/