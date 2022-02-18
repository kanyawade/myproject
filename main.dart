import 'package:flutter/material.dart';
import 'package:project/loginscreen/register.dart';
import 'MusicList/musicapi.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 100.0),
        child: ClipPath(
          clipper: WaveClip(),
          child: Container(
            padding: EdgeInsets.zero,
            width: MediaQuery.of(context).size.width,
            child: AppBar(
              backgroundColor: Colors.black,
              title:  Text('DonangHufp ' ,
               style: GoogleFonts.shizuru(),
              ),
              actions: [
/*                 Expanded(
                  
                  child: Container( 
                    decoration:BoxDecoration( 
                      shape: BoxShape.rectangle, 
                      border: Border.all( 
                        color: Colors.black26
                        
                      )
                    ),
                   
                  )
                  ), */
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyLoginPage()));
                  },
                  style: ButtonStyle(foregroundColor:
                      MaterialStateProperty.resolveWith(
                          (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Colors.yellow;
                    }
                    return Colors.white;
                  })),
                  child: Text(
                    'Login',
                    style: GoogleFonts.shizuru(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              child: Text(
                'Home',
                style: GoogleFonts.shizuru(
                  textStyle:
                      const TextStyle(color: Colors.yellow),
                      fontSize: 30.0
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.music_note),
              title:TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SecondRoute ()));
                  },
                  style: ButtonStyle(foregroundColor:
                      MaterialStateProperty.resolveWith(
                          (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Colors.yellow;
                    }
                    return Colors.black;
                  })),
                  child: Text(
                    'Music List',
                    style: GoogleFonts.shizuru(),
                  ),
                ),
              
            )
          ],
        ),
      ),
    );
  }
}
