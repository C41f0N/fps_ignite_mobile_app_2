import 'package:flutter/material.dart';

class DelegationLoginPage extends StatelessWidget {
  const DelegationLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _delIdController = TextEditingController();
    TextEditingController _passwordController = TextEditingController(); 
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
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                  labelText: 'Delegation ID',
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
            )

            // Password Input

            // Login Button

          ],
        ),
      ),
    );
  }
}