import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movise/moudlse/home%20screen/MoviseItem.dart';
import 'package:movise/shared/network/local/firebase.dart';

import '../../models/MoviesModel1.dart';
class TopRated extends StatelessWidget {
  List<Results> results;
  String title;
  TopRated(this.results,this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff282A28),
        padding: EdgeInsets.all(10),
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_,index)=>Divider(
                  color:Colors.transparent,
                  indent: 5,
                  endIndent: 5,
                  thickness: 0.2,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: results.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: (){
                    DatabaseUtils.AddMoviesToFirebase(results[index]);
                  },
                    child: MoviesItem(results[index])
                ),
              ),
            )
          ],
        )

        // child: Stack(
        //   children: [
        //     Container(
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(50)),
        //       child: Image.network(
        //         'https://image.tmdb.org/t/p/w500${results.posterPath}',
        //         fit: BoxFit.cover,
        //         height: height * 0.70,
        //         width: width * 0.35,
        //       ),
        //     ),
        //     Positioned(
        //         top: 0,
        //         left: 0,
        //         child: Image.asset('assets/images/bookmark.png')
        //     )
        //   ],
        // )
        ,
      );
  }
}
