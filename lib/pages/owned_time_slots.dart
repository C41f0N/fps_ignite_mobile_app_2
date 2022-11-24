import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../db_operations/authentication.dart';


class OwnedTimeSlots extends StatelessWidget {
  final String tvc_set_name;
  final String del_group;
  
  const OwnedTimeSlots({super.key, required this.tvc_set_name, required this.del_group});
  

  @override
  Widget build(BuildContext context) {
    print("Group ${del_group}");
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${tvc_set_name.replaceAll('_', ' ')}(Owned)",
        ),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tvc_sets')
        .doc(tvc_set_name)
        .collection("Group_${del_group}")
        .where("Owned_By", isEqualTo: getDelID()!)
        .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                print(doc.id);
                return Padding(
                  padding: EdgeInsets.all(12),
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    height: 70,
                    child: Center(
                      child: Text(
                        doc.id,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }
          return Center(
            child: CircularProgressIndicator()
          );
        },
      ),
    );
  }
}