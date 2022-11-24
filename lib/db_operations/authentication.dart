import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';



Future<bool> delegationIdExists(String? delID) async {
  bool exists = false;
  await FirebaseFirestore.instance
  .collection('delegations')
  .where('Delegation ID', isEqualTo: delID)
  .get()
  .then((value) {
    value.docs.forEach((docs) {
      if (docs.exists) {
        exists = true;
      }
    });
  });
  return exists;
}

Future<bool> verifyPassword(String? delID, String? password) async {
  bool valid = false;
  await FirebaseFirestore.instance
  .collection('delegations')
  .where('Delegation ID', isEqualTo: delID)
  .get()
  .then((value) {
    value.docs.forEach((docs) {
      if (docs.exists) {
        String? fetchedPassword = docs["Password"];
        if (password == fetchedPassword) {
          valid = true;
        }
      }
    });
  });
  return valid;
}

void Login(String delID) {
  var _myBox = Hive.box('IGNITE_APP_DATABASE');
  _myBox.put('LOGGED_IN_DEL_ID', delID);
}

void Logout() {
  var _myBox = Hive.box('IGNITE_APP_DATABASE');
  _myBox.put('LOGGED_IN_DEL_ID', null);
}

String? getDelID() {
  var _myBox = Hive.box('IGNITE_APP_DATABASE');
   return _myBox.get('LOGGED_IN_DEL_ID');
}

Future<String> getDelGroup(String delID) async {
  await FirebaseFirestore.instance
  .collection('delegations')
  .where('Delegation ID', isEqualTo: delID)
  .get()
  .then((value) {
    value.docs.forEach((docs) {
      if (docs.exists) {
        return docs["Group"];
      }
    });
  });
  return '';
}