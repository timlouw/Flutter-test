import 'package:cloud_functions/cloud_functions.dart';

class DatabaseService {
  testconnection() async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(functionName: 'connectANDPull');
    dynamic resp = await callable.call();
    print(resp);
  }
}
