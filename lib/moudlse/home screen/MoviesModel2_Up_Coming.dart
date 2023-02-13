import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/MoviesModel1.dart';
class Upcoming extends StatelessWidget {
  List<Results> results;

  Upcoming(this.results);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff282A28),
      padding: EdgeInsets.all(10),
      height: 207,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'UpComing',
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
              itemBuilder: (context, index) => Container(
                width: 150,
                child: Card(
                  margin: EdgeInsets.only(bottom: 10,left: 10),
                  color: Color.fromRGBO(52, 53, 52, 1.0),
                  clipBehavior: Clip.antiAlias,
                  shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          CachedNetworkImage(
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                            imageUrl: 'https://image.tmdb.org/t/p/w500${results[index].posterPath}',
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(color: Colors.white,)),
                            errorWidget: (context, url, error) => Center(child: Icon(Icons.error,color: Colors.red,size: 42,)),
                          ),
                          Positioned(
                              top: 0,
                              left: 0,
                              child: Image.asset('assets/images/bookmark.png'))
                        ],
                      ),
                    ],
                  ),
                ),
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
