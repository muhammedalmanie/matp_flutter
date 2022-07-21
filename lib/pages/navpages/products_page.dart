import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matp/pages/navpages/add_product.dart';
import 'package:matp/pages/navpages/product_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:matp/pages/navpages/edit_product.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late String data;
  //var products;
  List products = [];
  bool isLoading = false; //

  //get index => products;
  //get index => null; /////////////////////////

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  void getData() async {
    // http.Response response =
    // await http.get(Uri.parse("http://docker101.tk/api/products"));
    // var url = Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': 'getting'});
    // var url = Uri.http('docker101.tk', '/api/products');
    //http://docker101.tk/api/products
    var url = Uri.parse("http://localhost:3000/api/products");
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      // Add Your Code here.
      setState(() {
        isLoading = true; //
        products = jsonResponse[
            'products']; //get all the data from json string superheros
        print(products.length); // just printed length of data
      });
    } else {
      print(response.statusCode);
    }
  }

  // appProduct button setup /DELETE ////////////////
  /*
  launchURL(String appProduct) async {
    if (await canLaunch(appProduct)) {
      await launch(appProduct, forceWebView: true);
    } else {
      throw 'Error';
    }
  }
   */
  //////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    void showProductDialog() {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: AddProduct(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Products"),
          leading: IconButton(
            icon: Icon(Icons.add),
            onPressed: () => showProductDialog(),
            /*() {
            const appProduct = 'http://docker101.tk/api/products/add';
            launchURL(appProduct);
          },*/
          ),
        ),
        body: ListView.builder(
            itemCount: products == null ? 0 : products.length,
            itemBuilder: (BuildContext context, int index) {
              return cardItem(products[index]);
            }));
  }

  /*return Card(
            child: ListTile(
              leading: Image.network(
                products[index]['_id'],
                fit: BoxFit.fill,
                width: 250,
                height: 250,
                alignment: Alignment.center,
              ),
              title: Text(products[index]['name'] ?? ''),
              subtitle:
              Text(products[index]['description'] ?? ''),

              // Forwarding
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetails(index)));
              },*/



  Widget cardItem(item) {

    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),

      // The start action pane is the one at the left or the top side.
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed:
                //(){print('You pressed the button.');},
                //showDeleteAlert(context, item),
                doNothing,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),

          SlidableAction(
            onPressed:
                //print('You pressed the button.'),
                //editProduct(item),
                doNothing,
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: tileItem(item),
      //const ListTile(title: Text('Slide me')),
    );
  }

  Widget tileItem(item) {
    return Card(
      child: ListTile(
        leading: Image.network(
          //products[index]['_id'],
          item['_id'],
          fit: BoxFit.fill,
          width: 250,
          height: 250,
          alignment: Alignment.center,
        ),
        title: Text(item['name'] ?? ''),
        subtitle: Text(item['description'] ?? ''),

        // Forwarding
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProductDetails(item)));
        },
      ),
    );
  }
    editProduct(item) {
    var id = item['_id'].toString();
    var name = item['name'].toString();
    var description = item['description'].toString();
    Navigator.push(
         context,
         MaterialPageRoute(
             builder: (context) => EditProduct(
                   id: id,
                   name: name,
                   description: description,
                 )));
  }


  deleteProduct(id) async {
    var url = Uri.parse("http://localhost:3000/api/products/delete/:$id");
    var response = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });
    if (response.statusCode == 200) {
      this.getData();
    }
  }

  showDeleteAlert(BuildContext context, item) {
    // set up the buttons
    Widget noButton = FlatButton(
      child: Text(
        "No",
        style: TextStyle(color: Colors.pink),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget yesButton = FlatButton(
      child: Text("Yes", style: TextStyle(color: Colors.pink)),
      onPressed: () {
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

  void doNothing(BuildContext context) {print("delete");}


}

