import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_player_ui/Provider/song.dart';
import 'package:song_player_ui/View/Song_detail.dart';
import 'package:song_player_ui/View/song_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create:(context) => songProvider(),builder:(context,child)=> MaterialApp (
     debugShowCheckedModeBanner: false,
      routes:{
        '/':(context)=>HomeScreen(),
        '/song':(context)=>DetailScreen(),

      },
    ));
  }
}
