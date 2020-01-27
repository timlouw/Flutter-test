import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> get getUser => _auth.currentUser();
  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;
  
  Future<FirebaseUser> login(String userEmail, String userPassword) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: userEmail, password: userPassword);
      print(result);
      return result.user;
    } catch (e) {
      print(e);
      return e;
    }

  } // Log User in with email and password and return Firebase User


  Future<FirebaseUser> googleLogin() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );
      AuthResult result = await _auth.signInWithCredential(credential);
      print(result);
      return result.user;
    } catch (e) {
      print(e);
      return e;
    }
  } // Log User in with google account and return Firebase User


  Future<void> logOut() async {
    return _auth.signOut();
  } // Log User out


}