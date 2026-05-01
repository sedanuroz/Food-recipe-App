import 'package:flutter/material.dart';
import 'package:yemek_dunyasi/screens/importantMetods/HeaderMethod.dart'; // Başlık için method
import 'package:yemek_dunyasi/aboutUsers/dbHelper.dart';
import 'package:yemek_dunyasi/aboutUsers/users.dart';
import 'package:yemek_dunyasi/screens/bottom_bars_choises/favorite/meal.dart';
import 'package:yemek_dunyasi/screens/bottom_bars_choises/favorite/mealFinder.dart';
import 'package:yemek_dunyasi/screens/bottom_bars_choises/favorite/yemekDetayları.dart'; // Detay sayfası widget'ı

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Meal> favoriteMeals = []; // Favori yemeklerin listesi
  bool isLoading = true; // Verilerin yüklenip yüklenmediğini kontrol etmek için

  // Veritabanından favori yemekleri yükleme fonksiyonu
  Future<void> loadFavoriteMeals() async {
    try {
      User? user = await DbHelper().getLoggedInUser(); // Kullanıcı bilgilerini al

      if (user != null) {
        MealMatcher mm = MealMatcher();
        List<Meal> allMeal = [];
        List<Meal> meal;

        meal = await mm.getMeals(user.baslangiclar_corbalarList, "assets/baslangicler/corbalar/corbalar.json", "baslangic_corbalar");
        allMeal.addAll(meal);
        meal = await mm.getMeals(user.baslangiclar_denizUrunleriList, "assets/baslangicler/denizUrunleri/denızUrunler.json", "baslangic_denizUrunleri");
        allMeal.addAll(meal);
        meal = await mm.getMeals(user.baslangiclar_hamurIsleriList, "assets/baslangicler/hamurİsleri/hamurİsleri.json", "baslangic_hamurIsleri");
        allMeal.addAll(meal);
        meal = await mm.getMeals(user.baslangiclar_mezelerList, "assets/baslangicler/mezeler/mezeler.json", "baslangic_mezeler");
        allMeal.addAll(meal);
        meal = await mm.getMeals(user.baslangic_salatalarList, "assets/baslangicler/salatalar/salatalar.json", "baslangic_salatalar");
        allMeal.addAll(meal);
        meal = await mm.getMeals(user.baslangiclar_zeytinyaglilarList, "assets/baslangicler/zeytinyaglilar/zeytinyaglilar.json", "baslangic_zeytinyaglilar");
        allMeal.addAll(meal);
        meal = await mm.getMeals(user.anaYemeklerList, "assets/anaYemekler/anayemekler.json", "Ana Yemekler");
        allMeal.addAll(meal);
        meal = await mm.getMeals(user.yanLezzetler_makarnalarList, "assets/yanlezzetler/makarnalar/makarnalar.json", "yanLezzet_makarnalar");
        allMeal.addAll(meal);
        meal = await mm.getMeals(user.yanLezzetler_pilavlarList, "assets/yanlezzetler/pilavlar/pilavlar.json", "yanLezzet_pilavlar");
        allMeal.addAll(meal);
        meal = await mm.getMeals(user.yanLezzetler_sebzeVEPureList, "assets/yanlezzetler/purelerVeSebzeGarniturleri/pureVeSebzeGarniturleri.json", "yanLezzet_sebzeVEPure");
        allMeal.addAll(meal);
        meal = await mm.getMeals(user.yanLezzetler_soslarVeDiplerList, "assets/yanlezzetler/soslarVeDipler/soslarVeDipler.json", "yanLezzet_soslarVeDipler");
        allMeal.addAll(meal);
        meal = await mm.getMeals(user.fastFoodList, "assets/fastfood/fastfood.json", "Fast-Food");
        allMeal.addAll(meal);
        meal = await mm.getMeals(user.kahvaltiliklerList, "assets/kahvaltilikler/kahvaltilikler.json", "Kahvaltılıklar");
        allMeal.addAll(meal);
        meal = await mm.getMeals(user.tatlilerList, "assets/tatlilar/tatlilar.json", "Tatlılar");
        allMeal.addAll(meal);

        setState(() {
          favoriteMeals = allMeal; // Eşleşen yemekleri favorilere ekle
        });
      }
    } catch (e) {
      print("Favori yemekler yüklenirken hata oluştu: $e");
    } finally {
      setState(() {
        isLoading = false; // Yükleme tamamlandı
      });
    }
  }

  Future<void> favoriteState(Meal meal) async {
    //favori iken favoriden kaldırdık
    User? user = await DbHelper().getLoggedInUser();
    if(user!=null){
      await DbHelper().removeMealFromTheSpesificList(user, meal);
      loadFavoriteMeals();
    }
  }


  //listenin içindeki kalp butonuiçin yapıs oldugum fonksiyon
  Future<void> confirmRemoveFavorite(Meal meal) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Favoriden Kaldır'),
          content: Text('Bu yemeği favorilerden kaldırmak istediğinize emin misiniz?'),
          actions: <Widget>[
            TextButton(
              child: Text('Hayır'),
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
              },
            ),
            TextButton(
              child: Text('Evet'),
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
                favoriteState(meal); // Yemek favorilerden kaldırılacak user nesnesine ait olan listeden kaldırılacak
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadFavoriteMeals(); // Sayfa yüklenirken favori yemekleri getir
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F6E3),
      body: SafeArea(
        child: Column(
          //Button, TextField veya diğer bileşenlerin tam genişlikte görünmesini sağlamak için
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Başlık (Header)
            HeaderMethod(
              title: "FAVORİ YEMEKLER",
              topPadding: 0.0,
              leftPadding: 20.0,
              rightPadding: 20.0,
              horizontalPadding: 15.0,
              verticalPadding: 10.0,
              fontSize: 25.0,
              borderRadius: 25.0,
              spacing: 0.0,
            ),
            SizedBox(height: 10), // Başlık ile içerik arası boşluk

            // İçerik (ListView)
            Expanded(
              child: isLoading// bu  durum true ise circular olsun
                  ? Center(child: CircularProgressIndicator()) // Yükleniyor göstergesi
              //false ise ve favorite meal bos ise de
                  : favoriteMeals.isEmpty
              //ekranda yazı yazssın
                  ? Center(
                child: Text(
                  "Henüz favori yemeğiniz yok!",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )

              //o da false ise yanı listede yemek var ise
                  : ListView.builder(
                //bu listeyi ekranda göstermeliyiz
                itemCount: favoriteMeals.length,
                itemBuilder: (context, index) {
                  var favoriteMeal = favoriteMeals[index];
                  int isFavorite = favoriteMeal.isFavorite; // Favori durumunu kontrol et

                  return Card(
                    color: Color(0xFFb1d1b7), // Kartın arka plan rengi
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    // bir liste içeriği olusturalım ListTİle ile yapalım bunu
                    child: ListTile(
                      leading: Container(//sol taraf leading dir
                        width: 100, // Görsel boyutu
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(favoriteMeal.imageUrl), // Görsel yolu
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(//orta title
                        favoriteMeal.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(//altında syubtitle
                        "${favoriteMeal.calories[0].calorie}", // Kalori
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),

                      ),
                      onTap: () async {//tıklanınca da bu kısım

                        // Yemek detaylarına git
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => YemekDetaylariPage(
                              meal: favoriteMeal,
                            ),
                          ),
                        );

                        // Geri dönüldükten sonra favori öğeleri yeniden yükle
                        await loadFavoriteMeals();
                      },

                      //sag tarafı
                      trailing: IconButton(
                        icon: Icon(
                          isFavorite == 1 ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite == 1 ? Colors.red : null,
                        ),
                        onPressed: () {
                          confirmRemoveFavorite(favoriteMeal); // Onay almak için bu fonksiyonu çağırırız
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
