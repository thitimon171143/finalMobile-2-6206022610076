import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String name, String weight, String height, String age, String sex, String result) async {
    try {
      await firestore.collection("BMI").add({
        'name': name,
        'weight': weight,
        'height': height,
        'age': age,
        'sex': sex,
        'result': result,
        'timestamp': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("BMI").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
          await firestore.collection('BMI').orderBy('timestamp').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {
            "id": doc.id,
            "name": doc['name'],
            "weight": doc["weight"],
            "height": doc["height"],
            "age": doc["age"],
            "sex": doc["sex"],
            "result": doc["result"],
            };
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> update(String id, String name, String weight, String height, String age, String sex, String result) async {
    try {
      await firestore
          .collection("BMI")
          .doc(id)
          .update({
            'name': name,
            'weight': weight,
            'height': height,
            'age': age,
            'sex': sex,
            'result': result,
            });
    } catch (e) {
      print(e);
    }
  }
}
