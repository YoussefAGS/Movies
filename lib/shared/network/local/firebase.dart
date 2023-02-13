import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/MoviesModel1.dart';

class DatabaseUtils {
  static CollectionReference<Results> getMoviesCollection() {
    return FirebaseFirestore.instance
        .collection("Results")
        .withConverter<Results>(
            fromFirestore: (snapshot, option) =>
                Results.fromJson(snapshot.data()!),
            toFirestore: (value, option) => value.toJson());
  }
  static Future<void> AddMoviesToFirebase(Results results) {
    var collection=getMoviesCollection();
    var docref=collection.doc();
    results.DataBaseId=docref.id;
    return docref.set(results);
  }
  static Stream<QuerySnapshot<Results>> readMoviesFormFirebase2()  {
    return getMoviesCollection().snapshots();
  }
  static Future<QuerySnapshot<Results>> readUserFormFirebase(num id) async {
    var user =  await getMoviesCollection().where('id',isEqualTo: id).get();
    return user;
  }
  static Future<void> DeletTask(String id) {
    return getMoviesCollection().doc(id).delete();

  }
}
