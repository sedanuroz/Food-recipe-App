import 'package:flutter/material.dart';
import 'MenuGenerator.dart'; // MenuGenerator sınıfını import ettik
import 'dart:math';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}


class _MenuScreenState extends State<MenuScreen> {
  late Future<List<String>> menuFuture;

  @override
  void initState() {
    super.initState();

    String startPT = "";
    String sideDishPT = "";

    var rnd1 = Random(); // Rastgele sayı üretici
    int random1 = rnd1.nextInt(6); // 0 ile 100 arasında rastgele bir sayı
    switch (random1) {
      case 0:
        startPT = 'assets/baslangicler/corbalar/corbalar.json';
        break;
      case 1:
        startPT = 'assets/baslangicler/denizUrunleri/denızUrunler.json';
        break;
      case 2:
        startPT = 'assets/baslangicler/hamurİsleri/hamurİsleri.json';
        break;
      case 3:
        startPT = 'assets/baslangicler/mezeler/mezeler.json';
        break;
      case 4:
        startPT = 'assets/baslangicler/salatalar/salatalar.json';
        break;
      case 5:
        startPT = 'assets/baslangicler/zeytinyaglilar/zeytinyaglilar.json';
        break;
    }

    var rnd2 = Random(); // Rastgele sayı üretici
    int random2 = rnd2.nextInt(4); // 0 ile 100 arasında rastgele bir sayı

    switch (random2) {
      case 0:
        sideDishPT = 'assets/yanlezzetler/makarnalar/makarnalar.json';
        break;
      case 1:
        sideDishPT = 'assets/yanlezzetler/pilavlar/pilavlar.json';
        break;
      case 2:
        sideDishPT = 'assets/yanlezzetler/purelerVeSebzeGarniturleri/pureVeSebzeGarniturleri.json';
        break;
      case 3:
        sideDishPT = 'assets/yanlezzetler/soslarVeDipler/soslarVeDipler.json';
        break;
    }

    final menuGenerator = MenuGenerator(
      startersPath: startPT,
      mainDishesPath: 'assets/anaYemekler/anayemekler.json',
      sideDishesPath: sideDishPT,
      dessertsPath: 'assets/tatlilar/tatlilar.json',
    );

    menuFuture = menuGenerator.generateMenu();//gerekli path bilgisini menu olusturması için menu generator clasına yolladık
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F6E3),
      body: FutureBuilder<List<String>>(
        future: menuFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Hata: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Veri bulunamadı"));
          }

          final menu = snapshot.data!;//snapshot.data'nın null olmadığını garanti eder ve null değilse veriyi alır.
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left:45.0,right: 45.0,), // Padding'i biraz azaltıyoruz
              child: Table(
                border: TableBorder.all(color: Colors.black),
                columnWidths: {
                  0: FlexColumnWidth(1), // Sol sütun genişliği ayarlanabilir
                  1: FlexColumnWidth(1.2), // Sağ sütun genişliği ayarlanabilir
                },
                children: [
                  TableRow(
                    children: [
                      _buildCell('Başlangıçlar', isHeader: true),
                      _buildCell(menu[0]),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildCell('Ana Yemekler', isHeader: true),
                      _buildCell(menu[1]),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildCell('Yan Lezzetler', isHeader: true),
                      _buildCell(menu[2]),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildCell('Tatlılar', isHeader: true),
                      _buildCell(menu[3]),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //table widgeti içinde bir cell olusturmak için kullanılan bir widget
  //burada {bool isHeader = false} parametresi isimli parametredir
  // Bu, fonksiyona çağrılırken isHeader parametresinin adını kullanarak değer atayabileceğimiz anlamına gelir.
  //false deger atamamızın nedenı varsayılan olarak false olması için
  Widget _buildCell(String text, {bool isHeader = false}) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0), // Hücre içindeki padding'i küçültüyoruz
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              //false yada true olma durumuna göre yazı kalındıgı değişecek
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        )
      ),
    );
  }
}

