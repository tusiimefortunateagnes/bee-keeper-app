// ignore_for_file: depend_on_referenced_packages

import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import '/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

final usernamecontroller = TextEditingController();
final passwordcontroller = TextEditingController();
var mytoken = '';

Future<void> Logmein(BuildContext context) async {
  print(
      "Username: ${usernamecontroller.text}, Password: ${passwordcontroller.text}");
  var headers = {'Accept': 'application/json'};
  var request = http.MultipartRequest(
      'POST', Uri.parse('https://www.ademnea.net/api/v1/login'));
  request.fields.addAll(
      {'email': usernamecontroller.text, 'password': passwordcontroller.text});
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String responseBody = await response.stream.bytesToString();
    Map<String, dynamic> responseData = jsonDecode(responseBody);
    String token = responseData['token'];
    saveToken(token);

    // Print success message
    // print(token);

    Fluttertoast.showToast(
        msg: "Successful!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);

    // Log the farmer in
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => navbar(
          token: mytoken,
        ),
      ),
    );
  } else {
    // Print "unauthorized"
    // print("Wrong credentials!");
    print(response.reasonPhrase);
    Fluttertoast.showToast(
        msg: "Wrong Credentials!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

void saveToken(String token) {
  // For simplicity, let's store it in a global variable
  mytoken = token;
}

//functions to launch the external url.
final Uri _url = Uri.parse('http://wa.me/+256755088321');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

class _loginState extends State<login> {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Container(
                  height: 100,
                ),
                //image starts here
                Center(
                  child: Image.asset(
                    'lib/images/log-1.png',
                    height: 200,
                    width: 200,
                  ),
                ),
                Container(
                  height: 25,
                ),

                TextFormField(
                  controller: usernamecontroller,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    fillColor: Colors.brown.shade50, // Background color
                    filled:
                        true, // Set to true to fill the background with the specified color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none, // No border for the outline
                    ),

                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(
                          16), // Add left padding to the prefix icon
                      child: Icon(
                        Icons.person,
                        color: Colors.grey.shade500,
                      ), // Placeholder icon
                    ),
                  ),
                  validator: (value) {
                    return value!.isEmpty ? "Email is required" : null;
                  },
                  style: const TextStyle(
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                    fontSize: 20, // Increase the height of the text field
                  ),
                ),
                Container(
                  height: 20,
                ),

                TextFormField(
                  controller: passwordcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    fillColor: Colors.brown.shade50, // Background color
                    filled:
                        true, // Set to true to fill the background with the specified color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none, // No border for the outline
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(
                          16), // Add left padding to the prefix icon
                      child: Icon(
                        Icons.lock,
                        color: Colors.grey.shade500,
                      ), // Placeholder icon
                    ),
                  ),
                  style: const TextStyle(
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                    fontSize: 20, // Increase the height of the text field
                  ),
                  validator: (x) {
                    return x!.isEmpty
                        ? "Password is required"
                        : x.length < 6
                            ? "Password must be atleast 6 characters"
                            : null;
                  },
                ),
                Container(
                  height: 10,
                ),

                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 206, 109, 40),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context)
                      .size
                      .width, // Specify the desired width here
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        //
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        const Color.fromARGB(255, 206, 109, 40), // RGB color
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 12.0,
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  height: 20,
                ),
                //bottom navigation.
                const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have no account?"),
                      SizedBox(width: 1), // Add some space between the texts
                      TextButton(
                        onPressed: _launchUrl,
                        child: Text(
                          "contact support team to register",
                          style: TextStyle(
                            color: Colors
                                .blue, // Change color to blue for a link-like appearance
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                //closes the column
              ],
            ),
          ),
        ),
      ),
    );
  }
}
