

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fps_ignite_mobile_app_2/db_operations/authentication.dart';

Future<bool> BuyTVCSlot(tvcSetName, tvcSlotTime, delGroup) async {
  // Get Cost
  var fetchedSlotDoc = await FirebaseFirestore.instance
  .collection('tvc_sets')
  .doc(tvcSetName)
  .collection("Group ${delGroup}")
  .doc(tvcSlotTime)
  .get();

  var cost = fetchedSlotDoc["Cost"];
  
  var ICs;

  // Get ICs
  await FirebaseFirestore.instance
  .collection('delegations')
  .where('Delegation ID', isEqualTo: getDelID())
  .get()
  .then((value) {
    value.docs.forEach((docs) {
      if (docs.exists) {
        ICs = docs["ICs"];
      }
    });
  });
  

  // Calculate Remaining Money
  var newICsBalance = ICs - cost;


  //Check if Remaining Money Negative
  if (newICsBalance >= 0) {

    // If not negative
    // Set OwnedBy in slot to del num
    await FirebaseFirestore.instance
    .collection('tvc_sets')
    .doc(tvcSetName)
    .collection("Group ${delGroup}")
    .doc(tvcSlotTime)
    .update({
      'Owned By': getDelID()
    });

    // Add the transaction
    await addTransaction(
      "Bought ${tvcSetName}",
      -cost,
    );

    // return True
    return true;
  } else {
    // If negative
    //return False
    return false;
  }
  
  
  
}

Future<void> addTransaction(String transactionDescription, int amountChange) async {
  // Fetch the delegate data
  var delegationDoc = await FirebaseFirestore.instance
  .collection('delegations')
  .where('Delegation ID', isEqualTo: getDelID())
  .limit(1)
  .get();

  var docId = delegationDoc.docs.first.id;
  var ICs = delegationDoc.docs.first["ICs"];

  // Calculate New Balance
  var updatedBalance = ICs + amountChange;

  // Update the db with new balance
  await FirebaseFirestore.instance
  .collection('delegations')
  .doc(docId)
  .update({
    'ICs': updatedBalance
  });

  // Register a transaction
  await FirebaseFirestore.instance
  .collection('transactions')
  .doc()
  .set({
    'Amount': amountChange,
    'Delegation ID': getDelID(),
    'Description': transactionDescription,
    "Time": DateTime.now(),
  });
}