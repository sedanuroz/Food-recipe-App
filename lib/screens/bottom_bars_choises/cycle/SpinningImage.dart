import 'package:flutter/material.dart';
import 'package:yemek_dunyasi/screens/bottom_bars_choises/cycle/MenuScreen.dart';

class SpinningImage extends StatefulWidget {
  @override
  _SpinningImageState createState() => _SpinningImageState();
}

class _SpinningImageState extends State<SpinningImage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isMenuVisible = false; // Menü başlangıçta gizli
  bool _isSpinningCompleted = false; // Döndürme tamamlandı mı?

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,// animasyonu başlatan widget  içinde bulunan TickerProvider'a işaret eder
      duration: Duration(seconds: 9), // Toplamda 9 saniye sürecek
    );

    // İlk 3 saniye yavaş, sonraki 3 saniye hızlı, son 3 saniye tekrar yavaş olacak şekilde animasyon
    _animation = TweenSequence<double>([
      TweenSequenceItem(
        weight: 1.0,//agırlık yanı ne kadar sureceğini belirler
        tween: Tween<double>(begin: 0, end: 2 * 3.14159).chain(CurveTween(curve: Curves.easeIn)), // İlk 3 saniye yavaş
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: Tween<double>(begin: 2 * 3.14159, end: 8 * 3.14159).chain(CurveTween(curve: Curves.linear)), // Sonraki 3 saniye hızlı
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: Tween<double>(begin: 8 * 3.14159, end: 10 * 3.14159).chain(CurveTween(curve: Curves.easeOut)), // Son 3 saniye yavaş
      ),
    ]).animate(_controller);

    //Dinleyici, animasyonun durumunun (state) her değiştiğinde tetiklenir.
    // Örneğin, animasyon başlatıldığında, durduğunda veya tamamlandığında dinleyici tetiklenir.
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isMenuVisible = true; // Animasyon tamamlandı, menüyü görünür yap
          _isSpinningCompleted = true; // Döndürme tamamlandı
        });
      }
    });
  }

  //dispose() metodu, widget'ın yaşam döngüsünün sonlandığı
  // widget'ın tamamen ekrandan kaldırılmadan önce kullanılmadığı kaynakların temizlendiği bir aşamadır.
  // Bu, özellikle animasyonlar,listeners, stream'ler, ya da diğer dış kaynakları kullanan widget'lar için çok önemlidir.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startSpin() {
    setState(() {
      _isSpinningCompleted = false; // Döndürme başlatıldı, tamamlanmadı
      _isMenuVisible = false; // Spin başlatıldığında menüyü gizle
    });
    _controller.reset(); //Amacı: Animasyonu sıfırlar ve başlangıç durumuna getirir.
    //asıl donmesını saglayan komut
    _controller.forward(); // , animasyonu başlatır ve belirtilen süre boyunca ileriye doğru hareket eder
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F6E3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            //belirli bir olay gerçekleştiğinde bir callback fonksiyonunu tetiklemeye olanak tanır.
            child: GestureDetector(
              onTap: _startSpin, // Resme tıklayarak da döndürme seçeneği
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(// Bu widget, içinde barındırdığı öğeyi belirli bir açıya göre döndürür.
                    angle: _animation.value,
                    child: child,
                  );
                },
                child: Image.asset('assets/çark.png', width: 300, height: 300), // Çark resmi
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _startSpin,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFFADAF),
              foregroundColor: Colors.black,
              side: BorderSide(color: Colors.white, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            child: Text(_isSpinningCompleted ? "Tekrar Çevir" : "Çevirmeye Başla"),
          ),
          SizedBox(height: 20),
          //bir widget'ı koşula bağlı olarak görünür veya görünmez yapmak için kullanılan bir widget'tır
          Visibility(
            visible: _isMenuVisible,
            child: Expanded(
              child: MenuScreen(),
            ),
          ),
        ],
      ),
    );
  }
}
