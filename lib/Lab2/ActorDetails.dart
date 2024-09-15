import 'package:flutter/material.dart';
import 'package:labjob/Lab2/Actor.dart';

class ActorDetails extends StatefulWidget {
  Actor actor;
  ActorDetails({super.key, required this.actor});

  @override
  State<ActorDetails> createState() => _ActorDetailsState();
}

class _ActorDetailsState extends State<ActorDetails> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(microseconds: 200),
            height: media.height * 0.5,
            width: media.width * 1,
            child: Hero(
                tag: "image+ ${widget.actor.name}",
                child: Image.asset(
                  "${widget.actor.imageUrl}",
                  fit: BoxFit.cover,
                )),
          ),
          Positioned(
              top: 20,
              bottom: media.height * 0.4,
              left: 0,
              right: media.width * 0.9,
              child: Container(
                height: 50,
                width: 50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white60,
                ),
                alignment: Alignment.center,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
              )),
        ],
      ),
    );
  }
}
