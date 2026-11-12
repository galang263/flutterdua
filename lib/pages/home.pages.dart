import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/about');
              },
              child: Text('Masuk Profile'),
            ),
             const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/grid-product-page');
              },
              child: Text('Masuk Grid'),
            ),
             const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/List-Screen');
              },
              child: Text('Masuk screen List'),
            ),
             const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ColumnWidget');
              },
              child: Text('Masuk Column Widget'),
            ),
              const SizedBox(height: 8),
               ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/LatihanSatu');
              },
              child: Text('Masuk Latihan Satu'),
            ),
             const SizedBox(height: 8),
               ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/LatihanDua');
              },
              child: Text('Masuk Latihan Dua'),
            ),
            const SizedBox(height: 8),
               ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/form_pages');
              },
              child: Text('form app'),
            ),
            const SizedBox(height: 8),
               ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/input-form');
              },
              child: Text('input'),
            ),
            const SizedBox(height: 8),
               ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/input_eskul');
              },
              child: Text('eskul'),
            ),
             const SizedBox(height: 8),
               ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/main');
              },
              child: Text('Main'),
            ),
            const SizedBox(height: 8),
               ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/album-page');
              },
              child: Text('Fetch API'),
            ),
             const SizedBox(height: 8),
               ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/post-page');
              },
              child: Text('Post Page'),
            ),
            const SizedBox(height: 8),
               ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/photo-page');
              },
              child: Text('Photo Page'),
            ),
          ],
        ),
      ),
    );
  }
}