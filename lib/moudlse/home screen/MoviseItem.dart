
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movise/shared/network/local/firebase.dart';

import '../../models/MoviesModel1.dart';

class MoviesItem extends StatefulWidget {
  Results results;
  MoviesItem(this.results);
  @override
  State<MoviesItem> createState() => _MoviesItemState();
}

class _MoviesItemState extends State<MoviesItem> {
  int isSelected=0;
  String imag='bookmark';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkMovieInDataBse();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 150,
      height: 250,
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
                  imageUrl: 'https://image.tmdb.org/t/p/w500${widget.results.posterPath}',
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
                    child: InkWell(
                      onTap: (){
                        isSelected=1-isSelected;
                        if(isSelected==1){
                          DatabaseUtils.AddMoviesToFirebase(widget.results);
                        }
                        else{
                          DatabaseUtils.DeletTask('${widget.results.DataBaseId}');
                        }
                        setState(() {

                        });
                      },

                        child: Image.asset('assets/images/${isSelected==0?"bookmark":"bookmarkSelected"}.png')
                    )
                )
              ],
            ),
            Row(
              children: [
                Image.asset('assets/images/star.png'),
                Text('${widget.results.voteAverage}',style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ],
            ),
            Text('${widget.results.title}',style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,maxLines: 1,),
            Text('${widget.results.releaseDate}',style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> checkMovieInDataBse ()async{
    int flag=0;
    QuerySnapshot<Results> temp= await DatabaseUtils.readUserFormFirebase(widget.results.id!);
    print(widget.results.id);
    if(temp.docs.isEmpty){
    }else{
      widget.results.DataBaseId=temp.docs[0].data().DataBaseId;
      isSelected=1;
      setState(() {
      });
      print('favorite');
    }
  }
}
