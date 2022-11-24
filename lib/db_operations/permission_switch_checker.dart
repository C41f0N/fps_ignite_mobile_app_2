

import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkPermissionSwitch(String permissionName) async {
  var fetchedDoc = await FirebaseFirestore.instance
  .collection('permission_switches')
  .doc(permissionName)
  .get();

  return fetchedDoc['Allowed'];
}