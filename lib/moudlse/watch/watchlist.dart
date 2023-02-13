
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movise/models/MoviesModel1.dart';
import 'package:movise/shared/network/local/firebase.dart';
import 'package:movise/shared/stayls/colours.dart';

import '../Browser/Catigoryitem.dart';

class WatchListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Black_colour,
        title: Text('WatchList',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      body: StreamBuilder<QuerySnapshot<Results>>(
        stream: DatabaseUtils.readMoviesFormFirebase2(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // if (snapshot.hasError) {
          //   return Text(snapshot.data?.status_message?? "");
          // }
          List<Results> messages =
              snapshot.data?.docs.map((task) => task.data()).toList() ?? [];
          return  ListView.builder(
            itemCount: messages.length,
            itemBuilder: (d, index) {
              return CategoryItem(messages[index]);
            },
          );
        },
      ),
    );

  }
}
