import 'package:flutter/material.dart';

class Latihan3 extends StatelessWidget {
  const Latihan3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(child: Text('pemasukan', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(child: Text('pengeluaran', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)),
            ),
          ),
          SizedBox(width: 10),
           Expanded(
            flex: 1,
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(child: Text('saldo', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}