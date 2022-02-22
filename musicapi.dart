import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Second Route', 
         style: GoogleFonts.shizuru(),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child:  Text('Go back!' ,
           style: GoogleFonts.shizuru(),
          ),
        ),
      ),
    );
    
  }
}