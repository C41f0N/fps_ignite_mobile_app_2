import 'package:flutter/material.dart';

import '../db_operations/authentication.dart';
import 'ic_balance.dart';

class DelegationLoginPage extends StatefulWidget {
  DelegationLoginPage({super.key});

  @override
  State<DelegationLoginPage> createState() => _DelegationLoginPageState();
}

class _DelegationLoginPageState extends State<DelegationLoginPage> {

  final TextEditingController _delIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _DelIdError = null;
  String? _PasswordError = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "FPS IGNITE",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Center(
        child: SizedBox(
          height: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Text(
                // Welcome Text
                "Welcome.",
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 20
                ),
              ),

              // Delegation ID Input
              SizedBox(
                width: 300,
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  controller: _delIdController,
                    decoration: InputDecoration(
                      focusColor: Colors.black,
                      labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                      labelText: 'Delegation ID',
                      errorText: _DelIdError,
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        )
                      ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    ),
                    enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),

              // Password Input
              SizedBox(
                width: 300,
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  controller: _passwordController,
                    decoration: InputDecoration(
                    labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                    labelText: 'Password',
                    errorText: _PasswordError,
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.red,
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    ),
                    enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
              
              // Login Button
              ElevatedButton(
                onPressed: () async {

                  if ( await delegationIdExists(_delIdController.text)) {

                    setState(() {
                      _DelIdError = null;
                    });
                    
                    if (await verifyPassword(_delIdController.text, _passwordController.text)) {
                        
                        setState(() {
                          print("Login Successful");
                          _PasswordError = null;
                          Login(_delIdController.text);
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/ics_tracker');
                        });
                        
                      } else {
                        setState(() {
                          _PasswordError = "Incorrect Password.";
                        });
                      }

                  } else {

                    setState(() {
                      _DelIdError = "This Del ID doesnt exist.";
                    });

                  }

                },
                child: Text("Login"),
                style: ButtonStyle(

                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}