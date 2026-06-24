import 'package:dranzerx/pallete.dart';
import 'package:flutter/material.dart';

class FeaturesBox extends StatelessWidget {
  const FeaturesBox({super.key, required this.color, required this.headerText, required this.descriptionText});

  final Color color;
  final String headerText;
  final String descriptionText;

  @override
  Widget build(context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
      decoration: BoxDecoration(color: color,
      borderRadius: BorderRadius.all(Radius.circular(15),),),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15)
            .copyWith(left: 11),
        child: Column(children: [

          Align(
            alignment: Alignment.centerLeft,
            child: Text(headerText, style:
              TextStyle(fontFamily: 'RobotoSlab',
              color: Pallete.blackColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),),
          ),

          SizedBox(height: 3,),

          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Text(descriptionText, style:
            TextStyle(fontFamily: 'RobotoSlab',
              color: Pallete.blackColor,
            ),),
          ),
        ],),
      ),
    );
  }
}
