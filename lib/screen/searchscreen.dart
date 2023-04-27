import 'package:flutter/material.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/model/songsmodel.dart';
import 'package:musicon/widgets/widget.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {

  late List<Songsmodel> searchlist = allsongnotifierlist.value;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: headtext('Search'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/Background.png'),
            fit: BoxFit.cover)
          ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                onChanged: (value) {
                 search(value);
                },
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),fillColor: Colors.grey,filled: true)
              ),
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(15),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                  final data = searchlist[index];
                  return songbar(data, context);
                }, 
                  separatorBuilder: (context, index) => SizedBox(height: 15,), 
                  itemCount: searchlist.length),
              )
            )
          ],
        ),
      ),
    );
  }

  search( String value){
    setState(() {
      searchlist = allsongnotifierlist.value.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();

      // searchlist = allsongnotifierlist.value.forEach((element) {

       

      // } );
    });
    
  }
}