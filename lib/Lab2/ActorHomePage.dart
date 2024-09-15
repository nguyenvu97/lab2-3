import 'package:flutter/material.dart';
import 'package:labjob/Lab2/Actor.dart';

class ActorHomePage extends StatefulWidget {
  const ActorHomePage({super.key});

  @override
  State<ActorHomePage> createState() => _ActorHomePageState();
}

class _ActorHomePageState extends State<ActorHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Actor"),
      ),
      body: Column(
        children: [Flexible(child: ActorFrom())],
      ),
    );
  }
}
