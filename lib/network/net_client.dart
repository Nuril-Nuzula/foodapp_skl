import 'dart:convert';
import 'package:foodapp_skl/model/response_filter.dart';
import 'package:http/http.dart';

class NetClient{
  String url = 'https://www.themealdb.com/api/json/v1/1/';
  late String endPoint;

  Future<ResponseFilter?> fetchDataMeals(int currentIndex) async{
    if (currentIndex == 0){
      endPoint = 'filter.php?c=Seafood';
    }else{
      endPoint = 'filter.php?c=Dessert';
    }
    try{
      var res = await get(Uri.parse(url+ endPoint));
      if(res.statusCode == 200){
        Map<String, dynamic>json = jsonDecode(res.body);
        ResponseFilter data = ResponseFilter.fromJson(json);
        return data;
      }else{
        return null;
      }
    }catch(e){
      print(e);
      return null;
    }
  }
}