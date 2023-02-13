import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movise/models/MoviesModel1.dart';
import 'package:movise/moudlse/home%20screen/MoviesModel3_rop_rted.dart';
import 'package:movise/shared/network/remote/api_manager.dart';
import 'package:movise/shared/stayls/colours.dart';
import '../../../shared/network/local/firebase.dart';
class MoviesDetilsScreen extends StatefulWidget {
  static const String routeName = 'MoviesDetils';
  @override
  State<MoviesDetilsScreen> createState() => _MoviesDetilsScreenState();
}

class _MoviesDetilsScreenState extends State<MoviesDetilsScreen> {
  int isSelected=0;
  @override
  Widget build(BuildContext context) {
    Results results = ModalRoute.of(context)!.settings.arguments as Results;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if(results.DataBaseId!=null){
      isSelected=1;
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('${results.title}'),
        backgroundColor: Black_colour,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CachedNetworkImage(
                imageUrl:
                    'https://image.tmdb.org/t/p/w500${results.backdropPath}',
                width: double.infinity,
                height: height * 0.3,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image:
                        DecorationImage(image: imageProvider, fit: BoxFit.fill),
                  ),
                ),
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                )),
                errorWidget: (context, url, error) => Center(
                    child: Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 42,
                )),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${results?.title}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${results?.releaseDate}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          CachedNetworkImage(
                            width: width * 0.3,
                            height: height * 0.25,
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${results.posterPath}',
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            )),
                            errorWidget: (context, url, error) => Center(
                                child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 42,
                            )),
                          ),
                          Positioned(
                              top: 0,
                              left: 0,
                              child: InkWell(
                                  onTap: (){
                                    isSelected=1-isSelected;
                                    if(isSelected==1){
                                      DatabaseUtils.AddMoviesToFirebase(results);
                                    }
                                    else{
                                      DatabaseUtils.DeletTask('${results.DataBaseId}');
                                    }
                                    setState(() {

                                    });
                                  },

                                  child: Image.asset('assets/images/${isSelected==0?"bookmark":"bookmarkSelected"}.png')
                              )
                          )

                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Expanded(
                              //       child: ListView.builder(
                              //         scrollDirection: Axis.horizontal,
                              //         itemCount: moviesDetails?.genres?.length,
                              //           itemBuilder:(context,index)=>Container(
                              //
                              //             decoration: BoxDecoration(
                              //               borderRadius: BorderRadius.circular(8),
                              //               color: Colors.transparent,
                              //               border: Border.all(color: Colors.white)
                              //             ),
                              //             child: Text(
                              //               '${moviesDetails?.genres?[index].name}',
                              //               style: TextStyle(color: Colors.white),
                              //             ),
                              //           )
                              //       ),
                              //     ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.grey)),
                                child: Text(
                                  '${results?.genres?[0].name}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Text(
                                '${results?.overview}',
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Image.asset('assets/images/star.png'),
                                  Text('${results.voteAverage}',style:
                                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                ],
                              ),


                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            FutureBuilder<MoviesModel1>(
              future: ApiManager.getMoviesSimilar("${results.id}"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text(snapshot.data?.status_message?? "");
                }
                var result = snapshot.data?.results ?? [];
                return TopRated(result,'More Like This');
              },
            ),



          ],
        ),
      ),
    );
  }

}
