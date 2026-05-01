import 'package:flutter/material.dart';
import 'package:yemek_dunyasi/screens/bottom_bars_choises/main_page.dart';
import 'package:yemek_dunyasi/aboutUsers/dbHelper.dart'; // DbHelper sınıfını import et
import 'package:yemek_dunyasi/aboutUsers/users.dart'; // User modelini import et


class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F6E3),
      body: Center(
        //tek bir çocuk widget'ını kaydırılabilir (scrollable) hale getirmek için kullandım
        //ekrana sıgmazsa kaydırılabilsin
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Resim
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 100),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset('assets/images/login_page.img.png'),
                ),
              ),

              // Başlık
              Padding(
                padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Center(
                  child: Text(
                    "          GİRİŞ YAPARAK \n      YEMEK DÜNYASINDA \nYOLCULUĞUNUZA BAŞLAYIN",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF32493C),
                      letterSpacing: 1.5,
                      fontFamily: 'TanAegean',
                    ),
                  ),
                ),
              ),

              // Email Girişi
              Padding(
                padding: EdgeInsets.only(top: 30, right: 30, left: 30),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "E-posta",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,//baslngıcta yok tıklanınca olacak
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                      prefixIcon: Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
              ),

              // Şifre Girişi
              Padding(
                padding: EdgeInsets.only(top: 15, right: 30, left: 30),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,//şifre yerine * olsun her karakter diye var
                    decoration: InputDecoration(
                      labelText: "Şifre",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
              ),

              // Giriş Yap Butonu
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    String email = _emailController.text;
                    String password = _passwordController.text;

                    // Veritabanında kullanıcıyı sorgulama
                    User? user = await DbHelper.instance.getUserByEmailAndPassword(email, password);

                    if (user == null) {
                      print("Kullanıcı bulunamadı!");
                      // Kullanıcı bulunamadı, hata mesajı gösterme
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("E-posta veya şifre hatalı."),
                        ),
                      );
                    } else {
                      print("Kullanıcı bulundu, login yapılıyor.");
                      // Kullanıcı bulundu, login işlemi yapma
                      await DbHelper.instance.loginUser(user);

                      // MainPage'e yönlendirme
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
                    }
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
              ),

              // Şifremi Unuttum Butonu
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextButton(
                  onPressed: () {
                    // Şifre sıfırlama işlemi burada yapılabilir
                  },
                  child: Text(
                    "Şifremi unuttum",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}