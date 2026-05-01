import 'package:flutter/material.dart';
import 'package:yemek_dunyasi/screens/importantMetods/HeaderMethod.dart';
import 'package:yemek_dunyasi/aboutUsers/dbHelper.dart'; // DbHelper sınıfını import et
import 'package:yemek_dunyasi/screens/bottom_bars_choises/favorite/meal.dart';

class YemekDetaylariPage extends StatefulWidget {
  final Map<String, dynamic> item;
  final String imageField;
  final String nameField;
  final String ingredientField;
  final String caloriesField;
  final String recipeField;
  final String type;
  final int id;

  YemekDetaylariPage({
    required this.item,
    required this.imageField,
    required this.nameField,
    required this.ingredientField,
    required this.caloriesField,
    required this.recipeField,
    required this.type,
    required this.id,
  });

  @override
  _YemekDetaylariPageState createState() => _YemekDetaylariPageState();
}

class _YemekDetaylariPageState extends State<YemekDetaylariPage> {
  late List<int> userList; // userList'i burada tanımlıyoruz

  @override
  void initState() {
    super.initState();

    // İlk başta userList'i boş olarak başlatıyoruz
    userList = [];

    // Kullanıcı verisini alıyoruz ve favori listesine bakıyoruz
    DbHelper().getLoggedInUser().then((user) {
      if (user != null && user.isLoggedIn == 1) {
        // Kullanıcının favori listesini alıyoruz
        DbHelper().getUserListByType(user, widget.type).then((list) {
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
    List<String> recipeSteps = widget.item[widget.recipeField].split('.'); // . ile ayırarak adımları listeleyin
    List<Widget> recipeWidgets = [];
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Başlık
              Center(
                child: HeaderMethod(
                  title: widget.item[widget.nameField],
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      widget.item[widget.imageField],
                      fit: BoxFit.cover,
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
                  for (var ingredient in widget.item[widget.ingredientField].split(','))
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  'Kalori: ${widget.item[widget.caloriesField] != null && widget.item[widget.caloriesField].isNotEmpty ? widget.item[widget.caloriesField][0]['calorie'] : 'Bilinmiyor'}',
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
                          List<int> updatedList = await db.getUserListByType(user, widget.type);

                          if (updatedList != null) {
                            if (updatedList.contains(widget.id)) {
                              // Favorilerden kaldır
                              updatedList.remove(widget.id);
                              print("Favorilerden kaldır ------------------------------------------");
                            } else {
                              // Favorilere ekle
                              updatedList.add(widget.id);
                              print("Favorilere ekle ------------------------------------------");
                            }
                            for (int i = 0; i < user.baslangiclar_corbalarList.length; i++) {
                              print("---------------${user.baslangiclar_corbalarList[i]}");
                            }


                            // Güncellenmiş listeyi veritabanına kaydediyoruz
                            await db.updateUser(user);

                            // userList'i güncelliyoruz
                            setState(() {
                              userList = updatedList;  // Favoriler listesi güncelleniyor
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
                          userList.contains(widget.id) ? "FAVORİLERDEN KALDIR" : "FAVORİLERE EKLE",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.favorite,
                          color: userList.contains(widget.id) ? Colors.grey : Colors.red,
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
  required Map<String, dynamic> item,
  required String imageField,
  required String nameField,
  required String ingredientField,
  required String caloriesField,
  required String recipeField,
  required String type,
  required int id,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => YemekDetaylariPage(
        item: item,
        imageField: imageField,
        nameField: nameField,
        ingredientField: ingredientField,
        caloriesField: caloriesField,
        recipeField: recipeField,
        type: type, // item objesinin type değerini alıyoruz
        id: item['id'] ?? 0, // item objesinin id değerini alıyoruz
      ),
    ),
  );
}