import 'package:flutter/material.dart';

class BuildingRowMethodsForTwoComponent {
  // Tek bir kart oluşturan metod
  static Widget buildImageCard({
    required String imagePath,
    required String text,
    required Widget page,
    required BuildContext context,
  }) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: GestureDetector(//kullanıcı etkılesımlerine duyarlı bir arayuz yapabilmek için  kullanıldım
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Ortada hizalama
            crossAxisAlignment: CrossAxisAlignment.center, // Ortada hizalama
            children: <Widget>[
              ClipRRect(//belirli bir dıkdortgen alan oluşturmak ıcın
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: 150, // Sabit genişlik
                  height: 100, // Sabit yükseklik
                ),
              ),
              SizedBox(height: 5),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // İki kartı bir satırda oluşturan metod
  static Widget buildRow({
    required String leftImage,
    required String leftText,
    required Widget leftPage,
    required String rightImage,
    required String rightText,
    required Widget rightPage,
    required BuildContext context,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildImageCard(
          imagePath: leftImage,
          text: leftText,
          page: leftPage,
          context: context,
        ),
        SizedBox(width: 5),
        buildImageCard(
          imagePath: rightImage,
          text: rightText,
          page: rightPage,
          context: context,
        ),
      ],
    );
  }
}
