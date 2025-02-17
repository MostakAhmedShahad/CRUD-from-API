import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screen/pojo_file_product_grid_view.dart';
import 'package:flutter_application_1/Screen/product_update.dart';
import 'package:http/http.dart';

class Productgridviewscreen extends StatefulWidget {
  const Productgridviewscreen({super.key});

  @override
  State<Productgridviewscreen> createState() => _ProductgridviewscreenState();
}

class _ProductgridviewscreenState extends State<Productgridviewscreen> {
  final Client httpClient = Client();
  ProductListModel productListModel = ProductListModel();

  bool dataLoadingInProgress = false;
  String? productId;

  Future<void> getProductListFromApi() async {
    setState(() {
      dataLoadingInProgress = true;
    });
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct');

    Response response = await httpClient.get(uri);

    if (response.statusCode == 200) {
      setState(() {
        productListModel = ProductListModel.fromJson(jsonDecode(response.body));
        dataLoadingInProgress = false;
      });
    } else {
      setState(() {
        dataLoadingInProgress = false;
      });
      //print('Failed to load data. Status Code: ${response.statusCode}');
    }
  }

  Future<void> deleteProduct( productId) async {
    Uri uri = Uri.parse(
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/$productId');
    
    var response = await httpClient.get(
      uri,
      
       
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Product delete successfully!"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to delete product!"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getProductListFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Grid View'),
          // actions: [
          //   Padding(
          //     padding: EdgeInsets.all(15),
          //     child: IconButton(
          //         onPressed: () {
          //           Navigator.push(context,
          //               MaterialPageRoute(builder: (context) => ProductUpdate(productId: ,)));
          //         },
          //         icon: Icon(Icons.edit)),
          //   )
          // ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            getProductListFromApi();
          },
          child: dataLoadingInProgress
              ? const Center(child: CircularProgressIndicator())
              : (productListModel.data == null ||
                      productListModel.data!.isEmpty)
                  ? const Center(
                      child:
                          Text('No products found')) //   Check for empty data
                  : ListView.builder(
                      itemCount: productListModel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final product = productListModel.data![index];

                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: ListTile(
                            title: Column(
                              children: [
                                Text(product.productName ?? 'Unknown'),
                                Text(
                                    'Product Code: ${product.productCode ?? 'N/A'}'),
                                Text(
                                    'Unit Price: ${product.unitPrice ?? 'N/A'}'),
                                Text(
                                    'Total Price: ${product.totalPrice ?? 'N/A'}'),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    icon: Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () {
                                      // 1️⃣ CHANGE HERE: Pass product ID dynamically to ProductUpdate page
                                      if (product.sId != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductUpdate(productId: product.sId!),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Product ID is missing!")),
                                        );
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      // 1️⃣ CHANGE HERE: Pass product ID dynamically to ProductUpdate page
                                      if (product.sId != null) {
                                         deleteProduct( product.sId);
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Product ID is missing!")),
                                        );
                                      }
                                    },
                                  ),
                              ],
                            ),
                            






                          ),
                        );
                      },
                    ),
        ));
  }
}










