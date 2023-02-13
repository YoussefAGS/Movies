import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movise/models/MoviesModel1.dart';
import 'package:movise/shared/stayls/colours.dart';

import '../../shared/network/local/firebase.dart';

class CategoryItem extends StatefulWidget {
  Results results;
  CategoryItem(this.results);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  int isSelected=0;
  int f=1;




  @override
  Widget build(BuildContext context) {
    if(f==1){
      checkMovieInDataBse();
      f=2;
    }

    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
      decoration: BoxDecoration(
          color: Black_colour,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500${widget.results.backdropPath}' ?? "",
                height: height * 0.25,
                placeholder: (context, url) =>
                const Center(
                    child: CircularProgressIndicator(color: Colors.white,)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
              TextStyle(color: Colors.white,fontSize: 15)),
            ],
          ),
          Text(
            '${widget.results.title}',style: TextStyle(color: Colors.grey,fontSize: 20),
          ),
          Text(
            '${widget.results.overview}',style: TextStyle(color: Colors.white,fontSize: 10),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    )
    ;
  }
  Future<void> checkMovieInDataBse ()async{
    int flag=0;
    QuerySnapshot<Results> temp= await DatabaseUtils.readUserFormFirebase(widget.results.id!);
    print(widget.results.id);
    if(temp.docs.isEmpty){
    }else{
      print(temp.docs[0].data().DataBaseId);
      widget.results.DataBaseId=temp.docs[0].data().DataBaseId;
      isSelected=1;
      setState(() {
      });
      print('favorite');
    }
  }

}
