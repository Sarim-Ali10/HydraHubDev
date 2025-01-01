import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skindiseasedetector/views/home_screen.dart';
import '../Model/ModelSchema.dart';
import 'LoginScreen.dart';

class UserServices{
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection("userData");

  void userRegister(UserModel userModel, BuildContext context)async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userModel.userEmail!, password: userModel.userPassword);
      _collectionReference.doc(userCredential.user?.uid).set({
        "uID" : userCredential.user?.uid,
        "uName" : userModel.userName,
        "uEmail" : userModel.userEmail,
        "uPassword" : userModel.userPassword,
      });
      if(context.mounted){

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registration Successful"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
        Navigator.push(context, MaterialPageRoute(builder:  (context) => const LoginScreen(),));
      }

    } on FirebaseAuthException catch(ex){
      if(context.mounted){

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went Wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    }
  }

  void userLogin(UserModel logModel, BuildContext context)async {
    try {
     
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: logModel.userEmail!, password: logModel.userPassword);
      SharedPreferences userCred = await SharedPreferences.getInstance();
      userCred.setString("email", logModel.userEmail!);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Successful"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      Navigator.push(context, MaterialPageRoute(builder:  (context) => const HomeScreen(),));
/*
      DocumentSnapshot userDoc = await _collectionReference.doc(userCredential.user?.uid).get();
      String role = userDoc['uRole'];
      userCred.setString("role", role);
      redirectToRole(role, context);*/
    } on FirebaseAuthException catch (ex) {
      if (context.mounted) {
        
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went Wrong"),
          backgroundColor: Colors.red,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          behavior: SnackBarBehavior.floating,));
      }
    }
  }

  void redirectToRole(String role, BuildContext context) {
    if (role == 'User') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Successful"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      Navigator.push(context, MaterialPageRoute(builder:  (context) => const HomeScreen(),));
    }
    else if (role == 'Admin') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Successful"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
    //  Navigator.push(context, MaterialPageRoute(builder:  (context) => const AdminHomeScreen(),));
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Something went Wrong"),
        backgroundColor: Colors.red,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        behavior: SnackBarBehavior.floating,));    }
  }

  void userLogout(BuildContext context)async{
    await FirebaseAuth.instance.signOut();
    SharedPreferences userCred = await SharedPreferences.getInstance();
    userCred.clear();
    if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logout Successful"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
    }
  }

  void userPasswordRequest(String? email, BuildContext context)async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Check your email"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
        Navigator.pop(context);
      }
    } catch(ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
        Navigator.pop(context);
      }    }
  }

  static Future userCredGet()async{
    SharedPreferences userCred = await SharedPreferences.getInstance();
    var uEmail = userCred.getString("email");
    var uRole = userCred.getString("role");

    return {
      'email': uEmail,
      'role': uRole,
    };
  }

  Stream<List<UserModel>> getUser(String? uEmail){
    return _collectionReference.where('uEmail',isEqualTo: uEmail).snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return UserModel(
          userID: data['uID'],
          userName: data['uName'],
          userEmail: data['uEmail'],
          userPassword: data['uPassword'],

        );
      }).toList();
    });
  }
/*
  Stream<List<UserModel>> getUserByRole(String? uRole){
    return _collectionReference.where('uRole',isEqualTo: uRole).snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return UserModel(
          userID: data['uID'],
          userName: data['uName'],
          userEmail: data['uEmail'],
          userPassword: data['uPassword'],

        );
      }).toList();
    });
  }
*/
  Stream<List<UserModel>> getAllUser(){
    return _collectionReference.snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return UserModel(
          userID: data['uID'],
          userName: data['uName'],
          userEmail: data['uEmail'],
          userPassword: data['uPassword'],
        );
      }).toList();
    });
  }

  Stream<List<UserModel>> searchUser(String? searchQuery){
    return _collectionReference.snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return UserModel(
          userID: data['uID'],
          userName: data['uName'],
          userEmail: data['uEmail'],
          userPassword: data['uPassword'],
        );
      }).where((user) {
        if (searchQuery == null || searchQuery.isEmpty) {
          return true;
        } else {
          return user.userName!.toLowerCase().contains(searchQuery.toLowerCase());
        }
      }).toList();
    });
  }
/*
  void userUpdate(UserModel userModel, BuildContext context)async{
    try{
       .of<LoaderBloc>(context).add(LoadEvent(true));
      if(userModel.userImage != null){
        FirebaseStorage.instance.refFromURL(userModel.getImage!).delete();
        UploadTask uploadTask = FirebaseStorage.instance.ref().child("userImages").child(userModel.userID!).putFile(userModel.userImage!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String userImage = await taskSnapshot.ref.getDownloadURL();

        _collectionReference.doc('${userModel.userID}').update({
          "uName" : userModel.userName,
          "uRole" : userModel.userRole,
          "uImage" : userImage,
          "uAge" : userModel.userAge,
          "uGender" : userModel.userGender,
          "uPhone" : userModel.userPhone,
          "uEmail" : userModel.userEmail,
          "uPassword" : userModel.userPassword,
          "uStatus" : userModel.userStatus,
          "uCreatedAt" : userModel.createdAt
        });
        if(context.mounted){
           .of<LoaderBloc>(context).add(LoadEvent(false));
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Update Successful"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
          Navigator.pop(context);
        }
      }
      else{
        _collectionReference.doc('${userModel.userID}').update({
          "uName" : userModel.userName,
          "uRole" : userModel.userRole,
          "uImage" : userModel.getImage,
          "uAge" : userModel.userAge,
          "uGender" : userModel.userGender,
          "uPhone" : userModel.userPhone,
          "uEmail" : userModel.userEmail,
          "uPassword" : userModel.userPassword,
          "uStatus" : userModel.userStatus,
          "uCreatedAt" : userModel.createdAt
        });
         .of<LoaderBloc>(context).add(LoadEvent(false));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Update Successful"),backgroundColor: Colors.green, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
        Navigator.pop(context);
      }
    }  catch(ex){
      if(context.mounted){
         .of<LoaderBloc>(context).add(LoadEvent(false));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
      }
    }

  }
*/
  /*
  void userDelete(String? userID, String? userImage, BuildContext context)async{
    try{
      await FirebaseStorage.instance.refFromURL(userImage!).delete();
      await FirebaseAuth.instance.currentUser!.delete();
      await _collectionReference.doc(userID).delete();

      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account Deleted Successfully"),backgroundColor: Colors.red, margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
      }

    }catch(ex){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Something went wrong $ex"),backgroundColor: Colors.red, margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),behavior: SnackBarBehavior.floating,));
        Navigator.pop(context);
      }
    }
  }
*/
}