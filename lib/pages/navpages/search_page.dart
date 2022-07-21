import 'package:flutter/material.dart';
import 'package:matp/pages/navpages/product_data.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
        ),
      ),
      body: _buildListview(context),
    );
  }

  ListView _buildListview(BuildContext context){

        return ListView.builder(
            itemCount: 10,
            itemBuilder:(_, index) {
              return ListTile(
                title: Text('Product #$index'),
                trailing: Icon(Icons.arrow_forward),
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProductDetails(index)));
                  },
              );
            }
        );
  }
}
