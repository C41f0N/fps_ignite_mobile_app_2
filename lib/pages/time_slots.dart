import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../db_operations/authentication.dart';
import '../db_operations/tvc_sets_operations.dart';
import 'owned_time_slots.dart';


class TimeSlots extends StatelessWidget {
  final String tvc_set_name;
  final String del_group;
  
  const TimeSlots({super.key, required this.tvc_set_name, required this.del_group});
  

  @override
  Widget build(BuildContext context) {
    print("Group ${del_group}");
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tvc_set_name,
        ),
        actions: [
          TextButton(
            child: Text("See Owned", style: TextStyle(color: Colors.black),),
            onPressed: (() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => OwnedTimeSlots(tvc_set_name: tvc_set_name, del_group: del_group)));
            }),
          ),
        ],
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tvc_sets')
        .doc("Green Screen Room")
        .collection("Group ${del_group}")
        .where("Owned By", isEqualTo: "")
        .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                print(doc.id);
                return Padding(
                  padding: EdgeInsets.all(12),
                  child: ElevatedButton(
                    onPressed: () async {
                      showDialog(context: context, builder: (_) => AlertDialog(
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        title: Text("Are you sure you want to buy this slot?", style: TextStyle(color: Colors.grey[200])),
                        actions: [
                          TextButton(
                            child: Text("Yes"),
                            onPressed: (() async {
                              Navigator.pop(_);
                             bool bought = await BuyTVCSlot(
                                tvc_set_name,
                                doc.id,
                                del_group,
                              );

                              if (bought) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Purchase Successful")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Not enough ICs")));
                              }
                            }
                          ),
                          ),
                          ElevatedButton(
                            child: Text("No"),
                            onPressed: () {
                              Navigator.pop(_);
                            },
                          )
                        ],

                      ));
                      
                    },
                    child: Container(
                      height: 70,
                      child: Center(
                        child: Text(
                          doc.id,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                          ),
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