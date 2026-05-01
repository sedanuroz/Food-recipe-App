import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:yemek_dunyasi/screens/importantMetods/HeaderMethod.dart';

class  CalculateCalPage extends StatefulWidget {
  @override
  State< CalculateCalPage> createState() => _CalculateCalPageState();
}

class _CalculateCalPageState extends State< CalculateCalPage> {
  bool isLoading = false;
  late FocusNode _focusNode;//bir widget'a odaklanmayı (focus) ve klavye girişlerini yönetmeyi sağlayan bir nesnedir.

  // Arama işlemi için değişkenler
  TextEditingController searchController = TextEditingController();
  bool isSearch = false;
  List<Map<String, dynamic>> foodList = [];//yemek listemız alt alta olan
  List<Map<String, dynamic>> searchList = [];//arama listesinde filtrelenen kısımdeki liste
  List<Map<String, dynamic>> tableData = []; // Tablo verisi için liste

  // JSON verisini yükleme fonksiyonu
  Future<void> loadData() async {
    // Birden fazla JSON dosyasından veri yükledik bu adımda
    // dosyasının içeriğini String olarak okur ve data değişkenine atar.
    // JSON verisi bir metin olarak alınır, ve ilerleyen adımlarda bu veri JSON formatına dönüştürülüp kullanılabilir.
    //Flutter'da onu doğrudan bir Dart objesi olarak kullanamazsınız.
    // Bunun yerine, dosyayı bir String olarak okuduktan sonra JSON verisini Dart nesnesine dönüştürmek gereklidir.
    String data1 = await rootBundle.loadString('assets/anaYemekler/anayemekler.json');
    String data2 = await rootBundle.loadString('assets/baslangicler/corbalar/corbalar.json');
    String data3 = await rootBundle.loadString('assets/baslangicler/denizUrunleri/denızUrunler.json');
    String data4 = await rootBundle.loadString('assets/baslangicler/hamurİsleri/hamurİsleri.json');
    String data5 = await rootBundle.loadString('assets/baslangicler/mezeler/mezeler.json');
    String data6 = await rootBundle.loadString('assets/baslangicler/salatalar/salatalar.json');
    String data7 = await rootBundle.loadString('assets/baslangicler/zeytinyaglilar/zeytinyaglilar.json');
    String data8 = await rootBundle.loadString('assets/fastfood/fastfood.json');
    String data9 = await rootBundle.loadString('assets/kahvaltilikler/kahvaltilikler.json');
    String data10 = await rootBundle.loadString('assets/tatlilar/tatlilar.json');
    String data11 = await rootBundle.loadString('assets/yanlezzetler/makarnalar/makarnalar.json');
    String data12 = await rootBundle.loadString('assets/yanlezzetler/pilavlar/pilavlar.json');
    String data13 = await rootBundle.loadString('assets/yanlezzetler/purelerVeSebzeGarniturleri/pureVeSebzeGarniturleri.json');
    String data14 = await rootBundle.loadString('assets/yanlezzetler/soslarVeDipler/soslarVeDipler.json');

    //J bir JSON formatındaki String'i Dart veri yapısına (List veya Map gibi) çevirir.
    // JSON verilerini çözme
    List<dynamic> jsonData1 = json.decode(data1);
    List<dynamic> jsonData2 = json.decode(data2);
    List<dynamic> jsonData3 = json.decode(data3);
    List<dynamic> jsonData4 = json.decode(data4);
    List <dynamic> jsonData5 = json.decode(data5);
    List <dynamic> jsonData6 = json.decode(data6);
    List <dynamic> jsonData7 = json.decode(data7);
    List <dynamic> jsonData8 = json.decode(data8);
    List <dynamic> jsonData9 = json.decode(data9);
    List <dynamic> jsonData10 = json.decode(data10);
    List <dynamic> jsonData11 = json.decode(data11);
    List <dynamic> jsonData12 = json.decode(data12);
    List <dynamic> jsonData13 = json.decode(data13);
    List <dynamic> jsonData14 = json.decode(data14);

    // Verileri birleştirme
    setState(() {
      //map() fonksiyonu, jsonData1 listesindeki her öğeyi Map<String, dynamic> türüne dönüştürür.
      foodList = [
        ...jsonData1.map((e) => e as Map<String, dynamic>),  // İlk JSON verisi
        ...jsonData2.map((e) => e as Map<String, dynamic>),  // İkinci JSON verisi
        ...jsonData3.map((e) => e as Map<String, dynamic>),  // Üçüncü JSON verisi
        ...jsonData4.map((e) => e as Map<String, dynamic>),  // Üçüncü JSON verisi
        ...jsonData5.map((e) => e as Map<String, dynamic>),  // Üçüncü JSON verisi
        ...jsonData6.map((e) => e as Map<String, dynamic>),  // Üçüncü JSON verisi
        ...jsonData7.map((e) => e as Map<String, dynamic>),  // Üçüncü JSON verisi
        ...jsonData8.map((e) => e as Map<String, dynamic>),  // Üçüncü JSON verisi
        ...jsonData9.map((e) => e as Map<String, dynamic>),  // Üçüncü JSON verisi
        ...jsonData10.map((e) => e as Map<String, dynamic>),  // Üçüncü JSON verisi
        ...jsonData11.map((e) => e as Map<String, dynamic>),  // Üçüncü JSON verisi
        ...jsonData12.map((e) => e as Map<String, dynamic>),  // Üçüncü JSON verisi
        ...jsonData13.map((e) => e as Map<String, dynamic>),  // Üçüncü JSON verisi
        ...jsonData14.map((e) => e as Map<String, dynamic>),  // Üçüncü JSON verisi

      ];
      isLoading = false;
    });
  }

  // Arama fonksiyonu
  void searchFunc(String value) {
    searchList.clear();
    for (var food in foodList) {
      if (food['name'].toLowerCase().contains(value.toLowerCase())) {
        searchList.add(food);
      }
    }
    setState(() {});//arayuzu guncelledik widgetimizi
  }

  // Tabloya yemek ekleme fonksiyonu
  void addToTable(Map<String, dynamic> food) {
    setState(() {
      tableData.add({
        'name': food['name'],
        'calorie': food['calories'][0]['calorie'] ?? 'N/A',
        'portion': food['calories'].isNotEmpty ? food['calories'][0]['portion'] : 'Unknown',
        'image_url': food['image_url'] ?? '',
      });
    });
  }

  // Tablodan yemek silme fonksiyonu
  void removeFromTable(int index) {
    setState(() {
      tableData.removeAt(index);
    });
  }

  // Toplam kalori hesaplama fonksiyonu
  int calculateTotalCalories() {
    int totalCalories = 0;
    for (var item in tableData) {
      String calorieString = item['calorie'];
      int calorieValue = int.tryParse(calorieString.split(' ')[0]) ?? 0;
      totalCalories += calorieValue;
    }
    return totalCalories;
  }

  @override
  void initState() {
    super.initState();
    //Eğer build() fonksiyonunun içinde tanımlarsak, her setState() çağrıldığında yeniden oluşturulur ve odak bozulur.
    // Ama initState() içinde tanımlarsak, widget boyunca aynı nesneyi kullanabiliriz.
    _focusNode = FocusNode();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xFFF7F6E3), // Background color for the entire scaffold
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F6E3), // AppBar arka plan rengi
        title: appbarTitle(),  // Başlık kısmı (appbarTitle fonksiyonu kullanılabilir)

      ),

      body: Column(
        children: [

          isLoading
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Expanded(
            child: ListView.builder(
              itemCount: searchList.isNotEmpty ? searchList.length : foodList.length,
              itemBuilder: (context, index) {
                var item = searchList.isNotEmpty ? searchList[index] : foodList[index];
                return Card(
                  color: Color(0xFFF7F6E3), // Background color for each card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: item['image_url'] != null
                            ? Image.asset(item['image_url'], width: 50, height: 50, fit: BoxFit.cover)
                            : const Icon(Icons.image, size: 50),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text("${item['name']}")),
                            ElevatedButton(
                              onPressed: () {
                                addToTable(item); // Butona basıldığında tabloya ekleriz
                              },
                              child: const Text('Tabloya Ekle',style: TextStyle(color: Colors.black),),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFb1d1b7),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Porsiyon: ${item['calories'][0]['portion']}"),
                            Text("Kalori: ${item['calories'][0]['calorie']}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(//bir ayrım çizgisi oluturmak için kullanıldı
            color: Colors.black,
          ),
          Expanded(
            child: tableData.isNotEmpty
                ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: tableData.length,
                    itemBuilder: (context, index) {
                      var tableItem = tableData[index];
                      return Card(
                        color: Color(0xFFb1d1b7), // Background color for each table item
                        child: ListTile(
                          leading: tableItem['image_url'] != null
                              ? Image.asset(tableItem['image_url'], width: 50, height: 50, fit: BoxFit.cover)
                              : const Icon(Icons.image, size: 50),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(tableItem['name']),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Color(0xFF326E62),

                                onPressed: () {
                                  removeFromTable(index); // Silme butonuna tıklandığında sil
                                },
                              ),
                            ],
                          ),
                          subtitle: Text("Porsiyon: ${tableItem['portion']}, Kalori: ${tableItem['calorie']}"),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        int totalCalories = calculateTotalCalories();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Toplam Kalori: $totalCalories kcal"),
                          ),
                        );
                      },
                      child: const Text('Toplam Kaloriyi Hesapla',style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF326E62),
                      )
                  ),
                ),
              ],
            )
                : const Center(child: Text('Tabloda hiç veri yok.')),
          )
        ],
      ),
    );
  }

  Widget appbarTitle() {
    if (isSearch) {
      return Container(
        margin: const EdgeInsets.only(left: 40), // Arama çubuğu için biraz boşluk
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                focusNode: _focusNode,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  searchFunc(value);
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Ara',
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF326E62),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.white, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.white, width: 1),
                  ),
                ),
                cursorColor: Colors.white,
              ),
            ),
            IconButton(
              icon: const Icon(CupertinoIcons.clear, size: 24),
              onPressed: () {
                setState(() {
                  _focusNode.unfocus();
                  isSearch = false;
                  searchList.clear();
                });
              },
            ),
          ],
        ),
      );
    } else {
      // Taşma sorununu çözen, boyutları koruyan kısım burası:
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown, // Yazı sığmazsa boyutunu otomatik ayarlar
              alignment: Alignment.centerLeft, // Sola yaslı durmasını sağlar
              child: HeaderMethod(
                title: "KALORİ HESABI ",
                topPadding: 0.0,
                leftPadding: 17.0,
                rightPadding: 0.0,
                horizontalPadding: 15.0,
                verticalPadding: 10.0,
                fontSize: 25.0, // Orijinal büyük boyutun
                borderRadius: 25.0,
                spacing: 0.0,
              ),
            ),
          ),
          searchIconWidget(), // Arama ikonu
        ],
      );
    }
  }


  Widget searchIconWidget() {
    if (isSearch) {
      return IconButton(
        icon: const Icon(CupertinoIcons.clear, size: 24),
        onPressed: () {
          setState(() {
            _focusNode.unfocus();
            isSearch = false;
            searchList.clear();
          });
        },
      );
    } else {
      return IconButton(
        icon: const Icon(CupertinoIcons.search, size: 24),
        onPressed: () {
          setState(() {
            _focusNode.requestFocus();
            isSearch = true;
          });
        },
      );
    }
  }
}