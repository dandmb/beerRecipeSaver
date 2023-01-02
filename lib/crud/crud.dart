import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class CrudOperation {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithEmail(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  signOut() async {
    return await _auth.signOut();
  }

  Future<User?> createPerson(
      String name,
      String email,
      String password,

      ) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);


    await _firestore.collection("Users").doc(user.user?.uid ?? "").set({
      'username': name,
      'email': email,
    });
    return user.user;
  }

  Future<String> addIngredient(
      String name,
      String amount,
      String ingrType,
      ) async {
    var user = _auth.currentUser?.uid ?? "";
    await _firestore
        .collection("Users")
        .doc(user)
        .collection(ingrType)
        .doc(name)
        .set({
      'name': name,
      'amount': amount,
    });
    String response="No answer";

    var collection = await _firestore.collection('Users').doc(user)
        .collection(ingrType);
    var docSnapshot = await collection.doc(name).get();

    if(docSnapshot.exists){
      response="Done successfully";
    } else{
      response="Something happened";
    }

    return response;
  }

  Stream<QuerySnapshot> getMaltData() {
    var user = _auth.currentUser?.uid ?? "";
    var ref = _firestore.collection("Users").doc(user).collection("MALT").snapshots();

    return ref;
  }
  Stream<QuerySnapshot> getHopsData() {
    var user = _auth.currentUser?.uid ?? "";
    var ref = _firestore.collection("Users").doc(user).collection("HOPS").snapshots();

    return ref;
  }
  Stream<QuerySnapshot> getYeastData() {
    var user = _auth.currentUser?.uid ?? "";
    var ref = _firestore.collection("Users").doc(user).collection("YEAST").snapshots();

    return ref;
  }
  Future<void> removeData(String docId) {
    var user = _auth.currentUser?.uid ?? "";
    var ref = _firestore.collection("Users").doc(user).collection(docId).doc(docId).delete();

    return ref;
  }

}