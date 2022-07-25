// import 'dart:convert';
// import 'dart:io';
// import 'package:matp/models/product_model.dart';
// import 'package:http/http.dart' as http;
// import '../../config.dart';

// class APIService {
//   static var client = http.Client();

//   static Future<List<ProductModel>?> getProducts() async {
//     Map<String, String> requestHeaders = {
//       'Content-Type': 'application/json',
//     };

//     var url = Uri.http(
//       Config.apiURL,
//       Config.productsAPI,
//     );

//     var response = await client.get(
//       url,
//       headers: requestHeaders,
//     );

//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);

//       return productsFromJson(data["data"]);

//       //return true;
//     } else {
//       return null;
//     }
//   }

//   static Future<bool> saveProduct(
//     ProductModel model,
//     bool isEditMode,
//     bool isFileSelected,
//   ) async {
//     var productURL = Config.productsAPI;

//     if (isEditMode) {
//       productURL = productURL + "/" + model.id.toString();
//     }

//     var url = Uri.http(Config.apiURL, productURL);

//     var requestMethod = isEditMode ? "PUT" : "POST";

//     var request = http.MultipartRequest(requestMethod, url);
//     request.fields["productName"] = model.Name!;
//     request.fields["productBarcode"] = model.Barcode!.toString();

//     if (model.Image != null && isFileSelected) {
//       http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
//         'productImage',
//         model.Image!,
//       );

//       request.files.add(multipartFile);
//     }

//     var response = await request.send();

//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   static Future<bool> deleteProduct(productId) async {
//     Map<String, String> requestHeaders = {
//       'Content-Type': 'application/json',
//     };

//     var url = Uri.http(
//       Config.apiURL,
//       Config.productsAPI + "/" + productId,
//     );

//     var response = await client.delete(
//       url,
//       headers: requestHeaders,
//     );

//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }
