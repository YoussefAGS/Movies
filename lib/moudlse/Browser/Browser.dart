import 'package:flutter/material.dart';
import 'package:movise/models/Categoryt.dart';

import '../../shared/network/remote/api_manager.dart';
import 'browseItem.dart';

class BrowserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Browse Category',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
          SizedBox(height: 10,),
          FutureBuilder<MoviesCaregory>(
            future: ApiManager.getCategory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              var category = snapshot.data?.genres ?? [];
              print(category.length);
              return Expanded(
                child: GridView.builder(
                    itemCount: category.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6
                    ),
                    itemBuilder: (context, index) => BrowserItem(category[index])),
              );
            },
          ),
        ],
      ),
    );

    // return Container(
    //   color: Colors.red,
    //   // child: Expanded(
    //   //   child: GridView.builder(
    //   //       itemCount: category.length,
    //   //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //   //         crossAxisCount: 2,
    //   //         mainAxisSpacing: 12,
    //   //         crossAxisSpacing: 12,
    //   //       ),
    //   //       itemBuilder: (context, index) =>
    //   //           InkWell(
    //   //               onTap: (){selectedCategory(category[index]);},
    //   //               child: CategoryItem(category[index], index))
    //   //   ),
    //   // )
    //   ,
    // );
  }
}
