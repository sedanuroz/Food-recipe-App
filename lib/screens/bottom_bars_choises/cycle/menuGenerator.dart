import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

class MenuGenerator {
  final String startersPath;
  final String mainDishesPath;
  final String sideDishesPath;
  final String dessertsPath;

  MenuGenerator({
    required this.startersPath,
    required this.mainDishesPath,
    required this.sideDishesPath,
    required this.dessertsPath,
  });

  // Rastgele yemek seçmek için yardımcı fonksiyon
  Future<String> _getRandomDishFromJson(String assetPath) async {
    try {
      // JSON dosyasını assets'den oku
      final String jsonString = await rootBundle.loadString(assetPath);//rootBundle asset klasorune erişim saglar
      final List<dynamic> dishes = jsonDecode(jsonString);

      // Rastgele bir yemek seç
      return dishes.isNotEmpty
          ? dishes[Random().nextInt(dishes.length)]['name']//rastgele bir sayı vererek bir yemek alacağız
      //mesela 3. yemeğin namei [3][name ] seklınde yaptık bundan dolayı
          : "Veri bulunamadı"; // 'name' yemek adını varsayıyoruz
    } catch (e) {
      return "Hata: $e";
    }
  }

  // Menü oluşturma metodu
  Future<List<String>> generateMenu() async {
    String starterDish = await _getRandomDishFromJson(startersPath);
    String mainDish = await _getRandomDishFromJson(mainDishesPath);
    String sideDish = await _getRandomDishFromJson(sideDishesPath);
    String dessert = await _getRandomDishFromJson(dessertsPath);

    return [
      starterDish, // Başlangıçlar yemek adını döndür
      mainDish,    // Ana yemek adını döndür
      sideDish,    // Yan yemek adını döndür
      dessert,     // Tatlı yemek adını döndür
    ];
  }
}