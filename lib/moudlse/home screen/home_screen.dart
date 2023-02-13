import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movise/models/MoviesModel1.dart';
import 'package:movise/moudlse/home%20screen/MoviesModel2_Up_Coming.dart';
import 'package:movise/moudlse/home%20screen/MoviesModel3_rop_rted.dart';
import '../../shared/network/remote/api_manager.dart';
import 'MoviesModel1_Poupler.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Container(
      color:  Color(0xff121312),
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<MoviesModel1>(
              future: ApiManager.getSourcesPopular(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text(snapshot.data?.status_message?? "");
                }
                var results = snapshot.data?.results ?? [];
                print(results.length);
                return CarouselSlider(
                  items: results.map((e) => PopularModel(e)).toList(),
                  options: CarouselOptions(
                    height: height*0.4,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction:1,
                    aspectRatio: 2.0,
                    initialPage: 2,
                  ),
                );
                //   Expanded(
                //             //   child: ListView.builder(
                //             //     itemBuilder: (context, index) => Image.network('https://image.tmdb.org/t/p/w500${results[index].backdropPath}'),
                //             //     itemCount: results.length,
                //             //   ),
                //             // );
              },
            ),
            SizedBox(height: 10,),
            FutureBuilder<MoviesModel1>(
              future: ApiManager.getUpComing(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text(snapshot.data?.status_message?? "");
                }
                var results = snapshot.data?.results ?? [];
                return Upcoming(results);
              },
            ),
            SizedBox(height: 10,),
            FutureBuilder<MoviesModel1>(
              future: ApiManager.getSourcesTopRated(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text(snapshot.data?.status_message?? "");
                }
                var results = snapshot.data?.results ?? [];
                return TopRated(results,'Recomended');
              },
            ),
          ],
        ),
      ),
    );
  }
}
// Container(
//   color: Black_colour,
//   child: FutureBuilder<MoviseModel2>(
//     future: ApiManager.getSourceslastes(),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(child: CircularProgressIndicator());
//       }
//       // if (snapshot.hasError) {
//       //   return Text(snapshot.data?.status_message?? "");
//       // }
//       var results = snapshot.data?.productionCompanies ?? [];
//       print(results.length);
//       return
//         Expanded(
//                     child: ListView.builder(
//                       itemBuilder: (context, index) => Image.network('https://image.tmdb.org/t/p/w500${results[index].logoPath}'),
//                       itemCount: results.length,
//                     ),
//                   );
//     },
//   ),
// ),
