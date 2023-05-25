import 'package:flutter/material.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/db_function.dart/db_function.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/screen/favouritescreen.dart';
import 'package:musicon/screen/mostplayedscreen.dart';
import 'package:musicon/screen/recentscreen.dart';
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
    Mostplayedscreen(),
    Recentscreen()
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Hello',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w500),),
                    name1 == null ? headtext(''): headtext(name1!),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  
                  height: 170,
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
                              favouritedatabasetolist();
                             Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>playcardnavigation[index]));
                            },
                          child: playbox(playcard[index],currentindex,index))),
                    ); 
                  },controller: PageController(viewportFraction: 0.5),),
                  
                ),
              ),
          
              Center(child: headtext('Recent List')),
          
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ValueListenableBuilder(
                            valueListenable: recentlistnotifier, 
                            builder: (BuildContext ctx, List<Songsmodel> recentlist, Widget? child){
                  return recentlistnotifier.value.isNotEmpty?ListView.separated(
                  
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final data = recentlist[index];
                      return songbar3(data, context, index,recentlistnotifier.value);
                    }, 
                    separatorBuilder: (context, index) {
                      return const SizedBox( height: 15,);
                    }, 
                    itemCount: recentlist.length):
                    Center(child: headtext('No songs'));
                        
                            }),
                ),
              ),
          
              
          
            ],
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