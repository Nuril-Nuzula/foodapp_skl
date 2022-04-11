
class Meal {
   String? idMeal;
   String? strMeal;
   String? strInstructions;
   String? strMealThumb;
   String? strCategory;

  Meal({
     this.idMeal,
     this.strCategory,
     this.strInstructions,
     this.strMeal,
     this.strMealThumb,
});

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
    idMeal: json["idMeal"],
    strMeal: json['strMeal'],
    strInstructions: json['strInstructions'],
    strMealThumb: json['strMealThumb'],
    strCategory: json['strCategory']
  );

  Map<String, dynamic> toJson() => {
    "idMeal": idMeal,
    "strInstructions": strInstructions,
    "strMeal": strMeal,
    "strCategory": strCategory,
    "strMealThumb": strMealThumb
  };

  void setFavoriteId(String id) {
    idMeal = id;
  }
}


