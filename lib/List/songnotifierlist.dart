import 'package:flutter/material.dart';
import 'package:musicon/model/playlistmodel.dart';
import 'package:musicon/model/songsmodel.dart';



ValueNotifier<List<Songsmodel>> allsongnotifierlist = ValueNotifier([]);

ValueNotifier<List<Songsmodel>> favoritelistnotifier = ValueNotifier([]);

ValueNotifier<List<Songsmodel>> recentlistnotifier = ValueNotifier([]);

ValueNotifier<List<Songsmodel>> mostplayedlistnotifier = ValueNotifier([]);

ValueNotifier<List<Playlistmodel>> playlistnotifier = ValueNotifier([]);

ValueNotifier<List<Songsmodel>> newplaylistnotifier = ValueNotifier([]);

List templist = [];



int number = 0;

