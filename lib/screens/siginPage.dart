import 'package:flutter/material.dart';
import 'package:yemek_dunyasi/screens/loginPage.dart';
import 'package:yemek_dunyasi/aboutUsers/dbHelper.dart'; // DbHelper sınıfını import et
import 'package:yemek_dunyasi/aboutUsers/users.dart'; // User modelini import et

class SigninPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F6E3),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Resim
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset('assets/images/sign_in_page.png'),
                ),
              ),

              // Yazılar
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 25),
                child: Column(
                  children: [
                    Text(
                      "YENİ HESAP",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF326E62),
                        letterSpacing: 1.5,
                        fontFamily: 'TanAegean',
                      ),
                    ),
                    Text(
                      "OLUŞTUR",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF326E62),
                        letterSpacing: 1.5,
                        fontFamily: 'TanAegean',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          "Zaten Kayıtlı Mısınız? Buradan Giriş Yapın",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Kullanıcı Bilgi Giriş Alanları
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "İsim ve Soyisim",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    filled: true,//TextField widget'ının arka planını doldurur.
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,//kenarlığın tamamen kaldırılmasını belirtir
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Şifrenizi Tekrar Giriniz",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_passwordController.text == _confirmPasswordController.text) {
                      // User modelini oluştur
                      User newUser = User(
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        isLoggedIn: 0, // Başlangıçta giriş yapılmadı
                        anaYemeklerList: [],
                        baslangiclar_corbalarList: [],
                        baslangiclar_denizUrunleriList: [],
                        baslangiclar_hamurIsleriList: [],
                        baslangiclar_mezelerList: [],
                        baslangic_salatalarList: [],
                        baslangiclar_zeytinyaglilarList: [],
                        fastFoodList: [],
                        kahvaltiliklerList: [],
                        tatlilerList: [],
                        yanLezzetler_makarnalarList: [],
                        yanLezzetler_pilavlarList: [],
                        yanLezzetler_sebzeVEPureList: [],
                        yanLezzetler_soslarVeDiplerList: [],
                        note:[],

                      );

                      // Kullanıcıyı veritabanına ekle
                      bool state=await DbHelper.instance.isUserExistsByEmail(newUser.email);
                      if(state){
                        print("kullanıcıyı ekleyecek");
                        await DbHelper.instance.insertUser(newUser);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Kaydetme işlemi başarıyla gerçekleştirildi."),
                          ),
                        );
                        // Giriş sayfasına yönlendirme
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Bu email zaten mevcut."),
                          ),
                        );
                        print("Bu email zaten mevcut");

                      }
                    } else {
                      // Şifreler uyuşmuyorsa hata mesajı göster
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Şifreler eşleşmiyor."),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF326E62),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
