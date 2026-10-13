import 'package:flutter/material.dart';

class Layout4 extends StatelessWidget {
  const Layout4({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(height: 140, color: Colors.blue),
            Positioned(
              bottom: -30,
              left: 20,
              child: SizedBox(
                width: 80,
                height: 80,
                child: CircleAvatar(
              backgroundColor: Colors.blue,
              backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRucqrxbuufrbr_PVgrOGmmwsxaXjQUfTTutGguxeqHsikobFwEUm1lVG8Y&s=10',),
              ),
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('Langsss'), Text('THE BLACKIEST BLACK MAN ALIVE')],
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text('Follow'),
        ),
      ],
    );
  }
}