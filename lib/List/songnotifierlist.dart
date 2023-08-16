import 'package:flutter/material.dart';
import 'package:musicon/model/playlistmodel.dart';
import 'package:musicon/model/songsmodel.dart';



ValueNotifier<List<Songsmodel>> allsongnotifierlist = ValueNotifier([]);

ValueNotifier<List<Songsmodel>> favoritelistnotifier = ValueNotifier([]);

ValueNotifier<List<Songsmodel>> recentlistnotifier = ValueNotifier([]);

ValueNotifier<List<Songsmodel>> mostplayedlistnotifier = ValueNotifier([]);

List<Playlistmodel> playlistnotifier = [];

List<Songsmodel> newplaylistnotifier = [];

List templist = [];



int number = 0;

