import 'package:flutter/material.dart';
import 'package:musicon/presentation/namescreen/namescreen.dart';
import 'package:musicon/settingsshowdialog/privacydialog.dart';
import 'package:musicon/presentation/widgets/widget.dart';

class Settingscreen extends StatelessWidget {
   Settingscreen({super.key});

  
  @override
  Widget build(BuildContext context) {

    

    return  Drawer(
      

      child:SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            headtext('Settings'),

            const SizedBox(height: 20,),

         

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=> Namescreen()));
              },
              child: Row(
                  children: const[
                      SizedBox(width: 5,),
                    Icon(Icons.edit,color: Colors.white,size:35,),
                     SizedBox(width: 15,),
                    Text('Change name',style:  TextStyle(color: Colors.white,fontSize: 20),),
                    ],
                ),
            ),
            const SizedBox(height: 15,),

            InkWell(
              onTap: () {

                showAboutDialog(
                    context: context,
                    applicationName: "Musicon.",
                    applicationIcon: Image.asset(
                      "assets/musiconlogo.png",
                      height: 32,
                      width: 32,
                    ),
                    applicationVersion: "1.0.1",
                    children: [
                      const Text(
                          "Musicon is an offline music player app which allows use to hear music from their local storage and also do functions like add to favourites , create playlists , recently played , mostly played etc."),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("App developed by Arun V G")
                    ]);

                
                
              },
              child: Row(
                  children: const[
                      SizedBox(width: 5,),
                    Icon(Icons.person,color: Colors.white,size:35,),
                     SizedBox(width: 15,),
                    Text('About',style:  TextStyle(color: Colors.white,fontSize: 20),),
                    ],
                ),
            ),
            const SizedBox(height: 15,),

            InkWell(
              onTap: () {
                
              },
              child: Row(
                  children: const[
                      SizedBox(width: 5,),
                    Icon(Icons.share,color: Colors.white,size:35,),
                     SizedBox(width: 15,),
                    Text('Share',style:  TextStyle(color: Colors.white,fontSize: 20),),
                    ],
                ),
            ),
            const SizedBox(height: 15,),

            InkWell(
              onTap: () {
                showDialog(context: context, builder: (context) {
                  return privacydialoge(mdFileName: 'termsandcondition.md');
                },);
              },
              child: Row(
                  children: const[
                      SizedBox(width: 5,),
                    Icon(Icons.list_alt_sharp,color: Colors.white,size:35,),
                     SizedBox(width: 15,),
                    Text('Terms and Condition',style:  TextStyle(color: Colors.white,fontSize: 20),),
                    ],
                ),
            ),
            const SizedBox(height: 15,),

            InkWell(
              onTap: () {
                showDialog(context: context, builder: (context) {
                  return privacydialoge(mdFileName: 'privacyandpolicy.md');
                },);
              },
              child: Row(
                  children: const[
                      SizedBox(width: 5,),
                    Icon(Icons.privacy_tip,color: Colors.white,size:35,),
                     SizedBox(width: 15,),
                    Text('Privacy',style:  TextStyle(color: Colors.white,fontSize: 20),),
                    ],
                ),
            ),
            const SizedBox(height: 15,),
              
          ],
        ),
      ),
    );
  }
}