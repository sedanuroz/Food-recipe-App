import 'package:flutter/material.dart';
import 'package:yemek_dunyasi/screens/importantMetods/HeaderMethod.dart';
import 'package:yemek_dunyasi/aboutUsers/dbHelper.dart'; // DbHelper sınıfını import et
import 'package:yemek_dunyasi/screens/bottom_bars_choises/favorite/meal.dart';

class YemekDetaylariPage extends StatefulWidget {
  final Meal meal;  // Meal nesnesi alıyoruz

  YemekDetaylariPage({required this.meal});

  @override
  _YemekDetaylariPageState createState() => _YemekDetaylariPageState();
}

class _YemekDetaylariPageState extends State<YemekDetaylariPage> {
  //Dart'ta List, referans tipli (reference type) bir veri yapısıdır.
  // Yani bir listeyi başka bir değişkene atadığınızda, aslında listenin bir kopyasını değil,
  // aynı bellekteki adresi paylaşırsınız.
  //yanı userList değiştikçe aslında user a ait olan liste de değişebilecek
  late List<int> userList;//bir sonraki adımda başlatılacak bir list

  @override
  void initState() {
    super.initState();
    userList = [];

    //yemek detayına tıklanan yeemğin type değerine göre o listeyi alıyoruz
    //mesela anaYemeklerList olabilir type degeri anaYemkler ise
    DbHelper().getLoggedInUser().then((user) {
      if (user != null && user.isLoggedIn == 1) {
        DbHelper().getUserListByType(user, widget.meal.type).then((list) {//then((list) {...}) ile veri geldiğinde yapılacak işlemi belirtiyoruz.
          setState(() {
            userList = list ?? [];
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Tarifi numaralandırma
    List<String> recipeSteps = widget.meal.recipe.split('.'); // . ile ayırarak  listeledim yemek tariflerini boylece bu sekılde alt alta yazabilecegim
    //Boş bir liste tanımlanır. Bu liste, yemek tarifinin her bir adımını gösterecek olan Widget öğelerini saklayacak.
    List<Widget> recipeWidgets = [];// her bir tarif adımını bir widget olraak sırayla ekleyecegiz buraya
    //recipeSteps listesindeki her bir öğeyi (yemek tarifindeki her adımı) teker teker ele alır.
    for (int i = 0; i < recipeSteps.length; i++) {
      if (recipeSteps[i].isNotEmpty) {
        recipeWidgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${i + 1}. ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Expanded(
                  child: Text(
                    recipeSteps[i].trim(),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Color(0xFFF7F6E3),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            //ana eksenin dikey (veya yatay) yönüne dik olan eksende hizalamayı belirler.
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Başlık
              Center(
                child: HeaderMethod(
                  title: widget.meal.name,
                  topPadding: 15.0,
                  leftPadding: 30.0,
                  rightPadding: 30.0,
                  horizontalPadding: 15.0,
                  verticalPadding: 10.0,
                  fontSize: 25.0,
                  borderRadius: 25.0,
                  spacing: 20.0,
                ),
              ),
              // Yemek görseli
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 350,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(//yuvarlak kose yapar resim için
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      widget.meal.imageUrl,
                      fit: BoxFit.cover,//kutuyu tamamen kaplayacak sekılde olacak
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "MALZEMELER",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (var ingredient in widget.meal.ingredient.split(','))
                    Center(
                      child: Text(
                        ingredient.trim(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "------------------------------------",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "YAPILIŞI",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              // Tarif adımları
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,// çocukları yan eksende  hizalamak için kullandık
                children: recipeWidgets,
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "------------------------------------",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Kalori: ${widget.meal.calories[0].calorie?? 'Bilinmiyor'}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              // Favori Butonu
              SizedBox(height: 15),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      DbHelper().getLoggedInUser().then((user) async {
                        if (user != null && user.isLoggedIn == 1) {
                          final db = DbHelper();
                          List<int> updatedList = await db.getUserListByType(user, widget.meal.type);

                          if (updatedList !=null) {
                            if (updatedList.contains(widget.meal.id)) {
                              // Favorilerden kaldır
                              updatedList.remove(widget.meal.id);
                              print("Favorilerden kaldır ------------------------------------------");
                            } else {
                              // Favorilere ekle
                              updatedList.add(widget.meal.id);
                              print("Favorilere ekle ------------------------------------------");
                            }


                            await db.updateUser(user);
                            // userList'i güncelliyoruz
                            setState(() {
                              userList = updatedList;
                              //burada gercekten referans verip veremediğini denedim doruymus referans verdi
                              print("---------------------------------------------------------------");
                              print(identical(updatedList, userList));


                            });
                          }
                        }
                      });
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userList.contains(widget.meal.id) ? "FAVORİLERDEN KALDIR" : "FAVORİLERE EKLE",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.favorite,
                          color: userList.contains(widget.meal.id) ? Colors.grey : Colors.red,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFFf4cbc2),
                    side: BorderSide(color: Colors.black, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// Kullanım:
void navigateToYemekDetaylari({
  required BuildContext context,
  required Meal meal, // Meal nesnesini alıyoruz
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => YemekDetaylariPage(
        meal: meal,  // meal nesnesini geçiyoruz
      ),
    ),
  );
}
