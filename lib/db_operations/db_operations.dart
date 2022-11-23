import 'package:cloud_firestore/cloud_firestore.dart';



Future<bool> delegationIdExists(String delID) async {
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