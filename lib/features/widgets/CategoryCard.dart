import 'package:flutter/material.dart';
import '../screens/category_show_screen.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.name,
    this.color,
    this.backgroundColor,
    required this.description,
    this.imageUrl,
    required this.onCardTap,
  }) : super(key: key);

  final String name;
  final String? imageUrl;
  final Color? color;
  final Color? backgroundColor;
  final String description;
  final void Function(String categoryId, String categoryName) onCardTap;

  @override
  Widget build(BuildContext context) {
    final String currentCategoryId = name;

    return InkWell(
      onTap: () {
        onCardTap(currentCategoryId, name);
      },
      child:  Container(
        height: 100,
          child: Card(
              color: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                 Expanded(

                  child: Align(
                    alignment: Alignment.center,
                    child: Container(

                      child: (imageUrl != null && imageUrl!.isNotEmpty)
                          ? Image.network(
                              imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.broken_image, size: 140);
                              },
                            )
                          : Icon(Icons.image_not_supported, size: 120),
                    ),
                  ),
                 ),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  Container(
                    margin:EdgeInsets.fromLTRB(0,2,10,6),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                          fontSize: 17,
                          color: color,
                          fontFamily: 'MontserratBold'),
                    ),
                  ),

                  Container(
                    margin:EdgeInsets.fromLTRB(0,0,10,0),
                    child: Text(
                      description,
                      style: TextStyle(
                          fontSize: 13,
                          color: color,
                          fontFamily: 'MontserratLight'),
                    ),
                  ),
              const SizedBox(height: 20),
])
                ],
              )),

      ),
    );
  }
}
