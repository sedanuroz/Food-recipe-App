import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:yemek_dunyasi/aboutUsers/users.dart'; // User modelini içe aktar
import 'package:yemek_dunyasi/screens/bottom_bars_choises/favorite/meal.dart';



class DbHelper {
  static final DbHelper instance = DbHelper._init();// DbHelper sınıfını ilk kez olusturduk ve her yerde aynı ornegı kullanacagız
  //DbHelper sınıfının her ornegi (instance gibi) aynı _database değişkenine erişir ve bu değişken sınıfın örneğinden bagımsızdır
  //yanı veritabı baglantısı sadece bir kez yapılır ve uygulama boyunca ytek bir baglantı kullnaılır.

  static Database? _database;//private bir değişken olusturduk ve bu null da olabilir.


  //bir sınıf örneği lustururken cagırılan ilk constructor
  DbHelper() {
  }

  // named constructor olusturduk
  DbHelper._init();//sadece bu sınıfta kullanılabilen bir yapıcı
  //veri baglantısı işlemleri için kullanıllır

//veritabanı olusturur
  //eger varsa onu dondurur yoksa da olusturur.
  //boylece yalnızca bir tane veritabanı olusturulması saglanır
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user.db');
    return _database!;
  }

//bu metod SQLite veritabanını başlatır ve bağlantıyı döndürür.
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }


  Future<void> _createDB(Database db, int version) async {
    const userTable = '''
    CREATE TABLE user (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT NOT NULL,
      email TEXT NOT NULL,
      password TEXT NOT NULL,
      isLoggedIn INTEGER NOT NULL,
      anaYemeklerList TEXT,
      baslangiclar_corbalarList TEXT,
      baslangiclar_denizUrunleriList TEXT,
      baslangiclar_hamurIsleriList TEXT,
      baslangiclar_mezelerList TEXT,
      baslangic_salatalarList TEXT,
      baslangiclar_zeytinyaglilarList TEXT,
      fastFoodList TEXT,
      kahvaltiliklerList TEXT,
      tatlilerList TEXT,
      yanLezzetler_makarnalarList TEXT,
      yanLezzetler_pilavlarList TEXT,
      yanLezzetler_sebzeVEPureList TEXT,
      yanLezzetler_soslarVeDiplerList TEXT,
      note TEXT
      
    )
  ''';

    print("user tablosu olusturuldu");

    // SQL sorgusunu çalıştırarak tabloyu veritabanına ekler.
    //execute() fonksiyonu SQL sorgusunu çalıştıran bir metottur ve asenkron bir işlemdir.
    await db.execute(userTable);
  }

  // Kullanıcı ekleme (Insert)
  Future<int> insertUser(User user) async {
    final db = await database;
    print(user.name + " user eklendi");
    return await db.insert(
      'user', // Tablo adı
      user.toDatabase(), // User nesnesini Map'e dönüştür
      conflictAlgorithm: ConflictAlgorithm.replace, // Çakışma durumunda mevcut kaydı değiştir
      //örneğin bir id ile belirlenen veri zaten veritabanında bir kaydı varsa, bu kayıt silinir ve yerine yeni veri eklenir.
    );
  }

  Future<bool> isUserExistsByEmail(String email) async {
    final db = await database;

    // E-posta ile kullanıcıyı sorgula
    final existingUsers = await db.query(
      'user',
      where: 'email = ?',
      whereArgs: [email],
    );

    // Eğer kullanıcı varsa, false döndür (bulundu)
    if (existingUsers.isNotEmpty) {
      return false; // Kullanıcı mevcut
    }

    // Eğer kullanıcı yoksa, true döndür
    return true; // Kullanıcı yok
  }




  // Tüm kullanıcıları getirme
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('user'); // users tablosundaki tüm verileri al
  }

  // Kullanıcı güncelleme (Update)
  Future<int> updateUser(User user) async {
    final db = await database;
    print(user.name + " user güncellendi");

    return await db.update(
      'user', // Tablo adı
      user.toDatabase(), // Güncellenmiş User nesnesini Map'e dönüştür
      where: 'id = ?', // Şarta bağlı (id eşleşen kaydı güncelle)
      whereArgs: [user.id], // Şart için id değeri
    );
  }

  // Kullanıcı silme (Delete)
  Future<int> deleteUser(int id) async {
    final db = await database;
    print(id.toString() + " user silindi");

    return await db.delete(
      'user', // Tablo adı
      where: 'id = ?', // Şarta bağlı (id eşleşen kaydı sil)
      whereArgs: [id], // Şart için id değeri
    );
  }


  Future<User?> getUserById(int id) async {
    final db = await database;

    // ID'ye göre kullanıcıyı veritabanından sorgulama
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      // Veriyi User nesnesine dönüştürüp döndürme
      return User.fromMap(result.first);
    } else {
      return null;  // Kullanıcı bulunamazsa null döndürülür
    }
  }


  // Giriş yapan kullanıcıyı getirme
  Future<User?> getLoggedInUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'user',
      where: 'isLoggedIn = ?',
      whereArgs: [1], // Giriş yapmış kullanıcıyı bulmak için isLoggedIn = 1
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }


  // Veritabanında e-posta ve şifre ile kullanıcı sorgulama
  Future<User?> getUserByEmailAndPassword(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'user',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password], // E-posta ve şifreye göre sorgu
    );

    if (maps.isNotEmpty) {
      print(maps.first.toString()); // Burada maps.first kullanılabilir
      return User.fromMap(maps.first); // Eşleşen kullanıcıyı döndür
    }

    print("kullanıcı bulunamadı");
    return null; // Kullanıcı bulunamadıysa null döndür
  }


  // Kullanıcı girişini güncelleme
  Future<void> loginUser(User user) async {
    user.isLoggedIn = 1; // Giriş yaptıysa isLoggedIn'ı true yapıyoruz
    await updateUser(user); // Kullanıcıyı güncelle
  }


  // Kullanıcı çıkışı
  Future<void> logoutUser(User user) async {
    user.isLoggedIn = 0; // Çıkış yaptıysa isLoggedIn'ı false yapıyoruz
    await updateUser(user); // Kullanıcıyı güncelle
  }


  // Veritabanını silme (Opsiyonel olarak, debugging amacıyla kullanabilirsiniz)
  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user.db');
    await deleteDatabase(path);
    print("Veritabanı silindi");
  }



  // Kullanıcı notunu güncelleyen metod
  Future<void> updateUserNote(User user, String newContent, int noteIndex) async {
    // Kullanıcının notlar listesindeki belirli bir notu güncelle
    if (user.note.isNotEmpty && noteIndex < user.note.length) {
      // Mevcut notu güncelle
      user.note[noteIndex].content = newContent;

      // Güncellenen kullanıcıyı veritabanına kaydet
      await updateUser(user);
      print("Kullanıcı notu güncellendi: $newContent");
    } else {
      print("Geçerli bir not bulunamadı.");
    }
  }



  Future<List<int>> getUserListByType(User user, String type) async {
    // Hangi listeyi döndüreceğimizi anlamak için type parametresini kontrol edelim
    switch (type) {
      case 'Ana Yemekler':
        return user.anaYemeklerList;
      case 'baslangic_corbalar':
        return user.baslangiclar_corbalarList;
      case 'baslangic_denizUrunleri':
        return user.baslangiclar_denizUrunleriList;
      case 'baslangic_hamurIsleri':
        return user.baslangiclar_hamurIsleriList;
      case 'baslangic_mezeler':
        return user.baslangiclar_mezelerList;
      case 'baslangic_salatalar':
        return user.baslangic_salatalarList;
      case 'baslangic_zeytinyaglilar':
        return user.baslangiclar_zeytinyaglilarList;
      case 'Fast-Food':
        return user.fastFoodList;
      case 'Kahvaltılıklar':
        return user.kahvaltiliklerList;
      case 'Tatlılar':
        return user.tatlilerList;
      case 'yanLezzet_makarnalar':
        return user.yanLezzetler_makarnalarList;
      case 'yanLezzet_pilavlar':
        return user.yanLezzetler_pilavlarList;
      case 'yanLezzet_sebzeVEPure':
        return user.yanLezzetler_sebzeVEPureList;
      case 'yanLezzet_soslarVeDipler':
        return user.yanLezzetler_soslarVeDiplerList;
      default:
        throw Exception("Geçersiz type değeri: $type");
    }

  }


  Future<void> printAllUsers() async {
    final db = await database;

    // Tüm kullanıcıları sorgula
    final List<Map<String, dynamic>> users = await db.query('user');

    // Eğer kullanıcı varsa, her birini yazdır
    if (users.isNotEmpty) {
      for (var user in users) {
        print('Kullanıcı:');
        print('İsim: ${user['name']}');
        print('Email: ${user['email']}');
        print('Şifre: ${user['password']}');
        print('Giriş Durumu: ${user['isLoggedIn']}');
        print('-------------------------------------');
      }
    } else {
      print('Veritabanında kullanıcı bulunamadı.');
    }
  }

  Future<void> removeMealFromTheSpesificList(User user,Meal meal) async{

      if (meal.type == "Ana Yemekler") {
        user.anaYemeklerList.remove(meal.id);
      } else if (meal.type == "baslangic_corbalar") {
        user.baslangiclar_corbalarList.remove(meal.id);
      } else if (meal.type == "baslangic_denizUrunleri") {
        user.baslangiclar_denizUrunleriList.remove(meal.id);
      } else if (meal.type == "baslangic_hamurIsleri") {
        user.baslangiclar_hamurIsleriList.remove(meal.id);
      } else if (meal.type == "baslangic_mezeler") {
        user.baslangiclar_mezelerList.remove(meal.id);
      } else if (meal.type == "baslangic_salatalar") {
        user.baslangic_salatalarList.remove(meal.id);
      } else if (meal.type == "baslangic_zeytinyaglilar") {
        user.baslangiclar_zeytinyaglilarList.remove(meal.id);
      } else if (meal.type == "Fast-Food") {
        user.fastFoodList.remove(meal.id);
      } else if (meal.type == "Kahvaltılıklar") {
        user.kahvaltiliklerList.remove(meal.id);
      } else if (meal.type == "Tatlılar") {
        user.tatlilerList.remove(meal.id);
      } else if (meal.type == "yanLezzet_makarnalar") {
        user.yanLezzetler_makarnalarList.remove(meal.id);
      } else if (meal.type == "yanLezzet_pilavlar") {
        user.yanLezzetler_pilavlarList.remove(meal.id);
      } else if (meal.type == "yanLezzet_sebzeVEPure") {
        user.yanLezzetler_sebzeVEPureList.remove(meal.id);
      } else if (meal.type == "yanLezzet_soslarVeDipler") {
        user.yanLezzetler_soslarVeDiplerList.remove(meal.id);
      } else {
        print("Geçersiz bir type verilmiş eşleşme bulunamadı");
      }
      await DbHelper().updateUser(user);


  }

}
