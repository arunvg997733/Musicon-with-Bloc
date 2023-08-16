import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/application/favourite/favourite_bloc.dart';
import 'package:musicon/presentation/widgets/widget.dart';

class Favouritescreen extends StatelessWidget {
  const Favouritescreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: headtext('Favourites'),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,)),
        actions: [
          IconButton(onPressed: () {
            
          }, icon: const Icon(Icons.search,color: Colors.white,))
        ],
      ),
      body:Container(
        width: double.infinity,
        decoration:const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/Background.png'),
            fit: BoxFit.cover)
          ),
        child: BlocBuilder<FavouriteBloc, FavouriteState>(
          builder: (context, state) {
            return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: state.favouritelist.isNotEmpty?ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final data = state.favouritelist[index];
                      return songbar2(data,context,index,favoritelistnotifier.value);
                      
                    }, 
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 15,);
                    }, 
                    itemCount: state.favouritelist.length):
                    Center(child: headtext('No Songs')),
                );
          },
        )
      )
    );
  }



}