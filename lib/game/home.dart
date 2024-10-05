import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final User user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Home",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary, fontSize: 24),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome ${widget.user.name}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          ElevatedButton(onPressed: () {}, child: Text("Start Game"))
        ],
      ),
    );
  }
}