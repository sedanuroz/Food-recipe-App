import 'package:flutter/material.dart';
import 'dart:convert'; // JSON verisini decode etmek için
import 'package:flutter/services.dart' as rootBundle; // JSON dosyasını okumak için
import 'package:yemek_dunyasi/screens/importantMetods/YemekDetayları.dart'; // Detay sayfası widget'ı
import 'package:yemek_dunyasi/screens/importantMetods/HeaderMethod.dart'; // Yeni import


//Flutter'da dinamik bir ekran oluşturmak için StatefulWidget kullanır.
class Corbalar extends StatefulWidget {
  @override
  _CorbalarState createState() => _CorbalarState();
}

class _CorbalarState extends State<Corbalar> {
  List<dynamic> corbalar = []; // JSON'dan veri alacağız
  bool isLoading = true;

  // JSON dosyasını yükleme fonksiyonu
  //JSON dosyasını okur ve veriyi decode eder.
  Future<void> loadJson() async {
    final String response = await rootBundle.rootBundle.loadString('assets/baslangicler/corbalar/corbalar.json');
    final data = json.decode(response); // JSON verisini decode et(veriyi okunabilir hale getir bir list yaptı aslında)
    setState(() {
      corbalar = data; // JSON verisini listeye at
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
      body: SafeArea(//içerikleri göstermek için kullanılan bir widget'tır.  tasma vs olmasın diye yaptık
        child: Column(
          //her satırın genişliği ekranın tamamı olması için yaptık(çaprazlamasına genişletir)
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Başlık (Header)
            HeaderMethod(
              title: "ÇORBALAR",
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
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: corbalar.length,
                itemBuilder: (context, index) {
                  var corba = corbalar[index];
                  return Card(
                    color: Color(0xFFb1d1b7), // Arka plan rengini #81b8a8 olarak ayarladık
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(//listeler için kullanılan widget
                      leading: Container(//leading parametresi listenin basında gosterilecek oegeyı belirtir
                        width: 100, // Yeni boyutlar
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(corba['image_url']),
                            fit: BoxFit.cover, // Resmi kapsayacak şekilde boyutlandırma
                          ),
                        ),
                      ),
                      title: Text(
                        corba['name'],
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "${corba['calories'][0]['calorie']}",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      onTap: () {
                        // Detay sayfasını göster
                        navigateToYemekDetaylari(
                          context: context,
                          item: corba,
                          imageField: 'image_url',
                          nameField: 'name',
                          ingredientField: 'ingredient',
                          caloriesField: 'calories',
                          recipeField: 'recipe',
                          type: 'baslangic_corbalar', // Kullanıcı listesine eklemek için tip
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
