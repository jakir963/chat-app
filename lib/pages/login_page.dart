import 'package:chat_app/component/my_button.dart';
import 'package:chat_app/component/my_textfield.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_services.dart';
class LoginPage extends StatelessWidget {
  // email and pw text controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  // tap to go to resister page
  final void Function()? onTap;
   LoginPage({super.key,required this.onTap});
   //login method
  void login (BuildContext context) async{
    final authService = AuthService();
    //try login
    try {
      await authService.sinInWithEmailPassword(_emailController.text, _pwController.text);
    } //catch error
    catch (e){ showDialog(context: context, 
        builder: (context)=>AlertDialog(
          title: Text(e.toString()),
        ),
    );
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Center(

          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60,),

            // put login image
            SizedBox(
              height: 150, // FIX: Use SizedBox to control image size without affecting other widgets
              child: Image.asset('lib/icon/enter.png'),
            ),
            const SizedBox(height: 50), // Keep this space

            //welcome back massage
            Text("welcome back, you've been missed!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary
              ),
            ),
            const SizedBox(height: 50,),


            // email text field
           MyTextfield(hintText: 'Enter Your Email',
             obscureText: false,
             controller: _emailController,

           ),
            const SizedBox(height: 10,),

            // pw text field
            MyTextfield(hintText: 'Password',
              obscureText: true,
              controller: _pwController,

            ),
            const SizedBox(height: 25,),
            // login button
            MyButton(text: "Login",
            onTap: () => login(context) ,
            ),
            const SizedBox(height: 25,),

            //resister now
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Do not have account ?",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                Text(" "),
                GestureDetector(
                  onTap: onTap,
                    child: Text("Resister now.",style: TextStyle(fontWeight: FontWeight.bold),))
              ],
            )
          ],
        ),
        ),
      )
    );
  }
}
