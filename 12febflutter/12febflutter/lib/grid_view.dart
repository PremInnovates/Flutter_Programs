import 'package:flutter/material.dart';
import 'package:flutter_application_1_10feb/app_scaffold.dart';

class GridViewDemo extends StatefulWidget {
  const GridViewDemo({super.key});

  @override
  State<GridViewDemo> createState() => _GridViewDemoState();
}

class _GridViewDemoState extends State<GridViewDemo> {
  List<String> images = ["assets/image/a.jpg","assets/image/b.jpg","assets/image/c.jpg","assets/image/d.jpg","assets/image/e.jpg","assets/image/f.jpg","assets/image/g.jpg","assets/image/h.jpg","assets/image/y.jpg","assets/image/z.jpg"];
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      mychildren: GridView.builder(itemCount: images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
         itemBuilder: (context, index) {
        return Image.asset(images[index],fit:BoxFit.cover);
      },)
    );

      ///////////////////
    // mychildren: 
  //  GridView(
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4
    // , crossAxisSpacing: 10, mainAxisSpacing: 10),

    // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200),
    // children: [
    //   Image.asset("assets/images/a.jpg",fit:BoxFit.cover),
    //   Image.asset("assets/images/c.webp",fit:BoxFit.cover),
    //   Image.asset("assets/images/a.jpg",fit:BoxFit.cover),
    //   Image.asset("assets/images/d.jpg",fit:BoxFit.cover),
    //   Image.asset("assets/images/e.jpeg",fit:BoxFit.cover),
    //   Image.asset("assets/images/a.jpg",fit:BoxFit.cover),
    //   Image.asset("assets/images/d.jpg",fit:BoxFit.cover),
    //   Image.asset("assets/images/e.jpeg",fit:BoxFit.cover),
    //   Image.asset("assets/images/a.jpg",fit:BoxFit.cover),
    // ],
    // )
    // );
  }
}