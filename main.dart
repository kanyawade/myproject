//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:myapp/appbarmodel/appbarnavi.dart';

import 'package:myapp/loginscreen/register.dart';
import 'package:myapp/musiclist/musicapi.dart';
//import 'package:myapp/musiclist/musicapi.dart';

import 'appbardesign/appbarstlye.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const Myappbar());
}

class Myappbar extends StatefulWidget {
  const Myappbar({Key? key}) : super(key: key);

  @override
  _MyappbarState createState() => _MyappbarState();
}

class _MyappbarState extends State<Myappbar> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: FirstRoute());
  }
}

class FirstRoute extends StatefulWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  bool pressed = true;
  
  Color _iconColor = Colors.amber;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
      };
      if (states.any(interactiveStates.contains)) {
        return const Color.fromARGB(235, 165, 143, 45);
      }
      return Colors.white;
    }

    Color getColortwo(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
      };
      if (states.any(interactiveStates.contains)) {
        return const Color.fromARGB(235, 165, 143, 45);
      }
      return Colors.black;
    }
 var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // body: const TopBarContent(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              child: Text(
                'Home',
                style: GoogleFonts.architectsDaughter(
                    textStyle: const TextStyle(color: Colors.yellow),
                    fontSize: 30.0),
              ),
            ),
            ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.play_arrow),
                  color: _iconColor,
                  iconSize: 50,
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SecondRoute()));
                      _iconColor = Colors.deepPurple;
                    });
                  },
                ),
                title: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const MyApp()));
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.resolveWith(getColortwo), 
                         splashFactory:  NoSplash.splashFactory, 
                          overlayColor: MaterialStateProperty.all(Colors.transparent)
                  ),
                  child: Text(
                    ' Music List',
                    style: GoogleFonts.architectsDaughter(
                        textStyle: const TextStyle(fontSize: 28)),
                  ),
                ))
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 150),
        child: ClipPath(
          clipper: WaveClip(),
          child: Container(
            padding: EdgeInsets.zero,
            width: MediaQuery.of(context).size.width, 

            child:Stack(  
              children: [  
            
                AppBar(
              backgroundColor: Colors.black, 
                 
             title :  Row( 
                mainAxisAlignment: MainAxisAlignment.start,
               children: [  
                Text(
                'DonangHufp ',
                style: GoogleFonts.architectsDaughter(
                    textStyle: const TextStyle(color: Colors.white, fontSize: 28)),
              ), 
                  InkWell(
                        onTap: () {},
                        child: const Text(
                          'Discover',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: screenSize.width / 20),
                      InkWell(
                        onTap: () {},
                        child:const Text(
                          'Contact Us',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
               
            /*  Text(
                'DonangHufp ',
                style: GoogleFonts.architectsDaughter(
                    textStyle: const TextStyle(fontSize: 28)),
              ), 
                           InkWell(
                        onTap: () {},
                        child: const Text(
                          'Discover',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(width: screenSize.width / 20),
                      InkWell(
                        onTap: () {},
                        child:const Text(
                          'Contact Us',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ), */
          
                             actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyLoginPage()));
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.resolveWith(getColor),    
                     splashFactory:  NoSplash.splashFactory, 
                      overlayColor: MaterialStateProperty.all(Colors.transparent)
                  ), 
                  
                  child: Text(
 
                    ' Log in',
                    style: GoogleFonts.architectsDaughter(
                        textStyle: const TextStyle(fontSize: 28, 
                        
                        )),
                  ),
                )
              ], 
                )
              ],
            ) 
          ) 
        ) 
      ) 
         
    ); 

  }
}
