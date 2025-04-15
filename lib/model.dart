class CategoryModel {
  final String name;
  final String image;

  CategoryModel({required this.name ,required this.image});
}


class ProductModel {
  final String name;
  final String image;
  final String price;
  final String rate;
  final String rateCount;

  ProductModel({
    required this.name,
    required this.image,
    required this.price,
    required this.rate,
    required this.rateCount,
  });
}