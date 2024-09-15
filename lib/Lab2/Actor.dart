import 'package:flutter/material.dart';
import 'package:labjob/Lab2/ActorDetails.dart';

class Actor {
  final String name;
  final String description;
  final String imageUrl;

  Actor({
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}

class ActorFrom extends StatefulWidget {
  const ActorFrom({super.key});

  @override
  State<ActorFrom> createState() => _ActorState();
}

class _ActorState extends State<ActorFrom> {
  List<Widget> listActor = [];
  GlobalKey<AnimatedListState> _listKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addActor();
    });
  }

  void addActor() {
    List<Actor> _actor = [
      Actor(
        name: 'nguyen vu',
        description: '350',
        imageUrl: 'assets/img1.jpg',
      ),
      Actor(
        name: 'Beach ',
        description: '350',
        imageUrl: 'assets/img.jpg',
      ),
      Actor(
        name: ' Paradise',
        description: '350',
        imageUrl: 'assets/images.jpeg',
      ),
      Actor(
        name: 'Beach Paradise',
        description: '350',
        imageUrl: 'assets/free-images.jpg',
      ),
    ];

    Future ft = Future(() {});

    _actor.forEach((data) {
      ft.then((_) {
        return Future.delayed(const Duration(microseconds: 200), () {
          listActor.add(_buildTile(data));
          _listKey.currentState!.insertItem(listActor.length - 1);
        });
      });
    });
  }

  Widget _buildTile(Actor actor) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ActorDetails(actor: actor)));
      },
      contentPadding: EdgeInsets.all(25),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${actor.name} ',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[300])),
          Text(actor.description,
              style: TextStyle(fontSize: 20, color: Colors.grey[600])),
          //  ListView.builder(itemBuilder: itemBuilder)
        ],
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Hero(
          tag: "image+ ${actor.name}",
          child: Image.asset(
            actor.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Tween<Offset> offset = Tween(begin: Offset(1, 0), end: Offset(0, 0));

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        key: _listKey,
        initialItemCount: listActor.length,
        itemBuilder: (context, index, animation) {
          return SlideTransition(
              position: animation.drive(offset), child: listActor[index]);
        });
  }
}
