import 'package:flutter/material.dart';
import 'package:foodapp_skl/network/net_client.dart';
import 'package:foodapp_skl/ui/list_meals.dart';
import 'package:foodapp_skl/model/response_filter.dart';
import 'package:foodapp_skl/page/favorite_page.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  ResponseFilter? responseFilter;
  bool loading = true;

  void fetchDataMeals() async{
    try{
      NetClient client = NetClient();
      var data = await client.fetchDataMeals(currentIndex);
      setState(() {
        responseFilter = data!;
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();
    fetchDataMeals();
  }

  @override
  Widget build(BuildContext context) {
    var listNav = [
      listMeals(responseFilter),
      listMeals(responseFilter),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes App'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite_border),
              onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FavoritePage(indexNav: currentIndex);
            }));
    },
    )
        ],
      ),
      body: Center(
        child: loading == false ? listNav[currentIndex] : CircularProgressIndicator(),

      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: "Seafood" ),
          BottomNavigationBarItem(icon: Icon(Icons.cake), label: "Dessert")
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          fetchDataMeals();
        },
      ),
    );
  }
}


