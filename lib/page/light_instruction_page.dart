import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LightIns extends StatefulWidget {
  const LightIns({Key? key}) : super(key: key);

  @override
  _LightInsState createState() => _LightInsState();
}

class _LightInsState extends State<LightIns> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8,),
              Container(
                height: MediaQuery.of(context).size.width*0.5,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider("https://firebasestorage.googleapis.com/v0/b/plantv2-5b2f1.appspot.com/o/manually-upload1%2Flight-guide-drawing.jpg?alt=media&token=702bde8e-7f08-40f1-8565-a6df39966473"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8,),
              Text("Full Sun:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              const SizedBox(height: 6,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("-A sunny and bright room"),
                    Text("-For example a room that is sun drenched almost all day"),
                    Text("-East facing window"),
                    Text("-Also known as bright light, direct light"),
                  ],
                ),
              ),
              const SizedBox(height: 8,),
              Text("Part sun, part shade:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              const SizedBox(height: 6,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("-A common light for many rooms"),
                    Text("-For example a spot in the middle of a room"),
                    Text("-south north facing window"),
                    Text("-Also known as bright-indirect light, medium light"),
                  ],
                ),
              ),
              const SizedBox(height: 8,),
              Text("shade:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              const SizedBox(height: 6,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("-A dark room with little light"),
                    Text("-like a dark room or a spot far away from a window"),
                    Text("-West facing window"),
                    Text("-Also known as low light"),
                  ],
                ),
              ),
              const SizedBox(height: 8,),
              Text("Dark:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              const SizedBox(height: 6,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("-0 hour of sunlight"),
                    Text("-For example a bathroom without windows"),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
