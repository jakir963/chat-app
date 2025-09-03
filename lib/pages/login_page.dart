import 'package:chat_app/component/my_button.dart';
import 'package:chat_app/component/my_textfield.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatelessWidget {
  // email and pw text controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
   LoginPage({super.key});
//login method
  void login (){
    // authenticate
  }

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
          onTap: login ,
          ),
          const SizedBox(height: 25,),
          
          //resister now
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Do not have account ?",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
              Text(" "),
              Text("Resister now.",style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          )
        ],
      ),
      )
    );
  }
}
