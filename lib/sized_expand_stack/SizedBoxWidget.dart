import 'package:flutter/material.dart';

class Sizedboxwidget extends StatelessWidget {
  const Sizedboxwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
     child: Column(
      children: [
        Text('baris 1'),
        SizedBox(height: 20),
        Text('baris 2'),

        SizedBox(
          width: 1000,
          height: 25,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Tombol'),
          ),
        ),
      ],
     ),
    );
  }
}