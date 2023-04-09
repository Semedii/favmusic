
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:favmusic/service/spotify_api.dart';
import 'package:flutter/material.dart';



class LatestMusicPage extends StatelessWidget {
   LatestMusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latest"),
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          _getList(),
           _getList(),
            _getList()
        ],
        ),
      )
    );
  }

  _getList(){
    return
        ListTile(
          title: Text('hees koobaad'),
          trailing: Icon(Icons.play_arrow),
       
    );
  }
}