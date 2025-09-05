import 'package:chat_app/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SETTINGS")),
      body: Container(decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),color: Theme.of(context).colorScheme.secondary),
       
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(15),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //dark mode
            const Text("Dark Mode",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            //switch toggle
            CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
              onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false,).toggleTheme(),

            )],
        ),
      ),
    );
  }
}