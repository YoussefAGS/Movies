import 'package:flutter/material.dart';
import 'package:movise/moudlse/Browser/CategoryList.dart';
import '../../models/Categoryt.dart';

class BrowserItem extends StatelessWidget {
  Genres genres;
  BrowserItem(this.genres);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, CategoryView.routeName,arguments: genres);
      },
      child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/0e34a5e080e8c915030603ddcdb4eeba.png',
                fit: BoxFit.cover,
                height: 120,
                width: 160,
              ),
              Text(
                '${genres.name}', style: TextStyle(color: Colors.white),)
            ],

        ),
    );
  }
}
