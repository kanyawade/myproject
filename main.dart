import 'package:flutter/material.dart';
import 'package:project/loginscreen/register.dart';
import 'MusicList/musicapi.dart';
import 'appbardesign/appbarstlye.dart';

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
              backgroundColor: Colors.redAccent,
              title: const Text('FristRoute '),
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
                        return Colors.greenAccent;
                      }
                      return Colors.white;
                    })),
                    child: const Text(
                      'Log in '
                      ) 
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
            const DrawerHeader(
                decoration: BoxDecoration( 
                  color: Colors.redAccent
                  ),
                child: Text(
                  ' Header'
                  )
                  ),
            ListTile(
              leading: const Icon(
                Icons.music_note
                ),
              title: const Text(
                ' music list'
                ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondRoute()));
              },
            )
          ],
        ),
      ),
    );
  }
}
