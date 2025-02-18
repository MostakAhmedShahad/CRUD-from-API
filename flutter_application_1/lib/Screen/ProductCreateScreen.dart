import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Screen/ProductGridViewScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/Style/style.dart';
import 'package:http/http.dart';

class Productcreatescreen extends StatefulWidget {
  @override
  State<Productcreatescreen> createState() => _ProductcreatescreenState();
}

class _ProductcreatescreenState extends State<Productcreatescreen> {
  final Client httpClient = Client();
  //final apiUrl = 'https://crud.teamrabbil.com/api/v1/CreateProduct';
  final TextEditingController imgController = TextEditingController();
  final TextEditingController ProductCodeController = TextEditingController();
  final TextEditingController ProductNameController = TextEditingController();
  final TextEditingController QtyController = TextEditingController();
  final TextEditingController TotalPriceController = TextEditingController();
  final TextEditingController UnitPriceController = TextEditingController();

  Future<void> sendPostRequest() async {
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct');
    var response = await httpClient.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "Img": imgController.text,
          "ProductCode": ProductCodeController.text,
          "ProductName": ProductNameController.text,
          "Qty": QtyController.text,
          "TotalPrice": TotalPriceController.text,
          "UnitPrice": UnitPriceController.text,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Post created successfully!"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to create post!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Child vs children'),
      ),
      body: Stack(
        children: [
          //ScreenBackground(context),
          Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    // onChanged: (value) {},
                    controller: ProductNameController,
                    decoration: AppInputDecoration('Product Name'),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    //onChanged: (value) {},
                    controller: ProductCodeController,
                    decoration: AppInputDecoration('Product Code'),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    // onChanged: (value) {},
                    controller: imgController,
                    decoration: AppInputDecoration('Product Image'),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    // onChanged: (value) {},
                    controller: UnitPriceController,
                    decoration: AppInputDecoration('Unit Price'),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    // onChanged: (value) {},
                    controller: TotalPriceController,
                    decoration: AppInputDecoration('Total Price'),
                  ),
                  SizedBox(height: 20),

                  TextFormField(
                    //onChanged: (value) {},
                    controller: QtyController,
                    decoration: AppInputDecoration('Qty'),
                  ),
                  // AppDropDownStyle(DropdownButton(
                  //   value: "",
                  //   items: [
                  //     DropdownMenuItem(
                  //       child: Text('Select Qt'),
                  //       value: "",
                  //     ),
                  //     DropdownMenuItem(
                  //       child: Text('1 pcs'),
                  //       value: "1 pcs",
                  //     ),
                  //     DropdownMenuItem(
                  //       child: Text('2 pcs'),
                  //       value: "2 pcs",
                  //     ),
                  //     DropdownMenuItem(
                  //       child: Text('3 pcs '),
                  //       value: "3 pcs",
                  //     ),
                  //     DropdownMenuItem(
                  //       child: Text('4 pcs '),
                  //       value: "4 pcs",
                  //     ),
                  //   ],
                  //   onChanged: (value) {},
                  //   underline: Container(),
                  //   isExpanded: true,
                  // )
                  // ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        sendPostRequest();
                      },
                      style: AppElevatedButton(),
                      child: Text("Submit"),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text('Open route'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const Productgridviewscreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import '../../api/apiClient.dart';
// import '../../style/style.dart';

// class loginScreen extends StatefulWidget {
//   const loginScreen({Key? key}) : super(key: key);
//   @override
//   State<loginScreen> createState() => _loginScreenState();
// }

// class _loginScreenState extends State<loginScreen> {

//   Map<String,String> FormValues={"email":"", "password":""};
//   bool Loading=false;

//   InputOnChange(MapKey, Textvalue){
//     setState(() {
//       FormValues.update(MapKey, (value) => Textvalue);
//     });
//   }
  
//   FormOnSubmit() async{
//     if(FormValues['email']!.length==0){
//       ErrorToast('Email Required !');
//     }
//     else if(FormValues['password']!.length==0){
//       ErrorToast('Password Required !');
//     }
//     else{
//       setState(() {Loading=true;});
//       bool res=await LoginRequest(FormValues);
//       if(res==true){
//        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
//       }
//       else{
//         setState(() {Loading=false;});
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           ScreenBackground(context),
//           Container(
//             alignment: Alignment.center,
//             child: Loading?(Center(child: CircularProgressIndicator())):(SingleChildScrollView(
//              padding: EdgeInsets.all(30),
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: [
//                  Text("Get Started With", style: Head1Text(colorDarkBlue)),
//                  SizedBox(height: 1),
//                  Text("Learn with rabbil hasan", style: Head6Text(colorLightGray)),
//                  SizedBox(height: 20),

//                  TextFormField(
//                    onChanged: (Textvalue){
//                      InputOnChange("email",Textvalue);
//                    },
//                    decoration: AppInputDecoration("Email Address"),
//                  ),

//                  SizedBox(height: 20),

//                  TextFormField(
//                    onChanged: (Textvalue){
//                      InputOnChange("password",Textvalue);
//                    },
//                    decoration: AppInputDecoration("Password"),
//                  ),

//                  SizedBox(height: 20),


//                  Container(child: ElevatedButton(
//                    style: AppButtonStyle(),
//                    child: SuccessButtonChild('Login'),
//                    onPressed: (){
//                      FormOnSubmit();
//                    },
//                  ),),

//                  SizedBox(height: 20),
                 

//                  Container(
//                    alignment: Alignment.center,
//                    child: Column(
//                      children: [
//                        SizedBox(height: 20),
//                        InkWell(
//                            onTap: (){
//                              Navigator.pushNamed(context, "/emailVerification");
//                            },
//                            child: Text('Forget Password?',style: Head7Text(colorLightGray),
//                            )
//                        ),

//                        SizedBox(height: 15),

//                        InkWell(
//                            onTap: (){
//                              Navigator.pushNamed(context, "/registration");
//                            },
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: [
//                                Text("Don't have a account? ",style: Head7Text(colorDarkBlue)),
//                                Text("Sign Up",style: Head7Text(colorGreen),)
//                              ],
//                            )
//                        )
//                      ],
//                    ),
//                  )
                 
                 
//                ],
//              ),
//            )),
//           )
//         ],
//       ),
//     );
//   }
// }