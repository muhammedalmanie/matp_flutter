import 'package:matp/pages/navpages/products_page.dart';
import 'package:flutter/material.dart';
import 'package:matp/pages/navpages/store_page.dart';
import 'package:matp/pages/navpages/addpricepage.dart';

class ProductDetails extends StatefulWidget {
  final int item;

  ProductDetails(this.item);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product #$item Details"),
      ),
      body: Center(
        child: Text('The details page #$item'),
      ),
    );
  }
}

class _ProductDetailsState extends State<ProductDetails> {
  // final int index;
  // _ProductDetailsState(this.index);
  List<Color> colors = [Colors.blue, Colors.green, Colors.yellow, Colors.pink];
  List<String> imagePath = [""];
  var selectedColor = Colors.blue;
  var isFavourite = false;

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Product Details"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              header(),
              hero(),
              //Expanded(child: section()),
              section(),
              //bottomButton(),
              Store1(),
              Store2(),
              Store3(),
              AddStoreButton()
            ],
          ),
        ));
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
              "data:image/jpeg;base64,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"),
          Column(
            children: [
              Text("Apple",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
              Text("Apple",
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 16))
            ],
          ),
          /*Image.asset(
            "images/bag_button.png",
            height: 34,
            width: 34,
          ),*/
        ],
      ),
    );
  }

  Widget hero() {
    return Container(
      child: Stack(
        children: [
          Image.asset(imagePath[colors.indexOf(selectedColor)]),
/*
          Positioned(
              bottom: 10,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: Colors.grey,
                onPressed: (){
                  setState(() {
                    isFavourite = !isFavourite;
                  });
                },
                child: Image.asset(
                  isFavourite ? "images/heart_icon.png" : "images/heart_icon_disabled.png",
                  height: 34,
                  width: 34,
                ),
              )

          )
          */
        ],
      ),
    );
  }

  Widget section() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Text(
            "Lorem ipsum dolor sit, consectetur adipiscing elit. In "
            "rutrum at ex non eleifend. Aenean sed eros a purus "
            "gravida scelerisque id in orci. Mauris elementum id "
            "nibh et dapibus. Maecenas lacinia volutpat magna",
            textAlign: TextAlign.justify,
            style:
                TextStyle(color: AppColor.bodyColor, fontSize: 14, height: 1.5),
          ),
          SizedBox(height: 20),
          //property()
        ],
      ),
    );
  }

  Widget property() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Color",
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              SizedBox(height: 10),
              Row(
                children: List.generate(
                    4,
                    (index) => GestureDetector(
                          onTap: () {
                            print("index $index clicked");
                            setState(() {
                              //selectedColor = colors[index];
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(right: 10),
                            height: 34,
                            width: 34,
                            child: selectedColor == colors[index]
                                ? Image.asset("images/checker.png")
                                : SizedBox(),
                            decoration: BoxDecoration(
                                color: colors[index],
                                borderRadius: BorderRadius.circular(17)),
                          ),
                        )),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Size",
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  color: AppColor.bodyColor.withOpacity(0.10),
                  child: Text(
                    "10.2",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget bottomButton() {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        /*children: [
          FlatButton(
              onPressed: () {},
              child: Text(
                "Add to Bag +",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),

              )),
          Text(r"$95", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28)),

        ],*/
      ),
    );
  }

  Widget Store1() {
    return Container(
      padding: EdgeInsets.only(right: 20),

      //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const StorePage()),
                // );
              },
              child: Text(
                "Pandah",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
          Text(r"1.5 SR",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
          Text("Last Update:",
              style: TextStyle(fontWeight: FontWeight.w100, fontSize: 12))
          //SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget Store2() {
    return Container(
      padding: EdgeInsets.only(right: 20),

      //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
              onPressed: () {},
              child: Text(
                "Tamimi",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
          Text(r"1.25 SR",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
          Text("Last Update:",
              style: TextStyle(fontWeight: FontWeight.w100, fontSize: 12))
          //SizedBox(height: 20),
          //property()
        ],
      ),
    );
  }

  Widget Store3() {
    return Container(
      padding: EdgeInsets.only(right: 20),

      //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
              onPressed: () {},
              child: Text(
                "Danoub",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
          Text(r"1.55 SR",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
          Text("Last Update:",
              style: TextStyle(fontWeight: FontWeight.w100, fontSize: 12))
          //SizedBox(height: 20),
          //property()
        ],
      ),
    );
  }

  void showProductDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: AddPrice(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }

  Widget AddStoreButton() {
    return Container(
        child: FlatButton(
            color: Colors.blue,
            onPressed: showProductDialog,
            child: Text(
              "Add Price",
              style: TextStyle(color: Colors.white),
            )));
  }
}

class AppColor {
  static var black = Color(0xFF2F2F3E);
  static var bodyColor = Color(0xFF6F8398);
}
