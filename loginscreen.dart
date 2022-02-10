import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:project/main.dart';
import 'package:form_field_validator/form_field_validator.dart';
class MyloginPage extends StatefulWidget {
  const MyloginPage({Key? key}) : super(key: key);

  @override
  _MyloginPageState createState() => _MyloginPageState();
}

class _MyloginPageState extends State<MyloginPage> {


  bool _isObscure = true ; 
  final _forKey = GlobalKey<FormState > ();
 
 
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body:Form( 
      key: _forKey, 
      child:Column( 
        children:<Widget> [ 
          Padding( 
            padding:const EdgeInsets.all(8.0), 
            child: TextFormField( 
              decoration:const InputDecoration( 
                labelText: 'Username ',
                icon: Icon(Icons.ac_unit), 
                
              ), 
              validator:RequiredValidator(errorText: '* require '), 
      
            ),
          ), 
       Padding(
        padding: const EdgeInsets.all(8.0),
          child: TextField(
            obscureText: _isObscure,
            decoration: InputDecoration(
                labelText: 'Password', 
                icon: const Icon(Icons.password),
                suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    })),  
          ) ,
       ),
          Padding( 
            padding: const EdgeInsets.all(8),  
            child:Center(
               child: ElevatedButton(
                 onPressed: (){ 
                   Navigator.pop(context);
                   },
                   child: const Text('Login'),
                   ),
                   ) ,
          ), 
          Padding(
            padding: const EdgeInsets.all(8.0), 
            child:TextButton(
              onPressed: () { 
               Navigator.push( 
                  context, MaterialPageRoute( 
                    builder: (context) => const Myappbar ()), );

                },  
                child:Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container( 
                      alignment: Alignment.bottomLeft,
                      child: const Text('Registered?'), 
                       ) 

                     ),
                    ) ,
           ),
         ],
        )
     ) 
    );
  }
} 

