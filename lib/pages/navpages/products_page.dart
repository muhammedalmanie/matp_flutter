import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:matp/models/product_model.dart';
import 'package:matp/pages/navpages/add_product.dart';
import 'package:matp/pages/navpages/product_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:matp/pages/navpages/edit_product.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:matp/pages/util.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final TextEditingController controller = TextEditingController();
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
        // print(produc.length); // just printed length of data
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
        ),

        //     AnimSearchBar(
        //   width: 400,
        //   textController: textController,
        //   onSuffixTap: () {
        //     setState(() {
        //       textController.clear();
        //     });
        //   },
        // ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              searchBar(),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SizedBox(
                    height: 300.0,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: products == null ? 0 : products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return cardItem(products[index]);
                        })),
              ),
            ],
          )
        ],
      ),
    );

    //   body: new Container(
    //       color: Color(0xff258DED),
    //       height: 400.0,
    //       alignment: Alignment.center,
    //       child: new Column(
    //           children: [
    //               new Container(

    //               ),
    //               new Container(

    //               ),
    //           ],
    //       ),
    //   )
    // );
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

  //var controller;
  Widget searchBar() {
    return Card(
      child: SizedBox(
        width: 550,
        child: TextField(
            controller: controller,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
            )
            //onChanged: searchProduct,
            ),
      ),
    );
  }

  void searchProduct(String query) {
    final suggestions = products.where((item) {
      final bookTitle = item.name.toLowerCase();
      final input = query.toLowerCase();
      return bookTitle.contains(input);
    }).toList();
    setState(() => products = suggestions);
  }

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
                //deleteProduct(item['_id']),

                (context) {
              deleteProduct(item);
            },

            // (context) {
            //   showDeleteAlert(context, item);
            //     },

            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),

          SlidableAction(
            onPressed:
                //print('You pressed the button.'),
                //editProduct(item),
                //doNothing,

                (context) {
              editProduct(item);
            },
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
          'https://waapple.org/wp-content/uploads/2021/06/Variety_Cosmic-Crisp-transparent-300x300.png',
          //products[index]['_id'],
          //item['_id'],
          fit: BoxFit.fill,
          // width: 300,
          // height: 300,
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
    log("edited");
    var id = item['_id'].toString();
    var name = item['name'].toString();
    var description = item['description'].toString();
    var barcode = item['barcode'].toString();
    //var storeID = item['store'].toString();
    var price = item['productPrice'].toString();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProduct(
                  id: id,
                  name: name,
                  description: description,
                  barcode: barcode,
                  //storeID: storeID,
                  price: price,
                )));
  }

  deleteProduct(item) {
    Future.delayed(Duration.zero, () => showAlert(context));
    var url = Uri.http("localhost:3000", "/api/products/", {'id': item['_id']});
    var response = http.delete(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });
    response.then((value) => {
          if (value.statusCode == 200 && jsonDecode(value.body)['error'])
            {getData()}
        });
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("You Have Deleted a Product Successfully"),
            ));
  }

  // showDeleteAlert(BuildContext context, item) {
  //   // set up the buttons
  //   Widget noButton = FlatButton(
  //     child: Text(
  //       "No",
  //       style: TextStyle(color: Colors.pink),
  //     ),
  //     onPressed: () {
  //       Navigator.pop(context);
  //     },
  //   );

  //   Widget yesButton = FlatButton(
  //     child: Text("Yes", style: TextStyle(color: Colors.pink)),
  //     onPressed: () {
  //       Navigator.pop(context);

  //       deleteProduct(item['_id']);
  //     },
  //   );

  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text("Message"),
  //     content: Text("Would you like to delete this product?"),
  //     actions: [
  //       noButton,
  //       yesButton,
  //     ],
  //   );
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  void doNothing(BuildContext context) {
    print("delete");
  }

  // void deleteProduct2()async{
  //       await http.delete(Uri.parse("http://localhost:3000/api/products/:$id"));
  //        Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (BuildContext context) => ProductsPage()),
  //           (Route<dynamic> route) => false);
  //     }

}
