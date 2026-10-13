import 'package:flutter/material.dart';

class LatihanDua extends StatelessWidget {
  const LatihanDua({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        height: 200,
        margin: EdgeInsets.all(30),
        padding: EdgeInsets.all(10),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey, width: 2.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Nama: Galang", style: TextStyle(fontSize: 20, color: Colors.white)),
                  Text("NISN: 1234567890", style: TextStyle(fontSize: 20, color: Colors.white)),
                  Text("Kelas: 12 RPL 1", style: TextStyle(fontSize: 20, color: Colors.white)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                    image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRucqrxbuufrbr_PVgrOGmmwsxaXjQUfTTutGguxeqHsikobFwEUm1lVG8Y&s=10",
                    ),
                    fit: BoxFit.cover,
                  ),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey, width: 2.0)
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}