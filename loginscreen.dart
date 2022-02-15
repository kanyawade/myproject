import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
import 'register.dart';
import 'profile.dart';
   
class Login extends StatefulWidget {
    static const routeName = '/login';
  
    const Login({Key? key}) : super(key: key);
   
    @override
    State<StatefulWidget> createState() {
        return _LoginState();
    }
}
   
class _LoginState extends State<Login> {
    late final SharedPreferences prefs;
   
    // สร้างฟอร์ม key หรือ id ของฟอร์มสำหรับอ้างอิง
    final _formKey = GlobalKey<FormState>();
 
    // กำหนดตัวแปรรับค่า
    final _email = TextEditingController();
    final _password = TextEditingController();
  
    @override
    void initState() {
      super.initState();
      loadSettings();
    }
 
    void loadSettings() async {
      prefs = await SharedPreferences.getInstance();
    }    
 
    // กำหนดสถานะการแสดงแบบรหัสผ่าน
    bool _isHidden = true;    
    bool _authenticatingStatus = false;    
 
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
                title: const Text('Login'),
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
                             const SizedBox(height: 20.0,), 
                              const FlutterLogo(
                                size: 100,
                              ),
                              const Text('Login Screen'),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  icon: Icon(Icons.email_outlined),
                                ),
                                controller: _email, // ผูกกับ TextFormField ที่จะใช้
                              ), 
                              const SizedBox(height: 5.0,),                                
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  icon: const Icon(Icons.vpn_key),
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
                              const SizedBox(height: 10.0,),                                  
                              Visibility(
                                visible: !_authenticatingStatus,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // เปลี่ยนสถานะเป็นกำลังล็อกอิน
                                    setState(() {
                                      _authenticatingStatus = !_authenticatingStatus;
                                    });
                                    // จำลองการหน่วงเวลา
                                    await Future.delayed(const Duration(seconds: 3));      
                                    // อ้างอิงฟอร์มที่กำลังใช้งาน ตรวจสอบความถูกต้องข้อมูลในฟอร์ม
                                    if (_formKey.currentState!.validate()) { //หากผ่าน 
                                      // จำลองดึงข้อมูลจาก SharedPreferences
                                      String email = prefs.getString("email") ?? '';
                                      String password = prefs.getString("password") ?? '';
 
                                      // จำลองเปรียบเทียบค่า เพื่อทำการล็อกอิน  
                                      if(email == _email.text && password == _password.text){
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Login Successful')),
                                        );
                                        // กำหนดค่าให้กับ SharedPreferences จำลองล็อกอินผ่าน
                                        await prefs.setBool("loginSuccess", true);
                                        await Future.delayed(const Duration(seconds: 2));    
                                        Navigator.pop(context, true);   // ปิดหน้านี้พร้อมคืนค่า true 
                                      }else{
                                        // จำลองล็อกอินไม่ผ่าน
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Login fail..  try agin!')),
                                        );
                                        await Future.delayed(const Duration(seconds: 2));   
                                        // เปลี่ยนสถานะเป็นกำลังล็อกอิน 
                                        setState(() {
                                          _authenticatingStatus = !_authenticatingStatus;
                                        });
                                      }
                                                                      
                                    }                                
                                  },
                                  child: Container( 
                                    alignment: Alignment.center, 
                                    width: double.infinity, 
                                    child: const Text('Login'),  
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: _authenticatingStatus,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    CircularProgressIndicator(),
                                    SizedBox(width: 10.0,), 
                                    Text(" Authenticating ... Please wait")
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30.0,),   
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Or '),
                                  InkWell(
                                    child: const Text('Register', 
                                      style: TextStyle(
                                        decoration: TextDecoration.underline, 
                                        color: Colors.blue
                                      )), 
                                    onTap: () async {
                                      // เปิดหน้า สมัครสมาชิก โดย แทนที่ route ล็อกอินเดิม
                                      Navigator.pushReplacement(
                                          context, 
                                          MaterialPageRoute(builder: (context) => Register(),
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