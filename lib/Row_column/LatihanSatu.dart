import 'package:flutter/material.dart';

class LatihanSatu extends StatelessWidget {
  const LatihanSatu({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 550,
        width: 385,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black,
          border: Border.all(
            color: const Color.fromARGB(255, 75, 70, 70),
            width: 2,
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 200,
                width: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRucqrxbuufrbr_PVgrOGmmwsxaXjQUfTTutGguxeqHsikobFwEUm1lVG8Y&s=10",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Text("Nama: Galang", style: TextStyle(fontSize: 20, color: Colors.white)),
                  Text("NISN: 1234567890", style: TextStyle(fontSize: 20, color: Colors.white)),
                  Text("Kelas: 12 RPL 1", style: TextStyle(fontSize: 20, color: Colors.white)),
                ]
              ),
            ],
          ),
      ),
    );
  }
}