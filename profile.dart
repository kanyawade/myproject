import 'package:flutter/material.dart';
import 'package:project/loginscreen/loginscreen.dart';

//import 'package:project/loginscreen/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
 

class Profile extends StatefulWidget {
   static const routeName = '/profile';
  const Profile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget>createState() { 
    return  _ProfileState();
  }
}

class _ProfileState extends State<Profile > {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance(); 
  late bool loginSucess; 

  @override 
  void initState() {

    super.initState(); 
    loadSetting();
  } 
  void loadSetting()async{ 
    final SharedPreferences prefs =await _prefs; 
    loginSucess =prefs.getBool('loginsucess')??false;
  } 
  Future<bool>getLoginStatus() async{
    final SharedPreferences prefs =await _prefs; 
    loginSucess = prefs.getBool('loginSucess')??false; 
    return loginSucess;
  } 
  @override 
  void dispose() {
   
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(  
        title: const Text('Login Page'),
      ) ,
        body: FutureBuilder<bool>( 
              future: getLoginStatus(), // ข้อมูล Future
              builder: (context, snapshot) { 
                if (snapshot.hasData) { 
                  return Center(
                    child: Stack(
                        
                        children: <Widget>[
                           const Text('Profile Screen'),
                            Visibility( // ส่วนที่แสดงกรณีล็อกอินแล้ว
                              visible: loginSucess, // ใช้สถานะการล็อกอินกำหนดกรแสดง
                              child: Row(
                                children: [
                                  const FlutterLogo(size: 100,),
                                  const Text('Welcome member'),
                                  ElevatedButton(
                                    onPressed: () async { // เมื่อล็อกเอาท์
                                      // ใช้งานข้อมูล SharedPreferences
                                      final SharedPreferences prefs = await _prefs;
                                      await prefs.remove("loginSuccess"); // ลบค่าที่บันทึก
                                      setState(() {
                                        loginSucess = false;
                                      });                      
                                    }, 
                                    child: const Text('Logout'),
                                  ),        
                                ],
                              ),
                            ),
                            Visibility( // ส่วนที่แสดงกรณียังไม่ได้ล็อกอิน
                              visible: !loginSucess, // ใช้สถานะตรงข้ามการล็อกอินกำหนดกรแสดง
                              child: ElevatedButton(
                                onPressed: () async {
                                  // กำหดให้รอค่า หลังจากเปิดไปหน้า lgoin
                                  final result = await Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (context) =>const Login (),
                                      settings: const RouteSettings(
                                        arguments: null
                                      ),
                                    ),
                                  );    
                                  // ถ้ามีการปิดหน้มที่เปิด และส่งค่ากลับมาเป็น true
                                  if (result == true) {
                                    setState(() {
                                      loginSucess = true;
                                    });  
                                  }
                                               
                                }, 
                                child: const Text('Go to Login'),
                              ),
                            ),
                        ],
                    )
                );
                } else if (snapshot.hasError) { // ถ้ามี error
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),  
    );
  }
}