import 'package:flutter/material.dart';
import 'package:yemek_dunyasi/aboutUsers/dbHelper.dart';
import 'package:yemek_dunyasi/screens/main_choises/baslangicler.dart';
import 'package:yemek_dunyasi/screens/main_choises/ana_yemekler.dart';
import 'package:yemek_dunyasi/screens/main_choises/yan_lezzetler.dart';
import 'package:yemek_dunyasi/screens/main_choises/tatlilar.dart';
import 'package:yemek_dunyasi/screens/main_choises/fast_food.dart';
import 'package:yemek_dunyasi/screens/main_choises/kahvaltilikler.dart';
import 'package:yemek_dunyasi/screens/importantMetods/buildingRowMethodsFor_two_Component.dart';
import 'package:yemek_dunyasi/screens/importantMetods/HeaderMethod.dart';
import 'package:yemek_dunyasi/screens/startPage.dart';

import 'favorite/favoritePage.dart';
import 'note/notePage.dart';
import '../bottom_bars_choises/calculate/calculateCalPage.dart';
import '../bottom_bars_choises/cycle/cyclePage.dart';
import 'package:yemek_dunyasi/aboutUsers/users.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {
  int _curIndex = 2; // Varsayılan olarak Ana Sayfa,


  final List<Widget> _pages = [
    FavoritePage(),
    NotePage(),
    _MainContent(),
    CalculateCalPage(),
    CyclePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Geri gitme işlemini engelle
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F6E3),
        body: _pages[_curIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFFF8F6F1),
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          currentIndex: _curIndex,
          onTap: (index) {
            setState(() {
              _curIndex = index; // Alt bardaki sekmeyi değiştir
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
              icon: const Icon(Icons.home),
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
      ),
    );
  }
}


class _MainContent extends StatelessWidget {



  // cıkıs ıslemi için fonksiyon
  Future<void> exitUser() async {
    User? user= await DbHelper().getLoggedInUser(); // Bu fonksiyon, giriş yapmış kullanıcıyı döndürüyor olabilir

    if (user != null) {
      await DbHelper().logoutUser(user);
      print('Kullanıcı çıkışı yapıldı');
    } else {
      print('Giriş yapmış kullanıcı bulunamadı');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              HeaderMethod(
                title: "YEMEK DÜNYASI",
                topPadding: 35.0,
                leftPadding: 35.0,
                rightPadding: 0.0,
                horizontalPadding: 15.0,
                verticalPadding: 10.0,
                fontSize: 25.0,
                borderRadius: 25.0,
                spacing: 20.0,
              ),
              IconButton(
                padding: EdgeInsets.only(top: 15),
                icon: const Icon(Icons.logout, size: 30.0, color: Color(0xFF326E62)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("ÇIKIŞ"),
                        content: const Text("Çıkış yapmak istediğinizden emin misiniz?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Çıkış işlemi iptal edildi!")),
                              );
                            },
                            child: const Text("Hayır"),
                          ),
                          TextButton(
                            onPressed: () {
                              exitUser();
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Hesaptan çıkış yapıldı!")));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => StartPage()),
                              );
                            },
                            child: const Text("Evet"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          BuildingRowMethodsForTwoComponent.buildRow(
            leftImage: 'assets/images/başlangıçlar.jpg',
            leftText: "BAŞLANGIÇLAR",
            leftPage: BaslangiclarPage(),
            rightImage: 'assets/images/anayemek.jpg',
            rightText: "ANA YEMEK",
            rightPage: AnaYemeklerPage(),
            context: context,
          ),
          BuildingRowMethodsForTwoComponent.buildRow(
            leftImage: 'assets/images/yanlezzetler.jpg',
            leftText: "YAN LEZZETLER",
            leftPage: YanLezzetlerPage(),
            rightImage: 'assets/images/tatlılar.jpg',
            rightText: "TATLILAR",
            rightPage: TatlilarPage(),
            context: context,
          ),
          BuildingRowMethodsForTwoComponent.buildRow(
            leftImage: 'assets/images/fostfood.jpg',
            leftText: "FAST-FOOD",
            leftPage: FastFoodPage(),
            rightImage: 'assets/images/kahvaltılıklar.jpg',
            rightText: "KAHVALTILIKLAR",
            rightPage: KahvaltiliklerPage(),
            context: context,
          ),
        ],
      ),
    );
  }




}
