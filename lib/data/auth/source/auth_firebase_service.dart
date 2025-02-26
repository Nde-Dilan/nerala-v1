import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';
import 'package:other_screens/common/helpers/methods/create_username.dart';
import 'package:other_screens/data/auth/models/user_signin_req.dart';
import '../models/user_creation_req.dart';

Logger _log = Logger('AuthFirebaseImplementation.dart');

abstract class AuthFirebaseService {
  Future<Either> signup(UserCreationReq user);
  Future<Either> signin(UserSigninReq user);
  Future<Either> sendPasswordResetEmail(String email);
  Future<bool> isLoggedIn();
  Future<Either> getUser();

  Future<Either> logout();

  Future<Either> loginWithGoogle();
  Future<Either> loginWithFacebook();

  Future<Either> signupWithGoogle();
  Future<Either> signupWithFacebook();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signup(UserCreationReq user) async {
    try {
      var returnedData = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(returnedData.user!.uid)
          .set({
        'firstName': generateUsernameFromEmail(user.email!),
        'lastName': generateUsernameFromEmail(user.email!),
        'email': user.email,
        'goal': user.goal,
        'dailyGoal': user.dailyGoal,
        'learningLanguage': user.learningLanguage,
      });

      return const Right('Sign up was successfull');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      } else if (e.code == 'network-error') {
        message = 'Please check your internet connection and try again!';
      }
      return Left(message);
    } on PlatformException catch (e) {
      String message = '';
      if (e.toString().contains('network_error')) {
        _log.severe("Network error during Google sign up: $e");
        message = 'Please check your internet connection and try again!';

        return Left(message);
      }
        return Left('An unknown error occurred during Google sign in! ERROR: $e');
    } 
    
     catch (e) {
      if (e.toString().contains('network_error')) {
        String message = '';

        _log.severe("Network error during Google sign up: $e");
        message = 'Please check your internet connection and try again!';

        return Left(message);
      }
      return Left('An unknown error occurred during Google sign up: $e');
    }
  }

  @override
  Future<Either> signin(UserSigninReq user) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);
      return const Right('Sign in was successfull');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'invalid-email') {
        message = 'Not user found for this email';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for this user';
      }
      _log.info("Error message from source: $message");
      if (e.toString().contains('network_error')) {
        _log.severe("Network error during Google sign up: $e");
        message = 'Please check your internet connection and try again!';

        return Left(message);
      }
      return Left(message);
    } on PlatformException catch (e) {
      String message = '';
      if (e.toString().contains('network_error')) {
        _log.severe("Network error during Google sign up: $e");
        message = 'Please check your internet connection and try again!';

        return Left(message);
      }
        return Left('An unknown error occurred during Google sign in! ERROR: $e');
    } catch (e) {
              _log.shout("An unknown error occurred during Google sign in! ERROR: $e");

      return Left('An unknown error occurred during Google sign in! ERROR: $e');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      Future.delayed(Duration(seconds: 3000));
      var currentUser = FirebaseAuth.instance.currentUser;
      var userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .get()
          .then((value) {
        var data = value.data();
        data?['userId'] = currentUser?.uid;
        data?['image'] = currentUser?.photoURL;
        return data;
      });
      _log.info("Fetching user completed ${userData.toString()}");
      return Right(userData);
    } catch (e) {
      return const Left('Please try again');
    }
  }

  @override
  Future<Either> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return const Right('Password reset email is sent');
    } catch (e) {
      return const Left('Please try again');
    }
  }

  @override
  Future<Either> loginWithGoogle() async {
    try {
      // Initialize Google Sign In
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // If user cancels the sign in
      if (googleUser == null) {
        return const Left('Google sign in was cancelled');
      }

      // Obtain auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create credential
      final userCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      _log.info(
          "Google sign in was successful, Here's our data : $userCredential");
      return Right("Google sign in was successful");
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred during Google sign in';
      if (e.code == 'account-exists-with-different-credential') {
        message = 'An account already exists with a different credential';
      } else if (e.code == 'invalid-credential') {
        message = 'The credential received is malformed or has expired';
      }

      if (e.toString().contains('network_error')) {
        _log.severe("Network error during Google sign up: $e");
        message = 'Please check your internet connection and try again!';

        return Left(message);
      }

      return Left(message);
    } on PlatformException catch (e) {
      String message = '';
      if (e.toString().contains('network_error')) {
        _log.severe("Network error during Google sign up: $e");
        message = 'Please check your internet connection and try again!';

        return Left(message);
      }
        return Left('An unknown error occurred during Google sign in! ERROR: $e');
    } catch (e) {
      return Left('An unknown error occurred during Google sign in! ERROR: $e');
    }
  }

  @override
  Future<Either> loginWithFacebook() async {
    try {
      // Initialize Facebook Login
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status != LoginStatus.success) {
        return Left(result.message ?? 'Facebook sign in was cancelled');
      }

      // Create Firebase credential
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.tokenString);

      // Sign in with Firebase
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      _log.info("Facebook login successful: ${userCredential.user!.email}");

      return Right("Facebook sign in was successful");
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred during Facebook sign in';
      if (e.code == 'account-exists-with-different-credential') {
        message = 'An account already exists with a different credential';
      } else if (e.code == 'invalid-credential') {
        message = 'The credential received is malformed or has expired';
      }
      return Left(message);
    } on PlatformException catch (e) {
      String message = '';
      if (e.toString().contains('network_error')) {
        _log.severe("Network error during Google sign up: $e");
        message = 'Please check your internet connection and try again!';

        return Left(message);
      }
        return Left('An unknown error occurred during Google sign in! ERROR: $e');
    }  
    
    catch (e) {
      return const Left('An unknown error occurred during Facebook sign in');
    }
  }

  @override
  Future<Either> signupWithGoogle() async {
    try {
      // Initialize Google Sign In
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Start sign in flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return const Left('Google sign up was cancelled');
      }

      // Get auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'firstName': userCredential.user!.displayName,
        'lastName': userCredential.user!.displayName,
        'email': userCredential.user!.email,
        'userId': userCredential.user!.uid,
      });
      _log.info("'Google sign up was successful'");

      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred during Google sign up';
      if (e.code == 'account-exists-with-different-credential') {
        message = 'An account already exists with a different credential';
      } else if (e.code == 'invalid-credential') {
        message = 'The credential received is malformed or has expired';
      }
      return Left(message);
    } on PlatformException catch (e) {
      String message = '';
      if (e.toString().contains('network_error')) {
        _log.severe("Network error during Google sign up: $e");
        message = 'Please check your internet connection and try again!';

        return Left(message);
      }
        return Left('An unknown error occurred during Google sign in! ERROR: $e');
    } 
    
    catch (e) {
      return Left('An unknown error occurred during Google sign up $e');
    }
  }

  @override
  Future<Either> signupWithFacebook() async {
    try {
      // Initialize Facebook Login
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status != LoginStatus.success) {
        return Left(result.message ?? 'Facebook sign in was cancelled');
      }

      // Create Firebase credential
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.tokenString);

      // Sign in with Firebase
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Create/Update user document

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'firstName': userCredential.user!.displayName,
        'lastName': userCredential.user!.displayName,
        'email': userCredential.user!.email,
        'userId': userCredential.user!.uid,
      });
      _log.info("Facebook login successful: ${userCredential.user!.email}");

      return const Right('Facebook sign up was successful');
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred during Facebook sign up';
      if (e.code == 'account-exists-with-different-credential') {
        message = 'An account already exists with a different credential';
      } else if (e.code == 'invalid-credential') {
        message = 'The credential received is malformed or has expired';
      }
      return Left(message);
    } on PlatformException catch (e) {
      String message = '';
      if (e.toString().contains('network_error')) {
        _log.severe("Network error during Google sign up: $e");
        message = 'Please check your internet connection and try again!';

        return Left(message);
      }
        return Left('An unknown error occurred during Google sign in! ERROR: $e');
    }  catch (e) {
      return Left('An unknown error occurred during Facebook sign up: $e');
    }
  }

  @override
  Future<Either> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      _log.info("User logged out successfully");
      return const Right('Logout successful');
    } catch (e) {
      _log.severe("Error during logout: $e");
      return const Left('An error occurred during logout');
    }
  }
}
