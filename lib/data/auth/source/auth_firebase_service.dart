import 'package:cloud_firestore/cloud_firestore.dart';
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
      }
      return Left(message);
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

      return Left(message);
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
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithPopup(googleProvider);

      _log.info("Google sign in was successful, Here's our data : $userCredential");
      return  Right("Google sign in was successful");
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred during Google sign in';
      if (e.code == 'account-exists-with-different-credential') {
        message = 'An account already exists with a different credential';
      } else if (e.code == 'invalid-credential') {
        message = 'The credential received is malformed or has expired';
      }
      return Left(message);
    } catch (e) {
      return const Left('An unknown error occurred during Google sign in');
    }
  }

  @override
  Future<Either> loginWithFacebook() async {
    try {
      final FacebookAuthProvider facebookProvider = FacebookAuthProvider();
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithPopup(facebookProvider);

          _log.info("Facebook sign in was successful, Here's our data : $userCredential");
      return  Right("Facebook sign in was successful");
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred during Facebook sign in';
      if (e.code == 'account-exists-with-different-credential') {
        message = 'An account already exists with a different credential';
      } else if (e.code == 'invalid-credential') {
        message = 'The credential received is malformed or has expired';
      }
      return Left(message);
    } catch (e) {
      return const Left('An unknown error occurred during Facebook sign in');
    }
  }

   @override
  Future<Either> signupWithGoogle() async {
    try {
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(googleProvider);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'firstName': userCredential.user!.displayName,
        'lastName': userCredential.user!.displayName,
        'email': userCredential.user!.email,
        'userId': userCredential.user!.uid,
      });

      return const Right('Google sign up was successful');
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred during Google sign up';
      if (e.code == 'account-exists-with-different-credential') {
        message = 'An account already exists with a different credential';
      } else if (e.code == 'invalid-credential') {
        message = 'The credential received is malformed or has expired';
      }
      return Left(message);
    } catch (e) {
      return const Left('An unknown error occurred during Google sign up');
    }
  }

  @override
  Future<Either> signupWithFacebook() async {
    try {
      final FacebookAuthProvider facebookProvider = FacebookAuthProvider();
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(facebookProvider);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'firstName': userCredential.user!.displayName,
        'lastName': userCredential.user!.displayName,
        'email': userCredential.user!.email,
        'userId': userCredential.user!.uid,
      });

      return const Right('Facebook sign up was successful');
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred during Facebook sign up';
      if (e.code == 'account-exists-with-different-credential') {
        message = 'An account already exists with a different credential';
      } else if (e.code == 'invalid-credential') {
        message = 'The credential received is malformed or has expired';
      }
      return Left(message);
    } catch (e) {
      return const Left('An unknown error occurred during Facebook sign up');
    }
  }
}
