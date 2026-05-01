import 'package:flutter/material.dart';
import 'package:yemek_dunyasi/screens/importantMetods/HeaderMethod.dart';
import 'package:yemek_dunyasi/screens/bottom_bars_choises/note/note.dart';
import 'package:yemek_dunyasi/aboutUsers/dbHelper.dart'; // DbHelper sınıfını import et
import 'package:yemek_dunyasi/aboutUsers/users.dart'; // User modelini import et

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  List<Note> notes = []; // Notları saklamak için liste
  int noteIdCounter = 0; // Her not için benzersiz ID

  @override
  void initState() {
    super.initState();
    loadUserNotes(); // Sayfa açıldığında veritabanındaki notları yükle
  }

  Future<void> loadUserNotes() async {
    User? user = await DbHelper().getLoggedInUser();
    if (user != null && user.note != null) {
      setState(() {
        notes = user.note; // Kullanıcının notlarını listeye yükle
      });
    }
  }

  void addNoteField() {
    setState(() {
      notes.add(Note(
        id: noteIdCounter++,
        content: "",
        controller: TextEditingController(),
      ));
    });
  }

  Future<void> saveNoteToDatabase(int id, String text) async {

    User? user = await DbHelper().getLoggedInUser();
    if (user != null) {
      user.note = notes;
      await DbHelper().updateUser(user); // Kullanıcıyı güncelle
      print("Not kaydedildi: ID: $id, İçerik: $text");
    }
  }

  Future<void> deleteNoteFromDatabase(int id) async {
    setState(() {
      notes.removeWhere((note) => note.id == id); // Notu listeden kaldır
    });

    User? user = await DbHelper().getLoggedInUser();
    if (user != null) {
      user.note = notes;
      await DbHelper().updateUser(user); // Kullanıcıyı güncelle
      print("Not silindi: ID: $id");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6E3), // Arka plan rengi
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeaderMethod(
              title: "NOTLARIM",
              topPadding: 0.0,
              leftPadding: 60.0,
              rightPadding: 60.0,
              horizontalPadding: 15.0,
              verticalPadding: 10.0,
              fontSize: 25.0,
              borderRadius: 25.0,
              spacing: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: GestureDetector(
                onTap: addNoteField, // Yeni not ekleme fonksiyonu
                child: Image.asset(
                  'assets/images/not.png', // Yeni not ekleme resmi
                  height: 150, // Resim boyutu
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: notes.isEmpty
                  ? const Center(
                child: Text(
                  "Henüz bir not eklenmedi.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              )
                 : ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: const Color(0xFFb1d1b7), // Kart arka plan rengi
                      elevation: 5, // Gölge efekti
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextField(
                              controller: note.controller,
                              decoration: InputDecoration(
                                //kullanıcı metin girişi yapmadan önce görünmesi gereken ipucu metnini belirler
                                hintText: note.content.isEmpty
                                    ? "Notunuzu buraya yazın..."
                                    : note.content,
                                hintStyle: const TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xFF326E62)),
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF7F6E3),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.black, width: 2.5),
                                ),
                              ),
                              onChanged: (value) {
                                note.content = value;
                              },
                              maxLines: null, // Otomatik olarak satır sarmasını sağlar
                              keyboardType: TextInputType.multiline, // Çok satırlı metin girişine izin verir
                              textInputAction: TextInputAction.newline, // Yeni satır için ayar

                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    saveNoteToDatabase(note.id, note.content);//bunu cagırdıgımızda sadeceatama yapılıyor aslında
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Not kaydedildi."),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: const Color(0xFF326E62),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text("Kaydet"),
                                ),
                                const SizedBox(width: 10),
                                OutlinedButton(

                                  onPressed: () {
                                    deleteNoteFromDatabase(note.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Not silindi."),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    side: const BorderSide(color: Colors.black),
                                    backgroundColor: const Color(0xFFf4cbc2),
                                  ),
                                  child: const Text("Sil"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}