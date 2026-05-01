import 'dart:convert';
import 'package:yemek_dunyasi/screens/bottom_bars_choises/note/note.dart';

class User {
  int? id; // Kullanıcı id'si (veritabanı tarafından otomatik olarak atanır)
  String name; // Kullanıcı adı
  String email; // Kullanıcı e-posta adresi
  String password; // Kullanıcı şifresi
  int isLoggedIn; // Uygulamaya daha önce giriş yapıp yapmadığı bilgisi (0: false, 1: true)

  List<int> anaYemeklerList;
  List<int> baslangiclar_corbalarList;
  List<int> baslangiclar_denizUrunleriList;
  List<int> baslangiclar_hamurIsleriList;
  List<int> baslangiclar_mezelerList;
  List<int> baslangic_salatalarList;
  List<int> baslangiclar_zeytinyaglilarList;
  List<int> fastFoodList;
  List<int> kahvaltiliklerList;
  List<int> tatlilerList;
  List<int> yanLezzetler_makarnalarList;
  List<int> yanLezzetler_pilavlarList;
  List<int> yanLezzetler_sebzeVEPureList;
  List<int> yanLezzetler_soslarVeDiplerList;
  List<Note> note; // Note türünde liste


  // Constructor
  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.isLoggedIn = 0, // Default olarak 0 (false)
    required this.anaYemeklerList,
    required this.baslangiclar_corbalarList,
    required this.baslangiclar_denizUrunleriList,
    required this.baslangiclar_hamurIsleriList,
    required this.baslangiclar_mezelerList,
    required this.baslangic_salatalarList,
    required this.baslangiclar_zeytinyaglilarList,
    required this.fastFoodList,
    required this.kahvaltiliklerList,
    required this.tatlilerList,
    required this.yanLezzetler_makarnalarList,
    required this.yanLezzetler_pilavlarList,
    required this.yanLezzetler_sebzeVEPureList,
    required this.yanLezzetler_soslarVeDiplerList,
    required this.note,
  });
  //factory  veritabanı verisinden bir User nesnesi oluşturulacaktır.
  //User.fromMap: Bu, User sınıfı için Map<String, dynamic> tipindeki veriyi bir User nesnesine dönüştüren bir constructor
  factory User.fromMap(Map<String, dynamic> dbData) {
    return User(
      id: dbData['id'],
      name: dbData['name'],
      email: dbData['email'],
      password: dbData['password'],
      isLoggedIn: dbData['isLoggedIn'],
      //sonDecode fonksiyonu, bir JSON (string formatındaki veri) içeriğini Dart veri yapısına (örneğin, List, Map, vb.) dönüştürür.
      anaYemeklerList: (jsonDecode(dbData['anaYemeklerList'] ?? '[]') as List).cast<int>(),
      baslangiclar_corbalarList: (jsonDecode(dbData['baslangiclar_corbalarList'] ?? '[]') as List).cast<int>(),
      baslangiclar_denizUrunleriList: (jsonDecode(dbData['baslangiclar_denizUrunleriList'] ?? '[]') as List).cast<int>(),
      baslangiclar_hamurIsleriList: (jsonDecode(dbData['baslangiclar_hamurIsleriList'] ?? '[]') as List).cast<int>(),
      baslangiclar_mezelerList: (jsonDecode(dbData['baslangiclar_mezelerList'] ?? '[]') as List).cast<int>(),
      baslangic_salatalarList: (jsonDecode(dbData['baslangic_salatalarList'] ?? '[]') as List).cast<int>(),
      baslangiclar_zeytinyaglilarList: (jsonDecode(dbData['baslangiclar_zeytinyaglilarList'] ?? '[]') as List).cast<int>(),
      fastFoodList: (jsonDecode(dbData['fastFoodList'] ?? '[]') as List).cast<int>(),
      kahvaltiliklerList: (jsonDecode(dbData['kahvaltiliklerList'] ?? '[]') as List).cast<int>(),
      tatlilerList: (jsonDecode(dbData['tatlilerList'] ?? '[]') as List).cast<int>(),
      yanLezzetler_makarnalarList: (jsonDecode(dbData['yanLezzetler_makarnalarList'] ?? '[]') as List).cast<int>(),
      yanLezzetler_pilavlarList: (jsonDecode(dbData['yanLezzetler_pilavlarList'] ?? '[]') as List).cast<int>(),
      yanLezzetler_sebzeVEPureList: (jsonDecode(dbData['yanLezzetler_sebzeVEPureList'] ?? '[]') as List).cast<int>(),
      yanLezzetler_soslarVeDiplerList: (jsonDecode(dbData['yanLezzetler_soslarVeDiplerList'] ?? '[]') as List).cast<int>(),
      //Burada, note listesi için JSON verisi (dbData['note']) önce JSON formatından Dart listesine (List<dynamic>) dönüştürülür.
      // Ardından, her bir öğe (her biri bir map) Note.fromMap kullanılarak bir Note nesnesine dönüştürülür.
      // Bu dönüşüm, her öğe için Note sınıfından bir nesne oluşturur.
      note: (jsonDecode(dbData['note'] ?? '[]') as List)
          .map((e) => Note.fromMap(e as Map<String, dynamic>))
          .toList(), // note listesini alıyoruz
    );
  }


  //Bu fonksiyon, User nesnesinin tüm verilerini bir Map<String, dynamic> formatına dönüştürür,
  // yani veritabanına uygun hale getirir
  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'isLoggedIn': isLoggedIn, // 0 veya 1 değerini saklayacak
      //Bu alanlarda, List<int> gibi listeler, jsonEncode fonksiyonu ile JSON formatına dönüştürülür.
      // jsonEncode, listeyi bir JSON string'ine dönüştürür, böylece bu listeyi veritabanına kaydedebiliriz.
      'anaYemeklerList': jsonEncode(anaYemeklerList),
      'baslangiclar_corbalarList': jsonEncode(baslangiclar_corbalarList),
      'baslangiclar_denizUrunleriList': jsonEncode(baslangiclar_denizUrunleriList),
      'baslangiclar_hamurIsleriList': jsonEncode(baslangiclar_hamurIsleriList),
      'baslangiclar_mezelerList': jsonEncode(baslangiclar_mezelerList),
      'baslangic_salatalarList': jsonEncode(baslangic_salatalarList),
      'baslangiclar_zeytinyaglilarList': jsonEncode(baslangiclar_zeytinyaglilarList),
      'fastFoodList': jsonEncode(fastFoodList),
      'kahvaltiliklerList': jsonEncode(kahvaltiliklerList),
      'tatlilerList': jsonEncode(tatlilerList),
      'yanLezzetler_makarnalarList': jsonEncode(yanLezzetler_makarnalarList),
      'yanLezzetler_pilavlarList': jsonEncode(yanLezzetler_pilavlarList),
      'yanLezzetler_sebzeVEPureList': jsonEncode(yanLezzetler_sebzeVEPureList),
      'yanLezzetler_soslarVeDiplerList': jsonEncode(yanLezzetler_soslarVeDiplerList),
      //her bir Note nesnesini önce toMap() fonksiyonu ile bir Map<String, dynamic>'e dönüştürür
      // ardından tüm listeyi JSON formatına çevirir.
      'note': jsonEncode(note.map((note) => note.toMap()).toList()), // note listesini JSON'a dönüştürüyoruz
    };
  }
}
