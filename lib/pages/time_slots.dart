import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../db_operations/authentication.dart';


class TimeSlots extends StatelessWidget {
  final String tvc_set_name;
  
  const TimeSlots({super.key, required this.tvc_set_name});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tvc_set_name,
        ),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tvc_sets')
        .doc("Green Screen Room")
        .collection("Group ${getDelGroup(getDelID()!)}")
        .where("Owned By", isEqualTo: "")
        .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(doc.id),
                    
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