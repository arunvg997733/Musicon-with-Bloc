import 'package:flutter/material.dart';
import 'package:musicon/screen/favouritescreen.dart';
import 'package:musicon/screen/mostplayedscreen.dart';
import 'package:musicon/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getname();
  }

  String? name1;
  int currentindex=0;

  List<String> playcard =[
    "Favourites",
    "Most played",
    "Recently played",

  ];

  List playcardnavigation = const [
    Favouritescreen(),
    Mostplayedscreen()
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/Background.png'),
            fit: BoxFit.cover)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Hello,',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
                name1 == null ? headtext(''): headtext(name1!),
                Container(
                  
                  height: 180,
                  color: Colors.transparent,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentindex =value;
                      });
                    },
                    itemCount: playcard.length,
                    itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          onTap: () {
                             Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>playcardnavigation[index]));
                            },
                          child: playbox(playcard[index],currentindex,index))),
                    ); 
                  },controller: PageController(viewportFraction: 0.5),),
                  
                )
          
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getname()async{
    final SharedPreferences name = await SharedPreferences.getInstance();
    name1 = name.getString('name');
    setState(() {
      
    });
  }
}