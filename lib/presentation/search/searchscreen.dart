// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicon/application/searchscreen/searchscreen_bloc.dart';
import 'package:musicon/presentation/widgets/widget.dart';

class Searchscreen extends StatelessWidget {
   Searchscreen({super.key});



  @override
  Widget build(BuildContext context) {

    context.read<SearchscreenBloc>().add(Search(text: ""));
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
                 context.read<SearchscreenBloc>().add(Search(text: value));
                },
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),fillColor: Colors.white,filled: true)
              ),
            ),
            Expanded(child: BlocBuilder<SearchscreenBloc, SearchscreenState>(
              builder: (context, state) {
                return Padding(
                          padding: const EdgeInsets.all(15),
                            child:state.searchlist.isNotEmpty ? ListView.separated(
                              itemBuilder: (context, index) {
                              final data = state.searchlist[index];
                              return Songlistbar(data: data, context: context, index: index, songlist: state.searchlist);
                            }, 
                              separatorBuilder: (context, index) => const SizedBox(height: 15,), 
                              itemCount: state.searchlist.length):
                              Center(child: headtext('No Songs'))
                          );
              },
            )
            )
          ],
        ),
      ),
    );
  }
}