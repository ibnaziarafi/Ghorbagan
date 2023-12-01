class PlantF {
   String id;
   String name;
   String botanical_name;
   String imagePath;
   String category;
   String care;
   int water_winter;
   int water_summer;
   int fertilizer;
   int temp_from;
   int temp_to;
   String description;
   int price;
   bool isFavorit;
   String light;
  String toxic;

  PlantF({
     required this.id,
     required this.name,
     required this.botanical_name,
     required this.imagePath,
     required this.category,
     required this.care,
     required this.water_winter,
     required this.water_summer,
     required this.fertilizer,
     required this.temp_from,
     required this.temp_to,
     required this.description,
     required this.price,
     required this.isFavorit,
     required this.light,
     required this.toxic,
  });
}

////


class HousePlantL {
   String name;
   String botanical_name;
   String imagePath;
   String category;
   String care;
   int water_winter;
   int water_summer;
   int fertilizer;
   int temp_from;
   int temp_to;
   String light;
   String toxic;


   HousePlantL({
      required this.name,
      required this.botanical_name,
      required this.imagePath,
      required this.category,
      required this.care,
      required this.water_winter,
      required this.water_summer,
      required this.fertilizer,
      required this.temp_from,
      required this.temp_to,
      required this.light,
      required this.toxic,
   });
}

class HousePlantMy {
   var uid;
   String name;
   String botanical_name;
   String imagePath;
   String category;
   String care;
   String site;
   int water_winter;
   int water_summer;
   int fertilizer;
   int temp_from;
   int temp_to;
   String light;
   String toxic;
   String auto_taskname;
   String drain;
   String pot;
   List<dynamic> list;

   HousePlantMy({
      required this.uid,
      required this.name,
      required this.botanical_name,
      required this.imagePath,
      required this.category,
      required this.care,
      required this.site,
      required this.water_winter,
      required this.water_summer,
      required this.fertilizer,
      required this.temp_from,
      required this.temp_to,
      required this.light,
      required this.toxic,
      required this.auto_taskname,
      required this.drain,
      required this.pot,
      required this.list,
   });
}