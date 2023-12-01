class OrderPlant {
  String id;
  String name;
  String imagePath;
  int quantity;
  int price;
  int insideCost;
  int outsideCost;
  String sellerLoc;


  OrderPlant({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.quantity,
    required this.price,
    required this.insideCost,
    required this.outsideCost,
    required this.sellerLoc,
  });
}