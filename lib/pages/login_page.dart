import 'package:chat_app/component/my_textfield.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Icon(Icons.message,
          size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 50,),
          
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

         ),
          const SizedBox(height: 10,),

          // pw text field
          MyTextfield(hintText: 'Password',
            obscureText: true,

          ),
          
          // login button 
          
          //resister now
          
        ],
      ),
      )
    );
  }
}
