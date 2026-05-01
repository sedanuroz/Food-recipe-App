import 'package:flutter/material.dart';
import 'package:yemek_dunyasi/screens/siginPage.dart';
import 'package:yemek_dunyasi/screens/loginPage.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFFF7F6E3),
      body: Center(

        child: Column(
          children: [
            // Resim
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 100),
              child: Align(
                alignment: Alignment.topLeft,
                child: Image.asset('assets/images/start_page_img.png'),
              ),
            ),

            // Yazılar
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 50),
              child: Column(
                children: [
                  Text(
                    "YEMEK",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF326E62),
                      letterSpacing: 1.5,
                      fontFamily: 'TanAegean',
                    ),
                  ),
                  SizedBox(height: 5),

                  Text(
                    "DÜNYASI",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color:Color(0xFF326E62),
                      letterSpacing: 1.5,
                      fontFamily: 'TanAegean',
                    ),
                  ),

                  SizedBox(height: 50), // Metinler arasında boşluk

                  Text(
                    "Lezzetli Anlar İçin Tarifler Sizi Bekliyor!",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),

                ],
              ),
            ),

            // Butonlar
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  // İlk Buton
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF326E62),
                      padding: EdgeInsets.symmetric(horizontal: 120, vertical: 5),
                    ),
                    child: Text(
                      "Giriş Yap",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // Butonlar arasında boşluk

                  // İkinci Buton
                  ElevatedButton(

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SigninPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF81B8A8),
                      padding: EdgeInsets.symmetric(horizontal: 120, vertical: 7),
                    ),
                    child: Text(
                      "Kayıt Ol",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(child: Container()),

            // Alt Metin
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                "© 2024 YEMEK DÜNYASI. Tüm Hakları Saklıdır.",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
