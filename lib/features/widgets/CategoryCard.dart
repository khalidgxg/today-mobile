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
      child: SizedBox(
        height: 280,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Card(
              color: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                 Container( 
                  margin: EdgeInsets.all(0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 150,
                      child: (imageUrl != null && imageUrl!.isNotEmpty)
                          ? Image.network(
                              imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.broken_image, size: 120);
                              },
                            )
                          : Icon(Icons.image_not_supported, size: 120),
                    ),
                  ),
                 ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 140, 10, 0),
                    child: Text(
                      name,
                      style: TextStyle(
                          fontSize: 14,
                          color: color,
                          fontFamily: 'MontserratBold'),
                    ),
                  ),
                 
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 160, 10, 0),
                    child: Text(
                      description,
                      style: TextStyle(
                          fontSize: 10,
                          color: color,
                          fontFamily: 'MontserratLight'),
                    ),
                  ),
                 
                ],
              )),
        ),
      ),
    );
  }
}
