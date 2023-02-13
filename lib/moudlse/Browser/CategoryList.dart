
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movise/models/Categoryt.dart';
import 'package:movise/models/MoviesModel1.dart';
import 'package:movise/moudlse/Browser/Catigoryitem.dart';
import 'package:movise/shared/network/remote/api_manager.dart';

class CategoryView extends StatelessWidget {
  static const String routeName='CategoryView';

  @override
  Widget build(BuildContext context) {
    Genres genres = ModalRoute.of(context)!.settings.arguments as Genres;
    return  Scaffold(
      appBar: AppBar(
        title: Text("${genres.name}"),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<MoviesModel1>(
        future: ApiManager.getCategoryView("${genres.id}"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text(snapshot.data?.status_message?? "");
          }
          var results = snapshot.data?.results ?? [];
          return ListView.builder(
            itemBuilder: (context, index) => CategoryItem(results[index]),
            itemCount: results.length,
          );;
        },
      ),
    );
  }
}
