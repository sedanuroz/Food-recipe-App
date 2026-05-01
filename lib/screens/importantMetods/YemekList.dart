import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;

// Yemek Detayları sayfasına yönlendiren fonksiyon
void YemekDetaylari({
  required BuildContext context,
  required Map<String, dynamic> item,//her bir yemeğin JSON verilerini temsil ediyor.
  required String imageField,//item içinde yemeğin adına karslık geeln adııbelirtecek
  required String nameField,
  required String ingredientField,
  required String caloriesField,
  required String recipeField,
  required String type,
  required int id,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0), // Body'nin etrafına padding ekler
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Yemek görseli
              Image.asset(
                item[imageField], // JSON'dan gelen görseli gösterir
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover, // Görselin tam genişlikte olması için
              ),
              SizedBox(height: 20),
              // Yemek adı
              Text(
                item[nameField], // Yemek adını gösterir
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Malzemeler
              Text(
                'Malzemeler: ${item[ingredientField]}', // Malzemeleri ekler
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              // Kalori bilgisi
              Text(
                'Kalori: ${item[caloriesField][0]['calorie']}', // Kalori bilgisini ekler
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              // Tarif
              Text(
                'Tarif: ${item[recipeField]}', // Tarif bilgisini ekler
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// Genel Yemek Listesi Widget'ı
class YemekListesi extends StatefulWidget {
  final String jsonPath; // JSON dosyasının yolu
  final String kategoriAdi; // Kategori adı
  final String imageField; // Resim alanı
  final String nameField; // İsim alanı
  final String ingredientField; // Malzeme alanı
  final String caloriesField; // Kalori alanı
  final String recipeField; // Tarif alanı

  YemekListesi({
    required this.jsonPath,
    required this.kategoriAdi,
    required this.imageField,
    required this.nameField,
    required this.ingredientField,
    required this.caloriesField,
    required this.recipeField,
  });

  @override
  _YemekListesiState createState() => _YemekListesiState();
}

class _YemekListesiState extends State<YemekListesi> {
  List<dynamic> items = []; // Yemeğin verilerini tutan liste
  bool isLoading = true; // Verilerin yüklenip yüklenmediğini kontrol eder

  // JSON dosyasını yükleme fonksiyonu
  Future<void> loadJson() async {
    final String response = await rootBundle.rootBundle.loadString(widget.jsonPath); // JSON dosyasını yükler
    final data = json.decode(response); // JSON'u çözümler
    setState(() {
      items = data; // Veriyi state'e yükler
      isLoading = false; // Yükleme işlemi tamamlandı
    });
  }

  @override
  void initState() {
    super.initState();
    loadJson(); // JSON dosyasını yükle
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: Text(widget.kategoriAdi), // Kategori adını AppBar'da gösterir
        backgroundColor: Color(0xFF326E62), // AppBar'ın rengini belirler
      ),
      */

      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Yükleniyor göstergesi
          : ListView.builder(
        itemCount: items.length, // Liste eleman sayısını belirler
        itemBuilder: (context, index) {
          var item = items[index]; // Mevcut item'ı alır

          return GestureDetector(
            onTap: () {
              // Item tıklandığında detay sayfasına git
              YemekDetaylari(
                context: context,
                item: item,
                imageField: widget.imageField,
                nameField: widget.nameField,
                ingredientField: widget.ingredientField,
                caloriesField: widget.caloriesField,
                recipeField: widget.recipeField,
                type: widget.kategoriAdi,
                id: index,
              );
            },
            child: Card(
              margin: EdgeInsets.all(10), // Kartın etrafına margin ekler
              child: Padding(
                padding: EdgeInsets.all(8.0), // Kartın etrafına padding ekler
                child: Row(
                  children: [
                    // Resim
                    Image.asset(
                      item[widget.imageField], // JSON'dan gelen görseli gösterir
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover, // Görselin düzgün görünmesi için
                    ),
                    SizedBox(width: 20),
                    // Yemek adı ve kalori
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item[widget.nameField], // Yemek adını ekler
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${item[widget.caloriesField][0]['calorie']} kalori", // Kalori bilgisini ekler
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );


  }


}
