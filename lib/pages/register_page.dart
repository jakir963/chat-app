import 'package:chat_app/component/my_button.dart';
import 'package:chat_app/component/my_textfield.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_services.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // email and pw text controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  // register method
  void register(BuildContext context) async {
    // get auth service
    final authService = AuthService();

    // if the passwords match, create the user
    if (_pwController.text == _confirmPwController.text) {
      try {
        await authService.signUpWithEmailPassword(
          _emailController.text,
          _pwController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }
    // if the passwords don't match, show an error
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords don't match"),
        ),
      );
    }
  }

  // Dispose of controllers to prevent memory leaks
  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _confirmPwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),

                //register image
                SizedBox(
                  height: 150, //
                  child: Image.asset('lib/icon/register.png'),
                ),
                const SizedBox(height: 50,),
                //welcome back message
                Text(
                  "Create account",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary
                  ),
                ),
                const SizedBox(height: 50,),
                // email text field
                MyTextfield(
                  hintText: 'Enter Your Email',
                  obscureText: false,
                  controller: _emailController,
                ),
                const SizedBox(height: 10,),
                // pw text field
                MyTextfield(
                  hintText: 'Password',
                  obscureText: true,
                  controller: _pwController,
                ),
                // Confirm password
                const SizedBox(height: 10,),
                MyTextfield(
                  hintText: 'Confirm Password',
                  obscureText: true,
                  controller: _confirmPwController,
                ),
                const SizedBox(height: 25,),
                // login button
                MyButton(
                  text: "Register",
                  onTap: () => register(context),
                ),
                const SizedBox(height: 25,),
                // register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login now.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}