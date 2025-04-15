import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruit/colors.dart';
import 'package:fruit/model.dart';
import 'package:fruit/product_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<String> items = [
    "assets/banners/Slider 1.png",
    "assets/banners/Slider 2.png",
    "assets/banners/Slider 3.png",
  ];

  List<CategoryModel> category = [
    CategoryModel(
        name: 'Fruits',
        image: "assets/category/fruits.png",
    ),
    CategoryModel(
      name: 'Milk & Egg',
      image: "assets/category/egg.png",
    ),
    CategoryModel(
      name: 'Bavergas',
      image: "assets/category/bavergas.png",
    ),
    CategoryModel(
      name: 'luandry',
      image: "assets/category/luandry.png",
    ),
    CategoryModel(
      name: 'luandry',
      image: "assets/category/luandry.png",
    ),
  ];

  List<ProductModel> product = [
    ProductModel(
        name: "Banana",
        image: "assets/fruits/banana.png",
        price: "3.99",
        rate: "4",
        rateCount: "287",
    ),
    ProductModel(
      name: "Papper",
      image: "assets/fruits/papper.png",
      price: "2.99",
      rate: "4",
      rateCount: "287",
    ),
    ProductModel(
      name: "Orange",
      image: "assets/fruits/orange.png",
      price: "1.99",
      rate: "4",
      rateCount: "287",
    ),
    ProductModel(
      name: "Egg",
      image: "assets/category/egg.png",
      price: "1.99",
      rate: "4",
      rateCount: "287",
    ),
  ];

  List basketList = [];

  void toggleSelection (ProductModel product) {
    setState(() {
      if(basketList.contains(product)) {
        basketList.remove(product);
      } else {
        basketList.add(product);
      }
    });
  }

  bool isSelected(ProductModel product) => basketList.contains(product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        leadingWidth: 0,
        title: Row(
          children: [
            SvgPicture.asset("assets/icons/motor.svg"),
            SizedBox(width: 10,),
            Text("61 Hopper street..",style: TextStyle(fontSize: 19)),
            SizedBox(width: 10,),
            Icon(Icons.keyboard_arrow_down_rounded,size: 34),
            Spacer(),
            SvgPicture.asset("assets/icons/basket.svg"),
          ],
        ),
      ),
      body: Column(
        children: [
          /// banner
          CarouselSlider.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                Image.asset(items[itemIndex]),
            options: CarouselOptions(
              height: 170,
              aspectRatio: 1,
              viewportFraction: 0.6,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 3),
              autoPlayCurve: Curves.linear,
              enlargeCenterPage: true,
            ),
          ),

          /// category
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(category.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle
                        ),
                        width: 70,
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(category[index].image,width: 60),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(category[index].name,style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                );
              }),
            ),
          ),

          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Fruits",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                Text("See all",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: AppColors.primary)),
              ],
            ),
          ),

          SizedBox(height: 20),

          /// products
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: List.generate(
                    product.length,
                        (index) {
                  final item = product[index];
                  return ProductItem(
                    image: item.image,
                    name: item.name,
                    rate: item.rate,
                    rateCount: item.rateCount,
                    price: item.price,
                    onTap: () => toggleSelection(item),
                    icon: isSelected(item) ? Icon(Icons.close)  : Icon(Icons.add),
                  );
                }),
              ),
            ),
          ),

          Spacer(),

          /// cart widget
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              width: double.infinity,
              height: 77,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: ListView.builder(
                          itemCount: basketList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context , index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(basketList[index].image),
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 2,
                      height: 40,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text("View Basket",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    )),
                    SizedBox(width: 10),
                    Badge(
                        backgroundColor: Colors.red,
                        label: Text( basketList.length.toString() ,style: TextStyle(fontSize: 13)),
                        largeSize: 13,
                        child: SvgPicture.asset("assets/icons/basket.svg",color: Colors.white),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }
}
