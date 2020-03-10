import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  var  db = Firestore.instance;
  Stream get stats => db.collection('stats').document('stats').snapshots();


  initState() {
    db.settings(persistenceEnabled: false);
  }
  
  callFunction(String callableFuncName) async {
    var startTime = DateTime.now();
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(functionName: callableFuncName);
    callable.call(<String, dynamic>{
      'SQLQuery': "select top 10 * from Users",
    }).then((e) => {
      print(e.data),
      logTimeTakenForRequest(callableFuncName, DateTime.now().difference(startTime).inMilliseconds),
    }).catchError((error) => {
      print(error)
    });
  }

  equalFirestore() async {
    var startTime = DateTime.now();
    db.collection('users80').getDocuments().then((e) => {
      logTimeTakenForRequest('equalFirestore', DateTime.now().difference(startTime).inMilliseconds)
    }).catchError((error) => {
      print(error)
    });
  }

  filledFirestore() async {
    var startTime = DateTime.now();
    db.collection('users1000').getDocuments().then((e) => {
      logTimeTakenForRequest('filledFirestore', DateTime.now().difference(startTime).inMilliseconds)
    }).catchError((error) => {
      print(error)
    });
  }


  logTimeTakenForRequest(String typeOfRequest, int timeTakenMS) {
    print(typeOfRequest + '  =  ' + timeTakenMS.toString());
    switch(typeOfRequest) {
      case 'plainCloud': { 
        db.collection('stats').document('stats').setData({
          'plainCloudTotalCalls': FieldValue.increment(1),
          'plainCloudTotalMS': FieldValue.increment(timeTakenMS)
        }, merge: true);
      } 
      break; 

      case 'sqlCloud': { 
        db.collection('stats').document('stats').setData({
          'sqlCloudTotalCalls': FieldValue.increment(1),
          'sqlCloudTotalMS': FieldValue.increment(timeTakenMS)
        }, merge: true);
      } 
      break;

      case 'sqlCloudSS': { 
        db.collection('stats').document('stats').setData({
          'sqlCloudSSTotalCalls': FieldValue.increment(1),
          'sqlCloudSSTotalMS': FieldValue.increment(timeTakenMS)
        }, merge: true);
      } 
      break;

      case 'equalFirestore': { 
        db.collection('stats').document('stats').setData({
          'equalFirestoreTotalCalls': FieldValue.increment(1),
          'equalFirestoreTotalMS': FieldValue.increment(timeTakenMS)
        }, merge: true);
      } 
      break; 

      case 'filledFirestore': { 
        db.collection('stats').document('stats').setData({
          'filledFirestoreTotalCalls': FieldValue.increment(1),
          'filledFirestoreTotalMS': FieldValue.increment(timeTakenMS)
        }, merge: true);
      } 
      break;
    }
    print('done logging time');
  }
}
