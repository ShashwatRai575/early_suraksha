import 'package:early_suraksha/models/jwt_decoder.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
//import 'package:lottie/lottie.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _loginUser() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final authToken = await fetchAuthToken(username, password);
    if (authToken != null) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Success')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage(authToken)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentication failed. Please check your credentials.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Early Suraksha',
        style: TextStyle(
          fontSize: 28
        ),),
      ),
      body: Center(
        child:
          SingleChildScrollView(
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  child: Image.network('https://firebasestorage.googleapis.com/v0/b/flutter-chat-ec3a8.appspot.com/o/user_image%2Flocation.png?alt=media&token=5f46f2d9-b6ce-40d0-94fd-397476142a6a')
                  ),
                const SizedBox(height: 50,),
                Container(
                  height: MediaQuery.of(context).size.height*0.075,
                  width: MediaQuery.of(context).size.width*0.9,
                  
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                    color: Colors.grey
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  height: MediaQuery.of(context).size.height*0.075,
                  width: MediaQuery.of(context).size.width*0.9,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                    color: Colors.grey
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height*0.07,
                  width: MediaQuery.of(context).size.width*0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: ElevatedButton(
                    onPressed: _loginUser
                    ,
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
