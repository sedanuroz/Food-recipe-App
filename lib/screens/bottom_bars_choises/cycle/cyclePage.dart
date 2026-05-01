import 'package:flutter/material.dart';
import 'package:yemek_dunyasi/screens/importantMetods/HeaderMethod.dart'; // Yeni import
import 'package:yemek_dunyasi/screens/bottom_bars_choises/cycle/SpinningImage.dart'; // SpinningImage importu

class CyclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F6E3),
      body: SafeArea( // Ekran kenar boşluklarına taşmayı önler
        child: SingleChildScrollView( // Kaydırılabilir içerik
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Elemanları yatayda hizalar
            children: [
              HeaderMethod(
                title: "GÜNÜN MENÜSÜ", // Başlık
                topPadding: 0.0, // Üst boşluk
                leftPadding: 30.0, // Sol boşluk
                rightPadding: 30.0, // Sağ boşluk
                horizontalPadding: 15.0, // Yatay dolgu
                verticalPadding: 10.0, // Dikey dolgu
                fontSize: 25.0, // Yazı boyutu
                borderRadius: 25.0, // Köşe yuvarlaklığı
                spacing: 0.0, // Başlık altındaki boşluk
              ),
              SizedBox(height: 20), // Araya boşluk ekledik

              // SpinningImage widget'ını yerleştiriyoruz
              Container(
                padding: EdgeInsets.all(0), // Kenarlarda padding yok
                margin: EdgeInsets.all(0), // Margin de sıfırlandı
                height: MediaQuery.of(context).size.height - 250, // Ekranın alt kısmını boş bırakıyoruz
                width: double.infinity, // Ekran genişliğine kadar
                child: Center(
                  child: SpinningImage(), // SpinningImage widget'ı
                ),
              ),
              SizedBox(height: 30), // Araya boşluk ekledik
            ],
          ),
        ),
      ),
    );
  }
}