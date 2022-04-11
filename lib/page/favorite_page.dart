import 'package:flutter/material.dart';
import 'package:foodapp_skl/database/db_helper.dart';
import 'package:foodapp_skl/ui/list_meals.dart';
import 'package:foodapp_skl/model/response_filter.dart';

class FavoritePage extends StatefulWidget {
  final int indexNav;

  const FavoritePage({Key? key, required this.indexNav}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int currentIndex = 0;
  String category = "Seafood";
  ResponseFilter? responseFilter;
  bool isLoading = true;
  var db = DBHelper();

  void fecthDataMeals() async {
    var data = await db.gets(category);
    setState(() {
      responseFilter = ResponseFilter(meals: data);
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fecthDataMeals();
    currentIndex = widget.indexNav;
  }

  @override
  Widget build(BuildContext context) {
    var listNav = [listMeals(responseFilter), listMeals(responseFilter)];
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Recipe"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: isLoading == false
            ? listNav[currentIndex]
            : CircularProgressIndicator(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightBlueAccent,
        currentIndex: currentIndex,
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: "Seafood"),
          BottomNavigationBarItem(icon: Icon(Icons.cake), label: "Dessert"),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
            index == 0 ? category = "Seafood" : category = "Dessert";
          });
          fecthDataMeals();
        },
      ),
    );
  }
}
