import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../Style/style.dart'; // Import the styles file

class ProductUpdate extends StatefulWidget {
  final String productId; // ✅ Define productId

  const ProductUpdate({Key? key, required this.productId}) : super(key: key);

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
          backgroundColor: colorGreen,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to update product!"),
          backgroundColor: colorRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Product',
          style: appBarTitleStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 10,
        shadowColor: Colors.purple.withOpacity(0.5),
      ),
      body: Container(
        decoration: appBackgroundGradient(),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: screenWidth > 600 ? 800 : double.infinity, // Limit width for larger screens
              ),
              child: Card(
                elevation: 10,
                shadowColor: Colors.purple.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: appCardDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Update Product',
                        style: formTitleStyle,
                      ),
                      SizedBox(height: 20),
                      // Responsive form layout
                      screenWidth > 600
                          ? _buildGridForm() // Use grid layout for larger screens
                          : _buildColumnForm(), // Use column layout for smaller screens
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: updateProduct,
                        style: appElevatedButtonStyle(),
                        child: Text(
                          'Update Product',
                          style: buttonTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build form in a grid layout (2 columns) for larger screens
  Widget _buildGridForm() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2, // 2 columns
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 3, // Adjust aspect ratio for better spacing
      children: [
        _buildTextField(
          controller: productNameController,
          label: 'Product Name',
          icon: Icons.shopping_bag,
        ),
        _buildTextField(
          controller: productCodeController,
          label: 'Product Code',
          icon: Icons.code,
        ),
        _buildTextField(
          controller: imgController,
          label: 'Product Image URL',
          icon: Icons.image,
        ),
        _buildTextField(
          controller: unitPriceController,
          label: 'Unit Price',
          icon: Icons.attach_money,
        ),
        _buildTextField(
          controller: totalPriceController,
          label: 'Total Price',
          icon: Icons.money_off,
        ),
        _buildTextField(
          controller: qtyController,
          label: 'Quantity',
          icon: Icons.format_list_numbered,
        ),
      ],
    );
  }

  // Build form in a single column layout for smaller screens
  Widget _buildColumnForm() {
    return Column(
      children: [
        _buildTextField(
          controller: productNameController,
          label: 'Product Name',
          icon: Icons.shopping_bag,
        ),
        SizedBox(height: 15),
        _buildTextField(
          controller: productCodeController,
          label: 'Product Code',
          icon: Icons.code,
        ),
        SizedBox(height: 15),
        _buildTextField(
          controller: imgController,
          label: 'Product Image URL',
          icon: Icons.image,
        ),
        SizedBox(height: 15),
        _buildTextField(
          controller: unitPriceController,
          label: 'Unit Price',
          icon: Icons.attach_money,
        ),
        SizedBox(height: 15),
        _buildTextField(
          controller: totalPriceController,
          label: 'Total Price',
          icon: Icons.money_off,
        ),
        SizedBox(height: 15),
        _buildTextField(
          controller: qtyController,
          label: 'Quantity',
          icon: Icons.format_list_numbered,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: appInputDecoration(label, icon),
    );
  }
}