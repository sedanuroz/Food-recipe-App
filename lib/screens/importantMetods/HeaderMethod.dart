import 'package:flutter/material.dart';

class HeaderMethod extends StatelessWidget {
  final String title; // Başlık parametresi
  final double topPadding; // Üst boşluk
  final double leftPadding; // Sol boşluk
  final double rightPadding; // Sağ boşluk
  final double horizontalPadding; // Yatay dolgu
  final double verticalPadding; // Dikey dolgu
  final double fontSize; // Yazı boyutu
  final double borderRadius; // Köşe yuvarlaklığı
  final double spacing; // Başlık altındaki boşluk

  const HeaderMethod({
    Key? key,
    required this.title, // Zorunlu başlık parametresi
    this.topPadding = 20.0,
    this.leftPadding = 6.0,
    this.rightPadding = 6.0,
    this.horizontalPadding = 10.0,
    this.verticalPadding = 10.0,
    this.fontSize = 27.0,
    this.borderRadius = 20.0,
    this.spacing = 30.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topPadding,
        left: leftPadding,
        right: rightPadding,
      ),
      child: Column(
        children: [
          // Buton gibi görünen metin (tıklanabilir değil)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            decoration: BoxDecoration(
              color: Color(0xFF326E62),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Center( // Metni kutu içinde ortalamak için Center kullanıyoruz
              child: Text(
                title, // Parametreyi burada kullanıyoruz
                textAlign: TextAlign.center, // Metni ortalamak için
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                  fontFamily: "TanAegean",
                ),
              ),
            ),
          ),
          SizedBox(height: spacing),
        ],
      ),
    );
  }
}
