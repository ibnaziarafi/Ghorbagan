import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/color.dart';


class WaterIns extends StatefulWidget {
  const WaterIns({Key? key}) : super(key: key);

  @override
  _WaterInsState createState() => _WaterInsState();
}

class _WaterInsState extends State<WaterIns> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leadingWidth: 40,
        title: Text("How to water your plant", style: TextStyle(color: tabcolor1, fontSize: 23, fontWeight: FontWeight.bold),),

      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("BEFORE YOU WATER:",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              Text("it will be be good to feel the soil to see if it really needs water. Touch the surface of the soil with your fingers, if it feels dry then its the proper time to water it. however, if it feels wet, watering is not necessary today, and please give it a test the next day.There are several ways to water your plant - they aren’t very picky. Choose a way that suits you the best: "),
              const SizedBox(height: 8,),
              Text("WATER OVER THE SOIL:",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              Text("1. Pour water over the soil, using, for example, a watering can or put the plant directly under a tap\n 2. Continue adding water to the pot until it starts to run out from the drainage holes\n 3. If you have a tray under the pot when watering, make sure you remove all the collected water afterwards - never let your plant sit in water\n 4. If you watered under a tap make sure that water has stopped running out from the bottom before putting it back."),
              const SizedBox(height: 8,),
              Container(
                height: MediaQuery.of(context).size.width*0.5,
                decoration: BoxDecoration(
                  color: lightGreen,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider("https://www.gardeningknowhow.com/wp-content/uploads/2008/05/water-plants.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8,),
              Text("BOTTOM WATERING:",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              Text("1. Fill the plant tray with water\n 2. Make sure the soil is in contact with the water on the tray\n 3. Wait for about 10 minutes\n 4. Feel the soil to see if it absorbed enough water —&gt; if the soil is moist throughout, remove any excess water from the tray\n 5. If it’s still dry —&gt; add more water to the tray\n 6. Wait 20 more minutes before removing the excess "),
              const SizedBox(height: 8,),
              Container(
                height: MediaQuery.of(context).size.width*0.5,
                decoration: BoxDecoration(
                  color: lightGreen,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider("https://plantcaretoday.com/wp-content/uploads/LHF-51863-Bottom-Watering-Potted-Plants-t1-min.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8,),
              Text("NOTE:",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              Text("Bottom watering will not wash away salts and other minerals from the soil, so make sure to also give water over the soil every now and then."),
              const SizedBox(height: 8,),
              Text("WATER BATH:",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              Text("1. Fill a bucket or any other vessel with lukewarm water\n 2. Lower the whole pot down in the water, stop where the stem of the plant starts. Make sure\n all of the soil is under water\n 3. The water will now start to bubble - wait until it stopped\n 4. Lift the pot up and let the excess drain off\n 5. Put your plant back in the cachepot or on the tray\n 6. After 1 hour, check that your plant isn’t standing in water, if it is it might get overwatered and rot "),




            ],
          ),
        ),
      ),
    );
  }
}
