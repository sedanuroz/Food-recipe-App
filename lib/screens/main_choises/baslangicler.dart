import 'package:flutter/material.dart';
import 'package:yemek_dunyasi/screens/baslangiçler/denizUrunleri.dart';
import 'package:yemek_dunyasi/screens/baslangiçler/hamurİsleri.dart';
import 'package:yemek_dunyasi/screens/baslangiçler/mezeler.dart';
import 'package:yemek_dunyasi/screens/baslangiçler/salatalar.dart';
import 'package:yemek_dunyasi/screens/baslangiçler/zeytinyaglilar.dart';
import 'package:yemek_dunyasi/screens/baslangiçler/corbalar.dart';

import '../bottom_bars_choises/main_page.dart';
import '../bottom_bars_choises/favorite/favoritePage.dart';
import '../bottom_bars_choises/note/notePage.dart';
import '../bottom_bars_choises/calculate/calculateCalPage.dart';
import '../bottom_bars_choises/cycle/cyclePage.dart';

import 'package:yemek_dunyasi/screens/importantMetods/buildingRowMethodsFor_two_Component.dart';

import 'package:yemek_dunyasi/screens/importantMetods/HeaderMethod.dart'; // Yeni import

class BaslangiclarPage extends StatefulWidget {
  @override
  _BaslangiclarPageState createState() => _BaslangiclarPageState();
}

class _BaslangiclarPageState extends State<BaslangiclarPage> {
  int _curIndex = 2; // İlk sayfa Ana Sayfa olarak belirlendi.

  // Sayfa listesi
  final List<Widget> _pages = [
    FavoritePage(),
    NotePage(),
    MainPage(),
    CalculateCalPage(),
    CyclePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F6E3),

      // Body kısmını IndexedStack ile gösteriyoruz
      body: IndexedStack(
        index: _curIndex, // Seçilen sayfayı göstermek için
        children: [
          FavoritePage(),
          NotePage(),
          _buildBaslangiclarBody(), // body kısmınız burada
          CalculateCalPage(),
          CyclePage(),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFF8F6F1),
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        currentIndex: _curIndex,
        onTap: (index) {
          setState(() {
            _curIndex = index; // Aktif sekmeyi değiştir
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/like.png', width: 30, height: 30),
            label: "Favorilerim",
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/note.png', width: 30, height: 30),
            label: "Not",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Ana Sayfa",
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/calculator.png', width: 30, height: 30),
            label: "Kalori",
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/çark.png', width: 30, height: 30),
            label: "Çark",
          ),
        ],
      ),
    );
  }

  // Body kısmınızı oluşturan özel metod
  Widget _buildBaslangiclarBody() {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 6, right: 6),
            child: Column(
              children: [

                HeaderMethod(
                  title: "BAŞLANGIÇLAR",
                  topPadding: 15.0,
                  leftPadding: 30.0,
                  rightPadding: 30.0,
                  horizontalPadding: 15.0,
                  verticalPadding: 10.0,
                  fontSize: 25.0,
                  borderRadius: 25.0,
                  spacing: 20.0,
                ),




                Column(
                  children: [
                    // BuildingRowMethodsForTwoComponent sınıfından buildRow çağrılıyor
                    BuildingRowMethodsForTwoComponent.buildRow(
                      leftImage: 'assets/images/çorba.png',
                      leftText: "ÇORBALAR",
                      leftPage: Corbalar(),
                      rightImage: 'assets/images/meze.png',
                      rightText: "MEZELER",
                      rightPage: Mezeler(),
                      context: context,
                    ),
                    BuildingRowMethodsForTwoComponent.buildRow(
                      leftImage: 'assets/images/salata.png',
                      leftText: "SALATALAR",
                      leftPage: Salatalar(),
                      rightImage: 'assets/images/hamurişleri.png',
                      rightText: "HAMUR İŞLERİ",
                      rightPage: HamurIsleri(),
                      context: context,
                    ),
                    BuildingRowMethodsForTwoComponent.buildRow(
                      leftImage: 'assets/images/zeytinyağlılar.png',
                      leftText: "ZEYTİNYAĞLILAR",
                      leftPage: Zeytinyaglilar(),
                      rightImage: 'assets/images/denizürünleri.png',
                      rightText: "DENİZ ÜRÜNLERİ",
                      rightPage: DenizUrunleri(),
                      context: context,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
