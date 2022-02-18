

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/main.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final formKey = GlobalKey<FormState>();

  // กำหนดตัวแปรรับค่า
  final email = TextEditingController();
  final password = TextEditingController();

  bool isHidden = true;
  bool registeringStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Firebase App",
         
         style: GoogleFonts.shizuru(),
        ), 
        ),
        
        body: Container(
            color: Colors.green[50],
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                          colors: [Colors.pink.shade50, Colors.pink.shade200])),
                  margin: const EdgeInsets.all(32),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildTextFieldEmail(),
                      buildTextFieldPassword(),
                      buildButtonSignIn(),
                    ],
                  )),
            )));
  }

  Container buildButtonSignIn() {
    return Container(
        constraints: const BoxConstraints.expand(height: 50),
       child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Myappbar()),
            );
          },
        ),);
  }

  Container buildTextFieldEmail() {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child:TextFormField(
          keyboardType: TextInputType.emailAddress,
            decoration:const InputDecoration(
              hintText: "Email",
              hintStyle: TextStyle(color: Colors.blueAccent)
              ) ,
            style: const TextStyle(color:Colors.blueAccent ,fontSize: 18)));
  }

  Container buildTextFieldPassword() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
          color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
      child: TextFormField(
        
        controller: password,
        obscureText: !isHidden, //This will obscure text dynamically
        decoration: InputDecoration (
          
          hintText: ' password',
          hintStyle:const TextStyle(color: Colors.blueAccent),
          // Here is key idea
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              isHidden ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                isHidden = !isHidden;
                
              }); 
              
            },
          ),
        ),
        style: const TextStyle(color:Colors.blueAccent ,fontSize: 18)
      ),
    );
  }
}
