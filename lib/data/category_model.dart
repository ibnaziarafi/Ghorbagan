class Category {
  final int id;
  final String name;

  Category(this.id, this.name);
}
class Category2 {

  final String imagePath;
  final String name;
  final String lebel;

  Category2(this.imagePath,this.name, this.lebel);
}

List<Category> categories = [

  Category(0, 'Indoor'),
  Category(1, 'Outdoor'),
  Category(2, 'Garden'),

];
List<Category2> categories2 = [

  Category2('https://www.bhg.com/thmb/kek1J78_A08JQU4HyEU-nZVpfY8=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/tabletop-cactus-garden-b2686ebd-fce3d6c296864624b8c76dd376fe305a.jpg',
      'Succulent & Cactus', 'sacu'),
  Category2('https://assets.vogue.com/photos/593f05fa9d94cb14039a9e4e/master/w_2560%2Cc_limit/00-lede%2520(3).jpg',
      'Garden', 'Garden'),
  Category2('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7p6fk-EOyqf-kW2k5mptTRjbyAJii6XFuaQ&usqp=CAU',
  'Folidge', 'Folidge'),
  Category2('https://cdn.shopify.com/s/files/1/0489/5922/6015/collections/327c19851f4ff673f39ca8232f5f6844_750x.jpg?v=1618486811',
  'Herbs', 'Herbs'),
  Category2('https://www.healthyeating.org/images/default-source/home-0.0/nutrition-topics-2.0/general-nutrition-wellness/2-2-2-2foodgroups_vegetables_detailfeature.jpg?sfvrsn=226f1bc7_6',
  'vegetable', 'vegetable'),
  Category2('https://www.healthyeating.org/images/default-source/home-0.0/nutrition-topics-2.0/general-nutrition-wellness/2-2-2-2foodgroups_vegetables_detailfeature.jpg?sfvrsn=226f1bc7_6',
      'Succulent & Cactus', 'Succulent & Cactus'),



];

List<Category> categoriesDash = [
  Category(0, 'Today'),
  Category(1, 'upcoming'),

];

List<Category> overviewCat = [
  Category(0, 'Overview'),
  Category(1, 'Information'),

];
