import 'package:flutter/material.dart';
import 'package:musicon/function/function.dart';
import 'package:musicon/presentation/main/mainscreen.dart';
import 'package:musicon/presentation/widgets/widget.dart';

class Namescreen extends StatelessWidget {
   Namescreen({super.key});
  final namectr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration:const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/Background.png'),
            fit: BoxFit.cover)
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 200,
                  width: 180,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.grey),
                  child: const Icon(Icons.headphones_rounded,color: Colors.white,size: 100,),
                ),
                headtext('Enter Your Name'),
                TextField(
                  textCapitalization: TextCapitalization.words,
                  textAlign: TextAlign.center,
                  controller: namectr,
                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),filled: true,fillColor: Colors.white),),
                ElevatedButton(onPressed: (){
                  setname(namectr.text,context);
                  setbool();
                }, 
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                    )
                    )
                    ),
                    child: const Text('Submit'),
                    ),
                ElevatedButton(onPressed: (){
                  setbool();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> Mainscreen()));
                }, 
                  style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                    )
                  ),
                  ),
                  child: const Text('Skip'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}