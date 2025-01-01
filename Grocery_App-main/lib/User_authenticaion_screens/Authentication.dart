import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/Utlis/Utlis.dart';

class Authentication {
  void registerUser(String email,String password)async{
    try{
        UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password);

    }on FirebaseAuthException
    catch(ex){
      Utilis().toastmessage(ex.code.toString());
    }
  }
}