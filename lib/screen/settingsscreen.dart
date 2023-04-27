import 'package:flutter/material.dart';
import 'package:musicon/screen/namescreen.dart';
import 'package:musicon/widgets/widget.dart';

class Settingscreen extends StatelessWidget {
   Settingscreen({super.key});

  List settingslist = [
    'Change name',
    'About',
    'Share',
    'Terms and Condition',
    'Privacy',
  ];

  List settingslisticons = [
    Icons.edit,
    Icons.person,
    Icons.share,
    Icons.list_alt_sharp,
    Icons.privacy_tip,
  ];

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      

      child:SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            headtext('Settings'),

            const SizedBox(height: 20,),
      
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Namescreen()));
                    },
                    child: settingstext(settingslist[index],settingslisticons[index]));
                }, 
                separatorBuilder: (context, index) {
                  return const  SizedBox(height: 20,);
                }, 
                itemCount: settingslist.length),
            ),
          ],
        ),
      ),
    );
  }
}