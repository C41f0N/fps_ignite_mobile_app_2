import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fps_ignite_mobile_app_2/db_operations/authentication.dart';
import 'package:fps_ignite_mobile_app_2/pages/time_slots.dart';

class TVCSets extends StatefulWidget {
  const TVCSets({super.key});

  @override
  State<TVCSets> createState() => _TVCSetsState();
}



class _TVCSetsState extends State<TVCSets> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TVC Sets"),
        
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
        .collection("tvc_sets")
        .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map( (doc) {
                return Padding(
                  padding: EdgeInsets.all(12),
                  child: ElevatedButton(
                    onPressed: () async {
                      String? delGroup = await getDelGroup(getDelID()!);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => TimeSlots(tvc_set_name: doc.id, del_group: delGroup!,)));
                    },
                    child: Container(
                      height: 70,
                      child: Center(
                        child: Text(
                          doc.id.replaceAll('_', " "),
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
            child: CircularProgressIndicator(),
          );
        },

      )
    );
  }
}

