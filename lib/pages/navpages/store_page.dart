import 'package:matp/pages/navpages/products_page.dart';
import 'package:flutter/material.dart';




class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Page'),
      ),
      body: Center(
        child: Text('The Store page', style: TextStyle(fontWeight: FontWeight.w100, fontSize: 22)),
    )
    );
  }
}