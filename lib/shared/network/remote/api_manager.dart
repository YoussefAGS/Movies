import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:movise/models/Categoryt.dart';
import 'package:movise/models/MoviesModel1.dart';

import '../../constant/constant.dart';

class ApiManager {
  static Future<MoviesModel1> getSourcesTopRated() async {
    //GET https://newsapi.org/v2/top-headlines/sources?apiKey=API_KEY
    // https://api.themoviedb.org/3/movie/popular?api_key=6423e3347885127eb9a644d8cf478411&language=en-US&page=1
    var URL = Uri.https(BASE, '/3/movie/popular',
        {"api_key": ApiKey});
    try {
      Response sources = await http.get(URL);
      var json = jsonDecode(sources.body);
      MoviesModel1 moviseModel1 = MoviesModel1.fromJson(json);
      return moviseModel1;
    } catch (e) {
      throw e;
    }
}
  static Future<MoviesModel1> getSourcesPopular() async {
    //GET https://newsapi.org/v2/top-headlines/sources?apiKey=API_KEY
    // https://api.themoviedb.org/3/movie/popular?api_key=6423e3347885127eb9a644d8cf478411&language=en-US&page=1
    var URL = Uri.https(BASE, '/3/movie/top_rated',
        {"api_key": ApiKey});
    try {
      Response sources = await http.get(URL);
      var json = jsonDecode(sources.body);
      MoviesModel1 moviseModel1 = MoviesModel1.fromJson(json);
      return moviseModel1;
    } catch (e) {
      throw e;
    }

  }
  static Future<MoviesCaregory> getCategory() async {
    https://api.themoviedb.org/3/genre/movie/list?api_key=6423e3347885127eb9a644d8cf478411&language=en-US
    var URL = Uri.https(BASE, '/3/genre/movie/list',
        {"api_key": ApiKey});
    try {
      Response sources = await http.get(URL);
      var json = jsonDecode(sources.body);
      MoviesCaregory caregory = MoviesCaregory.fromJson(json);
      return caregory;
    } catch (e) {
      throw e;
    }

  }
  static Future<MoviesModel1> getUpComing() async {
    https://api.themoviedb.org/3/movie/upcoming?api_key=6423e3347885127eb9a644d8cf478411&language=en-US&page=1
   var URL = Uri.https(BASE, '/3/movie/upcoming',
        {"api_key": ApiKey});
    try {
      Response sources = await http.get(URL);
      var json = jsonDecode(sources.body);
      MoviesModel1 moviseModel1 = MoviesModel1.fromJson(json);
      return moviseModel1;
    } catch (e) {
      throw e;
    }

  }
  static Future<MoviesModel1> getCategoryView(String id) async {
    https://api.themoviedb.org/3/discover/movie?api_key=6423e3347885127eb9a644d8cf478411&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate
    https://api.themoviedb.org/3/discover/movie?api_key=6423e3347885127eb9a644d8cf478411&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate

    var URL = Uri.https(BASE, '/3/discover/movie',
        {"api_key": ApiKey,
          'with_genres':id,
        },

    );
    try {
      Response sources = await http.get(URL);
      var json = jsonDecode(sources.body);
      print(json);
      MoviesModel1 moviseModel1 = MoviesModel1.fromJson(json);
      return moviseModel1;
    } catch (e) {
      throw e;
    }
  }
  //https://api.themoviedb.org/3/movie/{movie_id}/similar?api_key=6423e3347885127eb9a644d8cf478411&language=en-US&page=1
  static Future<MoviesModel1> getMoviesSimilar(String Id) async {

    var URL = Uri.https(BASE, '/3/movie/${Id}/similar',
        {"api_key": ApiKey});
    try {
      Response sources = await http.get(URL);
      var json = jsonDecode(sources.body);
      MoviesModel1 moviesDetails = MoviesModel1.fromJson(json);
      return moviesDetails;
    } catch (e) {
      throw e;
    }
  }
  static Future<Results> getMoviesDetails(String Id) async {
    https://api.themoviedb.org/3/movie/{movie_id}?api_key=6423e3347885127eb9a644d8cf478411&language=en-US

    var URL = Uri.https(BASE, '/3/movie/${Id}',
        {"api_key": ApiKey});
    try {
      Response sources = await http.get(URL);
      var json = jsonDecode(sources.body);
      Results moviesDetails = Results.fromJson(json);
      return moviesDetails;
    } catch (e) {
      throw e;
    }
  }






  // static Future<Results> getData({String? sourceId}) async {
  //   var URL = Uri.https(
  //       BASE, '/3/movie/popular',
  //       {"apiKey": ApiKey,
  //         "sources": sourceId,}
  //   );
  //   Response response = await http.get(URL);
  //   var json = jsonDecode(response.body);
  //   Results newsDataModel = Results.fromJson(json);
  //   return newsDataModel;
  // }
  static Future<MoviesModel1> getSearchMovies(String? query) async{
    var response = await http.get(Uri.parse('https://$BASE/3/search/movie?api_key=$ApiKey&language=en-US&query=$query&page=1'));
    var json = jsonDecode(response.body);
    MoviesModel1 categoryModel = MoviesModel1.fromJson(json);
    return categoryModel;
  }



}
