import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/color.dart';


class SoilIns extends StatefulWidget {
  const SoilIns({Key? key}) : super(key: key);

  @override
  _SoilInsState createState() => _SoilInsState();
}

class _SoilInsState extends State<SoilIns> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leadingWidth: 40,
        title: Text("Soil For houseplants", style: TextStyle(color: tabcolor1, fontSize: 23, fontWeight: FontWeight.bold),),

      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    image: CachedNetworkImageProvider("https://plantcaretoday.com/wp-content/uploads/LHF-51988-best-soil-for-pothos-t1-min.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8,),
              Text("Key takeaways:",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              Text("1 Potting soil can provide nutrients to plants\n2 Commercial mixes often have synthetic chemicals\n3 Homemade potting soil is a better option\n4 Use organic and sustainable materials\n5 Coco coir and peat moss retain moisture and provides a quality base\n6 Vermiculite, perlite, and sand improve soil structure and moisture retention\n7 Compost and worm castings add nutrients and improves soil structure"),
              const SizedBox(height: 8,),
              Text("The single most important thing for plant life is its ability to receive nutrients and plants receive most of their nutrients from the soil. As you can imagine, your potting soil is a pretty important part of a healthy, thriving indoor plant. And with so many types of soil to choose from, it can be tricky to know where to begin when crafting your own. Get it wrong and your plants will wither and drop leaves in the complaint. To ensure your success when container gardening, you can put together your own soil for indoor plants. High-quality potting soil can be difficult to find, as commercial mixes usually have synthetic chemicals or other unwanted ingredients. A proper homemade potting soil mix will take into account the individual needs of your indoor plants, as well as prioritize the use of organic and sustainable materials (ie food scraps). "),
              const SizedBox(height: 8,),
              Text("For potted vegetables: ",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              Text("Potted vegetables and houseplants require a similar potting soil recipe, but vegetable plants will generally require more nutrition in order to properly fruit. Vegetables prefer a soil pH between 6.0 and 7.0. To encourage root growth, use the highest quality compost or fertilizer that you have access to."),
              const SizedBox(height: 8,),
              Text("Potting soil ingredients for indoor vegetables may include:",
                style: TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              Text("1 40% compost or worm castings\n2 30%  coco coir  or  peat moss\n3 15%  vermiculite\n4 15%  perlite\n5 Additional Vegetable-Specific Nutrient Amendments (optional)"),
              const SizedBox(height: 8,),
              Text("For tropical and flowering plants: ",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              Text("The combination of perlite plus coco coir or peat moss in your homemade potting mix recipe will provide the right balance of moisture and adequate drainage. Tropical plants enjoy water, but won’t grow well if their roots stay in excessive moisture. A large amount of compost or nutrients is required for lush growth and beautiful blooms."),
              const SizedBox(height: 8,),
              Text("A good potting soil mix for tropical flowering plants  may include:",
                style: TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              Text("1 35% composted bark or composted wood chips (or any quality compost that you have on hand)\n2 35% pine bark\n3 20%  perlite\n4 10%  coco coir  or  peat moss"),
              const SizedBox(height: 8,),
              Text("For seed starting: ",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              Text("Most seeds enjoy moisture, heat, and a small amount of nutrients. Coco coir and peat moss provides the moisture retention in this homemade potting mix, while a touch of compost or worm castings will provide the seeds and initial plant roots with the nutrients they need."),
              const SizedBox(height: 8,),
              Text("A homemade potting soil recipe for seed starting may include:",
                style: TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 8,),
              Text("1 75%  coco coir  or  peat moss\n2 10%  perlite\n3 10%  vermiculite\n4 5% compost, worm castings, or other organic fertilizer"),









            ],
          ),
        ),
      ),
    );
  }
}
