import 'package:flutter/material.dart';

class Layout1 extends StatelessWidget {
  const Layout1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 75,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[300],
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 6)],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRucqrxbuufrbr_PVgrOGmmwsxaXjQUfTTutGguxeqHsikobFwEUm1lVG8Y&s=10',),
              ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('larfleeze'),
                SizedBox(height: 4),
              Text('ORANGE LANTERN CORPS', style: TextStyle(fontSize: 12, color: Colors.grey[700]),),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}