import 'dart:convert';
import 'package:flutter/services.dart'; // Assets dosyasını okumak için
import 'package:yemek_dunyasi/screens/bottom_bars_choises/favorite/meal.dart';

class MealMatcher {
  // Verilen userMealList, jsonFileName ve type parametrelerine göre yemekleri döndüren fonksiyon
  Future<List<Meal>> getMeals(List<int> userMealList, String jsonFileName, String type) async {
    List<Meal> meals = [];

    // JSON dosyasını assets'tan okuma
    String jsonString = await rootBundle.loadString(jsonFileName);
    List<dynamic> jsonData = jsonDecode(jsonString);

    // JSON'daki her yemek verisini kontrol etme
    for (var item in jsonData) {
      if (userMealList.contains(item['id'])) {
        // Calories listesini oluşturma
        List<Calorie> calories = (item['calories'] as List)
            .map((calorieJson) => Calorie.fromJson(calorieJson))
            .toList();

        // JSON'dan Meal nesnesi oluşturma
        Meal meal = Meal(
          id: item['id'],
          name: item['name'],
          ingredient: item['ingredient'],
          calories: calories, // Calories bilgisi
          recipe: item['recipe'],
          imageUrl: item['image_url'],
          type: type, // Type parametre olarak ekleniyor
          isFavorite:1,

        );

        meals.add(meal); // Meal'i listeye ekleme
      }
    }

    return meals; // Oluşturulan Meal listesini döndürme
  }
}
