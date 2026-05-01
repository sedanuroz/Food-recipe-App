import 'package:flutter/material.dart';
import 'dart:convert'; // JSON verisini decode etmek için
import 'package:flutter/services.dart' as rootBundle; // JSON dosyasını okumak için
import 'package:yemek_dunyasi/screens/importantMetods/YemekDetayları.dart'; // Detay sayfası widget'ı
import 'package:yemek_dunyasi/screens/importantMetods/HeaderMethod.dart'; // Yeni import

class TatlilarPage extends StatefulWidget {
  @override
  _TatlilarPageState createState() => _TatlilarPageState();
}

class _TatlilarPageState extends State<TatlilarPage> {
  List<dynamic> tatlilar = []; // JSON'dan veri alacağız
  bool isLoading = true;

  // JSON dosyasını yükleme fonksiyonu
  Future<void> loadJson() async {
    final String response = await rootBundle.rootBundle.loadString('assets/tatlilar/tatlilar.json');
    final data = json.decode(response); // JSON verisini decode et
    setState(() {
      tatlilar = data; // JSON verisini listeye at
      isLoading = false; // Veriler yüklendiğinde loading durumu false olur
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
      backgroundColor: Color(0xFFF7F6E3),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Başlık (Header)
            HeaderMethod(
              title: "TATLILAR",
              topPadding: 0.0,
              leftPadding: 30.0,
              rightPadding: 30.0,
              horizontalPadding: 15.0,
              verticalPadding: 10.0,
              fontSize: 25.0,
              borderRadius: 25.0,
              spacing: 10.0,
            ),

            // İçerik (ListView)
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: tatlilar.length,
                itemBuilder: (context, index) {
                  var tatli = tatlilar[index];
                  return Card(
                    color: Color(0xFFb1d1b7), // Arka plan rengini #81b8a8 olarak ayarladık
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: Container(
                        width: 100, // Yeni boyutlar
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(tatli['image_url']),
                            fit: BoxFit.cover, // Resmi kapsayacak şekilde boyutlandırma
                          ),
                        ),
                      ),
                      title: Text(
                        tatli['name'],
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "${tatli['calories'][0]['calorie']}",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      onTap: () {
                        // Detay sayfasını göster
                        navigateToYemekDetaylari(
                          context: context,
                          item: tatli,
                          imageField: 'image_url',
                          nameField: 'name',
                          ingredientField: 'ingredient',
                          caloriesField: 'calories',
                          recipeField: 'recipe',
                          type: "Tatlılar",
                          id: index,
                        );
                      },
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
