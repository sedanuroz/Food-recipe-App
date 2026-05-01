import 'package:flutter/material.dart';
import 'package:yemek_dunyasi/aboutUsers/users.dart'; // User modelini içe aktar
import 'dart:async';
import 'dbHelper.dart'; // DatabaseHelper sınıfı
import 'package:yemek_dunyasi/screens/startPage.dart';
import 'package:yemek_dunyasi/screens/bottom_bars_choises/main_page.dart';

class LandingScreen extends StatefulWidget {
  //bu satır LandingScreen widget'ını sabit hale getirir, aynı zamanda widget'ın benzersizliğini sağlamak ve performansı artırmak amacıyla key parametresini üst sınıfa iletir.
  const LandingScreen({Key? key}) : super(key: key);


  //bu satır, LandingScreen widget'ı için durumu yöneten bir State sınıfı (_LandingScreenState) oluşturur
  // bu sayede widget'ın dinamik davranışlarını yönetebiliriz.
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool _isLoading = true;


  //initState() metodu, widget ilk kez oluşturulduğunda çalışır. Biz bu metodu @override ile değiştirerek, widget’ın başlatılması sırasında yapmamız gereken işlemleri özelleştiririz. Yani, StatefulWidget’ın oluşturulma sürecine müdahale ederiz.
  @override
  void initState() {
    super.initState();
    // Veritabanı başlatma işlemini tamamlamak için bekleyin
    DbHelper().database.then((value) {
      // 3 saniyelik bir gecikme başlatır
      Future.delayed(Duration(seconds: 3), () {
        //setState() çağrıldığında, Flutter, State sınıfındaki build() metodunu tekrar çağırarak, widget'ın görselini günceller. Bu, kullanıcıya uygulamanın o anki durumunu doğru bir şekilde yansıtarak, ekrandaki öğeleri yeniden çizmesini sağlar.
        setState(() {
          _isLoading = false; // 3 saniye sonra yükleme göstergesini durdur
        });
      });
    });
  }

  //eger kullnaıcı daha onceden giriş yapmıssa direk ana sayfaya yonlendir yoksa giriş sayfasına yonlendırılsın
  Future<void> _checkUserLogin() async {
    User? user = await DbHelper().getLoggedInUser();

    if (user != null && user.isLoggedIn == 1) {
      await DbHelper().updateUser(user);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StartPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD5F4F4),
      //FutureBuilder'ın başarılı bir şekilde veri aldığında o veri, User? türünde olacak.
      body: FutureBuilder<User?>(
        //FutureBuilder widget'ına verilen asenkron bir işlemdir
        //Bu işlem, DbHelper sınıfından gelen getLoggedInUser() fonksiyonunu çağırarak bir kullanıcı verisini asenkron bir şekilde almayı amaçlar.
        future: DbHelper().getLoggedInUser(),
        builder: (context, snapshot) {
          if (_isLoading || snapshot.connectionState == ConnectionState.waiting) {
            //Stack, içindeki widget'ları üst üste yerleştiren bir widget'tır.
            return Stack(
              fit: StackFit.expand,//Stack widget'ının boyutlarının, tüm üst widget'ı kapsayacak şekilde genişlemesini sağlar.
              children: [
                Image.asset(
                  'assets/img.png',
                  fit: BoxFit.cover,// Bu özellik, resmin ekranı tamamen kaplamasını sağlar ve resmin oranlarını bozmadan ekran boyutlarına uyum sağlar
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 40.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            );
          }
          //DbHelper().deleteDatabaseFile();
          DbHelper().printAllUsers();

          if (snapshot.hasError) {
            print("Hata: ${snapshot.error}");
            return const StartPage();
          }

          if (snapshot.hasData) {
            final user = snapshot.data;

            if (user != null && user.isLoggedIn == 1) {
              _checkUserLogin(); // Kullanıcı giriş yaptıysa, güncelle ve ana sayfaya yönlendir
              return Container(); // Beklemek için geçici olarak boş bir container
            }
          }

          return const StartPage(); // Kullanıcı verisi yoksa veya giriş yapılmamışsa StartPage'e yönlendir
        },
      ),
    );
  }
}
