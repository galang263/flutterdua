import 'package:flutter/material.dart';

class LatihanContainer extends StatelessWidget {
  const LatihanContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 300,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(15),
      alignment: Alignment.center,
      decoration: BoxDecoration(  
         color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color.fromARGB(255, 76, 174, 79),
          width: 2,
        ),
      ),
      child: Container(
        height: 60,
        width: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 232, 211, 51),),
        child: Text(
          "SMK ASSALAAM BANDUNG",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}