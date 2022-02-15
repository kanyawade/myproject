import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
import 'login.dart';
   
class Register extends StatefulWidget {
    static const routeName = '/register';
  
    const Register({Key? key}) : super(key: key);
   
    @override
    State<StatefulWidget> createState() {
        return _RegisterState();
    }
}
   
class _RegisterState extends State<Register> {
    late final SharedPreferences prefs;
    
    // สร้างฟอร์ม key หรือ id ของฟอร์มสำหรับอ้างอิง
    final _formKey = GlobalKey<FormState>();
 
    // กำหนดตัวแปรรับค่า
    final _email = TextEditingController();
    final _password = TextEditingController();
 
    // กำหนดสถานะการแสดงแบบรหัสผ่าน
    bool _isHidden = true;    
    bool _registeringStatus = false;    
  
    @override
    void initState() {
      super.initState();
      loadSettings();
    }
 
    void loadSettings() async {
      prefs = await SharedPreferences.getInstance();
    }
 
    @override
    void dispose() {
      _email.dispose(); // ยกเลิกการใช้งานที่เกี่ยวข้องทั้งหมดถ้ามี
      _password.dispose(); 
      super.dispose();
    }
 
    @override
    Widget build(BuildContext context) {
   
        return Scaffold(
            appBar: AppBar(
                title: Text('Register'),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey, // กำหนด key
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              SizedBox(height: 20.0,), 
                              FlutterLogo(
                                size: 100,
                              ),
                              Text('Register Screen'),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  icon: Icon(Icons.email_outlined),
                                ),
                                controller: _email, // ผูกกับ TextFormField ที่จะใช้
                              ), 
                              SizedBox(height: 5.0,),                                
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  icon: Icon(Icons.vpn_key),
                                  suffixIcon: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        _isHidden = !_isHidden; // เมื่อกดก็เปลี่ยนค่าตรงกันข้าม
                                      });
                                    }, 
                                    icon: Icon(
                                      _isHidden // เงื่อนไขการสลับ icon
                                      ? Icons.visibility_off 
                                      : Icons.visibility
                                    ),
                                  ),
                                ),    
                                controller: _password, // ผูกกับ TextFormField ที่จะใช้                        
                                obscureText: _isHidden, // ก่อนซ่อนหรือแสดงข้อความในรูปแบบรหัสผ่าน
                              ), 
                              SizedBox(height: 10.0,),                                  
                              Visibility(
                                visible: !_registeringStatus,
                                child: ElevatedButton(
                                onPressed: () async {
                                  // เปลี่ยนสถานะกำลังสมัครสมาชิก
                                  setState(() {
                                    _registeringStatus = !_registeringStatus;
                                  });
                                  await Future.delayed(const Duration(seconds: 3));      
                                  if (_formKey.currentState!.validate()) { //หากผ่าน 
                                    // กำหนดค่าให้กับ SharedPreferences จากข้อมูลฟอร์ม
                                    await prefs.setString("email", _email.text);
                                    await prefs.setString("password", _password.text);
 
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Create new user Successful')),
                                    );
                                    await Future.delayed(const Duration(seconds: 2));   
                                    // กลับไปยังหน้าล็อกอิน 
                                    Navigator.pushReplacement(
                                        context, 
                                        MaterialPageRoute(builder: (context) => Login(),
                                          settings: RouteSettings(
                                            arguments: null
                                          ),
                                        ),
                                    );                                                                           
                                  }                                                           
                                },
                                  child: Container( 
                                    alignment: Alignment.center, 
                                    width: double.infinity, 
                                    child: const Text('Register'),  
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: _registeringStatus,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircularProgressIndicator(),
                                    SizedBox(width: 10.0,), 
                                    Text(" Registering ... Please wait")
                                  ],
                                ),
                              ),                              
                              SizedBox(height: 30.0,),   
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Already member? '),
                                  InkWell(
                                    child: Text('Login', 
                                      style: TextStyle(
                                        decoration: TextDecoration.underline, 
                                        color: Colors.blue
                                      )), 
                                    onTap: (){
                                      Navigator.pushReplacement(
                                          context, 
                                          MaterialPageRoute(builder: (context) => Login(),
                                            settings: RouteSettings(
                                              arguments: null
                                            ),
                                          ),
                                        );    
                                    },
                                  )
                                ],
                              )
                          ],
                      )
                  ),
                ),
              ),
            ),
        );
    }
}