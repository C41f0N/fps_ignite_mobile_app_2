import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fps_ignite_mobile_app_2/db_operations/authentication.dart';

class ICs_Tracker extends StatefulWidget {
  const ICs_Tracker({super.key});

  @override
  State<ICs_Tracker> createState() => _ICs_TrackerState();
}

class _ICs_TrackerState extends State<ICs_Tracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          "ICs Tracker",
          style: TextStyle(
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: Text(
                    "Are you sure you want to log out?",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  actions: [

                    TextButton(
                      child: Text("Yes"),
                      onPressed: () {
                        Navigator.pop(_);
                        Navigator.pop(context);
                        Logout();
                        Navigator.pushNamed(context, '/login');
                      },
                    ),

                    ElevatedButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.pop(_);
                      },
                    ),

                  ],
                )
              );
            },
            child: Icon(
              Icons.logout,
              color: Colors.black,
              size: 20,
            ),
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Current Balance: ",
              style: TextStyle(
                color: Colors.white
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection(
                    'delegations')
                    .where("Delegation ID", isEqualTo: getDelID())
                    .limit(1)
                    .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!.docs.first["ICs"].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 100,
                          color: Colors.white,
                        ),
                      );
                    }

                    return SizedBox(
                      height: 100,
                      width: 100,
                      child: SizedBox(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(
                          
                        ),
                      )
                    );
                  }
                ),
                Text(
                  "ICs",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            //Transactions
            Container(
              color: Colors.grey[850],
              height: 300,
              width: 350,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection(
                  "transactions")
                  .where("Delegation ID", isEqualTo: getDelID())
                  .orderBy("Time", descending: true)
                  .limit(10)
                  .snapshots(),
                  
                builder: (context, snapshot) {
                  if (snapshot.hasData){
                    return ListView(
                      children: snapshot.data!.docs.map((doc) {
                         return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            height: 70,
                            width: 300,
                            child: Center(
                              child: Text(
                                doc["Amount"].toString() + ": " + doc["Description"]
                              ),
                            ),
                          ),
                        );
                      }).toList()
                    );
                  }
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: CircularProgressIndicator(),
                    )
                  );
                }
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
              child: Text("Buy TV Set Slots"),
              onPressed: () {
                Navigator.pushNamed(context, '/tvc_sets');
              },
            ),
            SizedBox(
              height: 50,
            ),
          ]

        ),
      ),

    );
  }
}