import 'package:flutter/material.dart';
import 'package:flutter_galang_12rpl1/list_grid_view/GridProductPage.dart';

class NavigatorWidget extends StatelessWidget {
  const NavigatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return GridProductPage();
                },
              ),
            );
          },
          child: Text('grid'),
        ),
      ],
    );
  }
}