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
      resizeToAvoidBottomInset: false,
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
                textAlign: TextAlign.center,
                onChanged: (value) {
                 search(value);
                },
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),fillColor: Colors.white,filled: true)
              ),
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(15),
                child:searchlist.isNotEmpty ? ListView.separated(
                  itemBuilder: (context, index) {
                  final data = searchlist[index];
                  return Songlistbar(data: data, context: context, index: index, songlist: searchlist);
                  // songbar(data, context,index,searchlist);
                }, 
                  separatorBuilder: (context, index) => const SizedBox(height: 15,), 
                  itemCount: searchlist.length):
                  Center(child: headtext('No Songs'))
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
    });
    
  }
}