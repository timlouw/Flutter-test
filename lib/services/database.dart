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
    callable.call().then((e) => {
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





  // tempcreate80() {
  //   final batch = db.batch();
  //   for( var i = 0 ; i < 81; i++) {
  //     var doc = db.collection('users80').document(i.toString());
  //     batch.setData(doc, {
  //       'OnlyWebUser': true, 
  //       'Email': null, 
  //       'HideEthnic': false, 
  //       'HideNationalService': false, 
  //       'ClickviewLicense': 123, 
  //       'PermissionLevel': null, 
  //       'ADUsername': null, 
  //       'MobilePassword': 'a', 
  //       'HideDeptofLabor': false, 
  //       'DefaultUser': true, 
  //       'Administrator': true, 
  //       'HideManpower': false, 
  //       'ExtID': null, 
  //       'LastLoggedOut': null, 
  //       'HideBreadwinner': false, 
  //       'LockBreadwinner': false, 
  //       'HideReligion': false, 
  //       'Password': 'a', 
  //       'LockEthnic': false,
  //       'AccountLocked': false, 
  //       'CompanyNum': 'SDTN01', 
  //       'OnlyRptUser': 0, 
  //       'AuditLogTemplateCode': 'All', 
  //       'LockNationalService': false, 
  //       'ChipnPinSent': {}, 
  //       'LoginRetryCount': 0, 
  //       'ThemeName': 'Default', 
  //       'ActivationKey': null, 
  //       'TemplateCode': 'ESS_A', 
  //       'PathID': null, 
  //       'LastLoggedIn': {}, 
  //       'ChipnPin': 40239, 
  //       'AutoLogin': false, 
  //       'Username': 'CEO', 
  //       'LockReligion': false, 
  //       'EmployeeNum': 'S0059', 
  //       'SessionID': null
  //     }, merge: true);
  //   }
  //   batch.commit().then((e) => {
  //     print('finished batch')
  //   }).catchError((error) => {
  //     print(error)
  //   });
  // }


  // tempcreate1000() {
  //   final batch1 = db.batch();
  //   final batch2 = db.batch();
  //   final batch3 = db.batch();
  //   final batch4 = db.batch();
  //   for( var i = 0 ; i < 251; i++) {
  //     var doc1 = db.collection('users1000').document(i.toString());
  //     var doc2 = db.collection('users1000').document((i + 250).toString());
  //     var doc3 = db.collection('users1000').document((i + 500).toString());
  //     var doc4 = db.collection('users1000').document((i + 750).toString());
  //     batch1.setData(doc1, {
  //       'OnlyWebUser': true, 
  //       'Email': null, 
  //       'HideEthnic': false, 
  //       'HideNationalService': false, 
  //       'ClickviewLicense': 123, 
  //       'PermissionLevel': null, 
  //       'ADUsername': null, 
  //       'MobilePassword': 'a', 
  //       'HideDeptofLabor': false, 
  //       'DefaultUser': true, 
  //       'Administrator': true, 
  //       'HideManpower': false, 
  //       'ExtID': null, 
  //       'LastLoggedOut': null, 
  //       'HideBreadwinner': false, 
  //       'LockBreadwinner': false, 
  //       'HideReligion': false, 
  //       'Password': 'a', 
  //       'LockEthnic': false,
  //       'AccountLocked': false, 
  //       'CompanyNum': 'SDTN01', 
  //       'OnlyRptUser': 0, 
  //       'AuditLogTemplateCode': 'All', 
  //       'LockNationalService': false, 
  //       'ChipnPinSent': {}, 
  //       'LoginRetryCount': 0, 
  //       'ThemeName': 'Default', 
  //       'ActivationKey': null, 
  //       'TemplateCode': 'ESS_A', 
  //       'PathID': null, 
  //       'LastLoggedIn': {}, 
  //       'ChipnPin': 40239, 
  //       'AutoLogin': false, 
  //       'Username': 'CEO', 
  //       'LockReligion': false, 
  //       'EmployeeNum': 'S0059', 
  //       'SessionID': null
  //     });
  //     batch2.setData(doc2, {
  //       'OnlyWebUser': true, 
  //       'Email': null, 
  //       'HideEthnic': false, 
  //       'HideNationalService': false, 
  //       'ClickviewLicense': 123, 
  //       'PermissionLevel': null, 
  //       'ADUsername': null, 
  //       'MobilePassword': 'a', 
  //       'HideDeptofLabor': false, 
  //       'DefaultUser': true, 
  //       'Administrator': true, 
  //       'HideManpower': false, 
  //       'ExtID': null, 
  //       'LastLoggedOut': null, 
  //       'HideBreadwinner': false, 
  //       'LockBreadwinner': false, 
  //       'HideReligion': false, 
  //       'Password': 'a', 
  //       'LockEthnic': false,
  //       'AccountLocked': false, 
  //       'CompanyNum': 'SDTN01', 
  //       'OnlyRptUser': 0, 
  //       'AuditLogTemplateCode': 'All', 
  //       'LockNationalService': false, 
  //       'ChipnPinSent': {}, 
  //       'LoginRetryCount': 0, 
  //       'ThemeName': 'Default', 
  //       'ActivationKey': null, 
  //       'TemplateCode': 'ESS_A', 
  //       'PathID': null, 
  //       'LastLoggedIn': {}, 
  //       'ChipnPin': 40239, 
  //       'AutoLogin': false, 
  //       'Username': 'CEO', 
  //       'LockReligion': false, 
  //       'EmployeeNum': 'S0059', 
  //       'SessionID': null
  //     });
  //     batch3.setData(doc3, {
  //       'OnlyWebUser': true, 
  //       'Email': null, 
  //       'HideEthnic': false, 
  //       'HideNationalService': false, 
  //       'ClickviewLicense': 123, 
  //       'PermissionLevel': null, 
  //       'ADUsername': null, 
  //       'MobilePassword': 'a', 
  //       'HideDeptofLabor': false, 
  //       'DefaultUser': true, 
  //       'Administrator': true, 
  //       'HideManpower': false, 
  //       'ExtID': null, 
  //       'LastLoggedOut': null, 
  //       'HideBreadwinner': false, 
  //       'LockBreadwinner': false, 
  //       'HideReligion': false, 
  //       'Password': 'a', 
  //       'LockEthnic': false,
  //       'AccountLocked': false, 
  //       'CompanyNum': 'SDTN01', 
  //       'OnlyRptUser': 0, 
  //       'AuditLogTemplateCode': 'All', 
  //       'LockNationalService': false, 
  //       'ChipnPinSent': {}, 
  //       'LoginRetryCount': 0, 
  //       'ThemeName': 'Default', 
  //       'ActivationKey': null, 
  //       'TemplateCode': 'ESS_A', 
  //       'PathID': null, 
  //       'LastLoggedIn': {}, 
  //       'ChipnPin': 40239, 
  //       'AutoLogin': false, 
  //       'Username': 'CEO', 
  //       'LockReligion': false, 
  //       'EmployeeNum': 'S0059', 
  //       'SessionID': null
  //     });
  //     batch4.setData(doc4, {
  //       'OnlyWebUser': true, 
  //       'Email': null, 
  //       'HideEthnic': false, 
  //       'HideNationalService': false, 
  //       'ClickviewLicense': 123, 
  //       'PermissionLevel': null, 
  //       'ADUsername': null, 
  //       'MobilePassword': 'a', 
  //       'HideDeptofLabor': false, 
  //       'DefaultUser': true, 
  //       'Administrator': true, 
  //       'HideManpower': false, 
  //       'ExtID': null, 
  //       'LastLoggedOut': null, 
  //       'HideBreadwinner': false, 
  //       'LockBreadwinner': false, 
  //       'HideReligion': false, 
  //       'Password': 'a', 
  //       'LockEthnic': false,
  //       'AccountLocked': false, 
  //       'CompanyNum': 'SDTN01', 
  //       'OnlyRptUser': 0, 
  //       'AuditLogTemplateCode': 'All', 
  //       'LockNationalService': false, 
  //       'ChipnPinSent': {}, 
  //       'LoginRetryCount': 0, 
  //       'ThemeName': 'Default', 
  //       'ActivationKey': null, 
  //       'TemplateCode': 'ESS_A', 
  //       'PathID': null, 
  //       'LastLoggedIn': {}, 
  //       'ChipnPin': 40239, 
  //       'AutoLogin': false, 
  //       'Username': 'CEO', 
  //       'LockReligion': false, 
  //       'EmployeeNum': 'S0059', 
  //       'SessionID': null
  //     });
  //   }
  //   batch1.commit().then((e) => {
  //     print('finished batch1'),
  //     batch2.commit().then((e) => {
  //       print('finished batch2'),
  //       batch3.commit().then((e) => {
  //         print('finished batch3'),
  //         batch4.commit().then((e) => {
  //           print('finished batch4')
  //         }).catchError((error) => {
  //           print('failed batch4'),
  //           print(error)
  //         })
  //       }).catchError((error) => {
  //         print('failed batch3'),
  //         print(error)
  //       })
  //     }).catchError((error) => {
  //         print('failed batch2'),
  //       print(error)
  //     })
  //   }).catchError((error) => {
  //     print('failed batch1'),
  //     print(error)
  //   });
  // }
}
