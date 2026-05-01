<div align="center">

<img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
<img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
<img src="https://img.shields.io/badge/SQLite-003B57?style=for-the-badge&logo=sqlite&logoColor=white" />
<img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" />

<br/><br/>

# 🍽️ Meal Planner App

**Mutfağını organize et, sağlıklı yaşa, ne pişireceğini bilmek için artık düşünme.**

*A comprehensive meal planning & recipe management application built with Flutter*

</div>

---

## 📖 About

Meal Planner App, kullanıcıların yemek planlamasını ve hazırlığını kolaylaştırmak için geliştirilmiş kapsamlı bir mobil uygulamadır. Uygulama; çeşitli tarifler sunarak, sağlıklı seçimler için kalori hesaplama yaparak, kişiselleştirilmiş not alma alanı ve favori yemekleri kaydetme özelliğiyle mutfak deneyimini daha keyifli hale getirir.

Benzersiz **"Bugün ne pişireyim?"** menü oluşturma özelliğiyle yemek saatlerini daha eğlenceli ve zahmetsiz hale getirir.

---

## ✨ Features

| Özellik | Açıklama |
|---|---|
| 🏠 **Ana Sayfa** | Temel yemek kategorileri ve hızlı içerik erişimi |
| 📝 **Notlar** | Alışveriş listeleri ve kişisel tariflerin saklandığı alan |
| 🔥 **Kalori Hesaplama** | Tariflerinizin kalori değerini hesaplayın |
| ❤️ **Favoriler** | Beğendiğiniz tarifleri kaydedin, kolayca erişin |
| 🎡 **Menü Oluşturucu** | "Ne pişireyim?" sorusuna çarkıfelek cevabı! |

---

## 📱 Screens

Uygulama **15+** ekran içermekte olup tüm geçişler `MaterialPageRoute` ile sağlanmaktadır.

```
📂 lib/
 ├── screens/
 │    ├── home/           → Ana sayfa & kategori listeleme
 │    ├── notes/          → Not ekleme, düzenleme, silme
 │    ├── calories/       → Kalori hesaplama ekranı
 │    ├── favorites/      → Favori tarifler
 │    └── menu_builder/   → Günlük menü oluşturucu (çarkıfelek)
 ├── models/             → Veri modelleri
 ├── database/           → SQLite yönetimi
 └── widgets/            → Tekrar kullanılabilir bileşenler
```

---

## 📸 Screenshots

<div align="center">

<img src="https://github.com/user-attachments/assets/73748f03-19f3-4585-990c-8d224c4bbe6c" width="200" />
<img src="https://github.com/user-attachments/assets/80eea3c7-3139-4375-9ae6-39d049992e07" width="200" />
<img src="https://github.com/user-attachments/assets/54b36e97-da66-4ef1-8181-2167f8e3c37a" width="200" />
<img src="https://github.com/user-attachments/assets/e6dd40f6-a3b8-4850-936b-b7709a06becf" width="200" />
<img src="https://github.com/user-attachments/assets/ce087048-62f9-4022-8b6e-740f5c5bf94d" width="200" />
<img src="https://github.com/user-attachments/assets/5142998a-77ee-46b6-8cee-81a88acb8b5e" width="200" />
<img src="https://github.com/user-attachments/assets/6dab9070-6435-4b74-899e-f4820c96215c" width="200" />
<img src="https://github.com/user-attachments/assets/a2895591-0416-440a-83e1-df9f8808d574" width="200" />
<img src="https://github.com/user-attachments/assets/aa636fcc-3af9-452b-bcf6-fb03191294a3" width="200" />
<img src="https://github.com/user-attachments/assets/5a9edf32-e55f-4661-863b-2a7c31cf1e51" width="200" />
<img src="https://github.com/user-attachments/assets/a467dfdc-c997-4b9a-b6e9-0db4ff49a55a" width="200" />
<img src="https://github.com/user-attachments/assets/7eed0854-c164-4c69-b0bd-4ebf647d8dab" width="200" />

</div>

---

## 🛠️ Tech Stack

- **Flutter** — Cross-platform UI framework
- **SQLite** (`sqflite`) — Offline veri depolama
- **Firebase Cloud Messaging** — Push notification desteği *(planlanan)*
- **Material Design** — UI tasarım prensibi

---

## 🎨 Design System

```
🎨 Color Palette
├── Primary    →  Pink tones   (sıcak & davetkar atmosfer)
├── Secondary  →  Green tones  (sağlık & tazelik)
├── Background →  White        (temiz & minimal)
└── Accent     →  Pastel shades (yumuşak vurgular)

🔤 Typography
├── Headings   →  Bold & large fonts
└── Body       →  Medium, plain & readable

🧭 Navigation
├── Bottom Navigation Bar  →  5 ana sekme
├── Drawer Widget          →  Ek menü erişimi
└── MaterialPageRoute      →  Ekranlar arası geçiş
```

---

## 🗃️ Database

Uygulama **SQLite** kullanarak offline-first bir deneyim sunar:

- ✅ Favori tarifler
- ✅ Kullanıcı notları & alışveriş listeleri
- ✅ Oluşturulan günlük menüler

> Tüm veriler cihazda yerel olarak saklanır. İnternet bağlantısı gerektirmez.

---

## 🔔 Notifications

Kullanıcı tarafından belirlenen saatte push notification gönderilir ve günlük menü oluşturmak için hatırlatma yapılır. Bu özellik yemek planlamasını daha eğlenceli ve motive edici hale getirir.

*(Firebase Cloud Messaging entegrasyonu ile ilerleyen versiyonlarda aktif edilecektir.)*

---

## 🚀 Getting Started

```bash
# Repoyu klonlayın
git clone https://github.com/kullanici-adi/meal-planner-app.git

# Proje dizinine girin
cd meal-planner-app

# Bağımlılıkları yükleyin
flutter pub get

# Uygulamayı çalıştırın
flutter run
```

**Gereksinimler:**
- Flutter SDK `>=3.0.0`
- Dart `>=3.0.0`
- Android Studio veya VS Code

---

## 🗺️ Roadmap

- [x] Ana sayfa & kategori yapısı
- [x] Not alma modülü (SQLite)
- [x] Kalori hesaplama ekranı
- [x] Favoriler sistemi
- [x] Menü oluşturucu (çarkıfelek)
- [ ] Firebase entegrasyonu
- [ ] Push notification sistemi
- [ ] Çoklu dil desteği *(v2.0)*
- [ ] Bulut veri senkronizasyonu *(v2.0)*

---

## 📄 License

Bu proje akademik amaçlarla geliştirilmiştir.

---

<div align="center">

Made with ❤️ using Flutter

</div>
