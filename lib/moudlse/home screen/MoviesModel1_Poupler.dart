import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movise/moudlse/home%20screen/MoviseDetilsScreen/movies_detils.dart';

import '../../models/MoviesModel1.dart';
import '../../shared/network/local/firebase.dart';

class PopularModel extends StatefulWidget {
  Results results;
  PopularModel(this.results);

  @override
  State<PopularModel> createState() => _PopularModelState();
}

class _PopularModelState extends State<PopularModel> {
  int isSelected=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkMovieInDataBse();

  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrain) {
        double width= constrain.maxWidth;
        double height= constrain.maxHeight;

        return
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, MoviesDetilsScreen.routeName,arguments: widget.results);
            },
            child: Container(
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${widget.results.backdropPath}',
                  height: height*0.7,
                  width: double.infinity,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(color: Colors.white,)),
                  errorWidget: (context, url, error) => Center(child: Icon(Icons.error,color: Colors.red,size: 42,)),
                ),
                Positioned(
                  left: width*0.05, bottom: 0,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child:
                           CachedNetworkImage(
                            imageUrl: 'https://image.tmdb.org/t/p/w500${widget.results.posterPath}',
                            imageBuilder: (context, imageProvider) => Container(
                              height: height*0.70,
                              width: width*0.35,
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
                ),
                Positioned(
                  bottom: height*0.20,
                  left: width*0.45,
                  child: Text(
                    '${widget.results.title}',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
                Positioned(
                  bottom: height*0.12,
                  left: width*0.45,

                  child: Text(
                    '${widget.results.releaseDate}',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),

              ],
            ),
        ),
          );
      }
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
