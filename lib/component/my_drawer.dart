import 'package:flutter/material.dart';


import '../pages/setting_page.dart';
import '../services/auth/auth_services.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout (){
    //get aut services
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column( mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
       Column(children: [
         //logo
         DrawerHeader(
             child: Center(child: Icon(Icons.mobile_friendly,color: Colors.blueGrey.shade500,size: 100,),)
         ),


         // home list tile
         Padding(
           padding: const EdgeInsets.only(left: 25.0),
           child: ListTile(
             title: const Text("HOME"),leading: Icon(Icons.home),
             onTap: (){
               Navigator.pop(context);
             },
           ),
         ),

         //seting list tile
         Padding(
           padding: const EdgeInsets.only(left: 25.0),
           child: ListTile(
             title: const Text("SETTINGS"),leading: Icon(Icons.settings),
             onTap: (){
               Navigator.push(context,
                   MaterialPageRoute(
                   builder: (context) => const SettingPage()
                   )
               );
             },
           ),
         ),

       ],),

        //logout list tile

        Padding(
          padding: const EdgeInsets.only(left: 20.0,bottom: 18),
          child: ListTile(
            title:  Text("LOGOUT",style: TextStyle(fontSize: 28,color: Colors.red[800]),),leading: Icon(Icons.logout_sharp,color: Colors.red[800],size: 36,),
            onTap:  logout,
          ),
        ),
      ],
      ),
    );
  }
}
