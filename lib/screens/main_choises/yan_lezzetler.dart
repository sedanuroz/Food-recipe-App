import 'package:flutter/material.dart';
import 'package:yemek_dunyasi/screens/yan_lezzetler/garniturler.dart';
import 'package:yemek_dunyasi/screens/yan_lezzetler/makarnalar.dart';
import 'package:yemek_dunyasi/screens/yan_lezzetler/pilavlar.dart';
import 'package:yemek_dunyasi/screens/yan_lezzetler/soslarveDipler.dart';

import '../bottom_bars_choises/main_page.dart';
import '../bottom_bars_choises/favorite/favoritePage.dart';
import '../bottom_bars_choises/note/notePage.dart';
import '../bottom_bars_choises/calculate/calculateCalPage.dart';
import '../bottom_bars_choises/cycle/cyclePage.dart';

import 'package:yemek_dunyasi/screens/importantMetods/buildingRowMethodsFor_two_Component.dart';


import 'package:yemek_dunyasi/screens/importantMetods/HeaderMethod.dart'; // Yeni import

class YanLezzetlerPage extends StatefulWidget {
  @override
  _YanLezzetlerPageState createState()=>_YanLezzetlerPageState();
}

class _YanLezzetlerPageState extends State<YanLezzetlerPage>{
  int _curIndex=2;

  final List<Widget> _pages = [
    FavoritePage(),
    NotePage(),
    MainPage(),
    CalculateCalPage(),
    CyclePage(),
  ];

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFF7F6E3),

      body: IndexedStack(
        index:_curIndex,
        children:[
          FavoritePage(),
          NotePage(),
          _buildYanLezzetlerBody(),
          CalculateCalPage(),
          CyclePage(),
        ],
      ),
    );
  }


  Widget _buildYanLezzetlerBody(){
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only( left: 6, right: 6),
            child: Column(
              children: [

                HeaderMethod(
                  title: "YAN LEZZETLER",
                  topPadding: 35.0,
                  leftPadding: 20.0,
                  rightPadding: 20.0,
                  horizontalPadding: 15.0,
                  verticalPadding: 10.0,
                  fontSize: 25.0,
                  borderRadius: 25.0,
                  spacing: 20.0,
                ),


                Column(
                  children: [
                    // BuildingRowMethodsForTwoComponent sınıfından buildRow çağrılıyor
                    BuildingRowMethodsForTwoComponent.buildRow(
                      leftImage: 'assets/images/pilavlar.png',
                      leftText: "PİLAVLAR",
                      leftPage: Pilavlar(),
                      rightImage: 'assets/images/makarnalar.png',
                      rightText: "MAKARNALAR",
                      rightPage: Makarnalar(),
                      context: context,
                    ),

                    BuildingRowMethodsForTwoComponent.buildRow(
                      leftImage: 'assets/images/garnitur.png',
                      leftText: "   PÜRELER VE \n GARNİTÜRLER",
                      leftPage: Garniturler(),
                      rightImage: 'assets/images/soslar.png',
                      rightText: "   SOSLAR VE\n      DİPLER",
                      rightPage: Soslar_ve_Dipler(),
                      context: context,
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }

}

