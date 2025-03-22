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
    }
  }

  Future<void> deleteProduct(productId) async {
    Uri uri = Uri.parse(
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/$productId');

    var response = await httpClient.get(uri);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Product deleted successfully!"),
          backgroundColor: Colors.green,
        ),
      );
      getProductListFromApi(); // Refresh the list after deletion
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to delete product!"),
          backgroundColor: Colors.red,
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Grid View',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 10,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getProductListFromApi();
        },
        child: dataLoadingInProgress
            ? _buildLoadingSkeleton()
            : (productListModel.data == null || productListModel.data!.isEmpty)
                ? const Center(
                    child: Text(
                      'No products found',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: screenWidth > 1200
                          ? 4
                          : screenWidth > 800
                              ? 3
                              : 2, // Adjust columns based on screen width
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8, // Adjust card aspect ratio
                    ),
                    itemCount: productListModel.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final product = productListModel.data![index];
                      return _buildProductCard(product);
                    },
                  ),
      ),
    );
  }

  Widget _buildProductCard(Data product) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display product image if available
              if (product.img != null)
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(product.img!),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              else
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              Text(
                product.productName ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Code: ${product.productCode ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Unit Price: \$${product.unitPrice ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Total Price: \$${product.totalPrice ?? 'N/A'}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      if (product.sId != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductUpdate(productId: product.sId!),
                          ),
                        );
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      if (product.sId != null) {
                        deleteProduct(product.sId);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingSkeleton() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: 6, // Show 6 skeleton cards
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple.shade100, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Skeleton for image
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Skeleton for text
                  Container(
                    height: 20,
                    width: 120,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 15,
                    width: 80,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 15,
                    width: 100,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}