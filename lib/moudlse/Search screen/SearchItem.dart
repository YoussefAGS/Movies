
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/MoviesModel1.dart';

class SearchItem extends StatelessWidget {
  Results movie ;
  String img = 'https://image.tmdb.org/t/p/w500';
  SearchItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child:Row(
          children: [
            CachedNetworkImage(
              imageUrl: "$img${movie.posterPath}",
              imageBuilder: (context, imageProvider) => Container(
                height: MediaQuery.of(context).size.height * 0.14,
                width: MediaQuery.of(context).size.width*0.34,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Center(child: Icon(Icons.error,color: Colors.red,size: 42,)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${movie.title}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),

                    Text('${movie.releaseDate!.substring(0,4)} ',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey
                      ),
                    ),

                    Text('${movie.overview} ',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}
