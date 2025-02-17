import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Style/style.dart';
import 'package:http/http.dart';

class ProductUpdate extends StatefulWidget {
 // const ProductUpdate({super.key});
  final String productId; // ✅ Define productId

  const ProductUpdate ({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductUpdate> createState() => _ProductUpdateState();
}

class _ProductUpdateState extends State<ProductUpdate> {

  final Client httpClient = Client();
  final TextEditingController imgController = TextEditingController();
  final TextEditingController productCodeController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController totalPriceController = TextEditingController();
  final TextEditingController unitPriceController = TextEditingController();
  
   

  Future<void> updateProduct() async {
    Uri uri = Uri.parse(
        'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.productId}');
    
    var response = await httpClient.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "Img": imgController.text,
        "ProductCode": productCodeController.text,
        "ProductName": productNameController.text,
        "Qty": qtyController.text,
        "TotalPrice": totalPriceController.text,
        "UnitPrice": unitPriceController.text,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Product updated successfully!"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to update product!"),
        ),
      );
    }
  }
  
  
  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('Update Product')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: productNameController,
              decoration: AppInputDecoration('Product Name'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: productCodeController,
              decoration: AppInputDecoration('Product Code'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: imgController,
              decoration: AppInputDecoration('Product Image'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: unitPriceController,
              decoration: AppInputDecoration('Unit Price'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: totalPriceController,
              decoration: AppInputDecoration('Total Price'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: qtyController,
              decoration: AppInputDecoration('Qty'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: updateProduct,
                style: AppElevatedButton(),
                child: const Text("Update Product"),
              ),
            ),
          ],
        ),
      ),
    
  




    );
  }
}










      