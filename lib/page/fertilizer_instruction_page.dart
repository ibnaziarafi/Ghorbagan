import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../core/color.dart';

class FertilizerIns extends StatefulWidget {
  const FertilizerIns({Key? key}) : super(key: key);

  @override
  _FertilizerInsState createState() => _FertilizerInsState();
}

class _FertilizerInsState extends State<FertilizerIns> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leadingWidth: 40,
        title: Text("Houseplant fertilizer", style: TextStyle(color: tabcolor1, fontSize: 23, fontWeight: FontWeight.bold),),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5,),
              Text("Houseplants wilt when they need water. Their leaves grow pale and lanky when they aren’t getting enough sunlight. When the humidity is too low, they turn crispy; when it’s too high, they may develop rot. But, knowing when your houseplants need to be fertilized is far trickier. There’s no clear signal from your plant that shouts “Hey, it’s time to feed me!”, other than perhaps slowed or stagnant growth, which for many houseplant parents, is barely noticed."),

              const SizedBox(height: 5,),
              Text("So, instead of waiting for a signal from the plant, you’ll have to take matters into your own hands and use houseplant fertilizer on a schedule that’s based on their growing cycle.",
                style: TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 5,),
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
                    image: CachedNetworkImageProvider("https://gardenplannerwebsites.azureedge.net/blog/fertilizer-tomatoes-2x.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8,),
              Text("Each specific houseplant has slightly different needs when it comes to houseplant fertilizer amounts and frequency, but there’s no need to overly complicate the process. Yes, you could study up on each individual houseplant species you care for, determining its specific nutritional needs, but the truth is that the vast majority of common houseplants have fertilizer requirements that are similar enough that treating them in a singular way is more than enough to satisfy their nutritional needs. Some houseplants are heavier feeders than others, it’s true. But, a houseplant fertilizer schedule like the one found below, offers a good balance that both satisfies heavy feeders and keeps you from going overboard with those houseplants that require lower amounts of fertilizer."),
              const SizedBox(height: 5,),
              Text("Here’s the best fertilizer schedule for most common houseplants. It’s based on the cycle of the growing season, which, though they are inside where temperatures are more consistent, influences houseplants much the same way it influences outdoor plants. "),

              const SizedBox(height: 8,),
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
                    image: CachedNetworkImageProvider("https://i0.wp.com/savvygardening.com/wp-content/uploads/2019/01/houseplant_fertilizer_featured.jpg?fit=657%2C360&ssl=1"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8,),
              Text("Summer houseplant fertilization schedule:",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              Text("1. Liquid fertilizers are applied more frequently, bi-weekly or monthly, for example.\n2. Granular products are used less frequently, perhaps once every month or two.\n3.  Slow-release houseplant fertilizers break down slowly and release their nutrients in small amounts, over a longer period of time. A single application of most of these products lasts for three to four months."),
              const SizedBox(height: 8,),
              Text("Winter houseplant fertilization schedule:",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              Text("Houseplants are not in a state of active growth during the winter and therefore should not be fertilized. Doing so can lead to fertilizer burn and brown leaf tips (more on why this happens here)."),
              const SizedBox(height: 5,),
              Text("Two exceptions to these rules:",
                style: TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              Text("1. If you live in a climate that does not receive regular winter frosts, continue to fertilize houseplants all winter long, but do it at half the strength and frequency of your summer applications. Again, this is due to light levels more than temperatures.\n2. And, if you live in a tropical climate, where it’s warm all the time, keep your houseplants on a summer fertilization schedule year-round."),
              const SizedBox(height: 8,),
              Text("Liquid houseplant fertilizer:",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              Text("They need to be used a bit more frequently than granular fertilizer, but organic liquid houseplant fertilizers are my personal favorites. Brands like Grow!, Espoma’s Indoor Houseplants, Liquid Love, and Jobes Water-soluable All-Purpose Fertilizer contain ingredients derived from plants and animals, as well as from mined minerals. Liquid fertilizers also come with a reduced risk of fertilizer burn. Another benefit of using liquid fertilizers made from naturally-occurring ingredients is that in addition to providing a houseplant with nutrients, they also act as growth enhancers. They are full of dozens of micronutrients, trace elements, vitamins, amino acids, and plant hormones, each of which plays a vital role in the health and vigor of your houseplants."),
              const SizedBox(height: 5,),
              Text("Organic liquid houseplant fertilizers are made from liquid kelp, fish emulsion, compost tea, worm tea, liquid bone meal, rock phosphate, plant extracts, and humic acids, to name just a few."),



            ],
          ),
        ),
      ),
    );
  }
}
