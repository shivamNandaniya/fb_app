import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FireStoreHelper {
  FireStoreHelper._();
  static final FireStoreHelper fireStoreHelper = FireStoreHelper._();

  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  CollectionReference users = fireStore.collection("though");

  initDb() async {
    FirebaseApp app = await Firebase.initializeApp();
  }

  insertData(
      {required String date,
      required String time,
      required String though}) async {
    initDb();

    await users
        .add({
          "date": date,
          "though": though,
          "time": time,
        })
        .then((value) => print("Added"))
        .catchError((error) => print("faild"));
  }
}
