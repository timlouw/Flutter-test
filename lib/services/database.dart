import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final db = Firestore.instance;

  callFunction(String callableFuncName) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(functionName: callableFuncName);
    return callable.call();
  }

  firestoreTest() async {

  }

  create() {
    final batch = db.batch();
    for( var i = 0 ; i >= 80; i++) {
      var doc = db.collection('users').document();
      // batch.setData(doc, {

      // }) 
    }
  }

}
