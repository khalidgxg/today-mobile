import 'package:flutter/material.dart';
import 'package:today/features/widgets/CategoryCard.dart';
import '../domain/entities/category.dart';

/// A widget that displays a list of categories.
class CategoryListView extends StatelessWidget {
  final List<Category> categories;
  final void Function(String categoryId, String categoryName) onCategoryTap;

  const CategoryListView({super.key, required this.categories, required this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0,right: 0),
      padding: EdgeInsets.all(0), 
      child:  GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
     
      ),
      padding: const EdgeInsets.all(0),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Container(
            margin: EdgeInsets.all(0),
              child: Row(
                children: [
                Flexible(
                  flex: 1,
                  child: CategoryCard(
                      name: category.name,
                      description: category.description,
                      color: category.color,
                      backgroundColor:category.backgroundColor,
                      imageUrl:category.imageUrl,
                      onCardTap: (id, name) => onCategoryTap(category.id, category.name)
                      ),
                ),
               
              ]),
            );
      //  Card(
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        //   elevation: 4,
        //   child: Padding(
        //     padding: const EdgeInsets.all(16.0),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         // Image at the top
        //         category.imageUrl != null
        //             ? Image.network(
        //                 category.imageUrl!,
        //                 width: 48,
        //                 height: 48,
        //                 fit: BoxFit.cover,
        //                 errorBuilder: (context, error, stackTrace) =>
        //                     const Icon(Icons.image_not_supported, size: 48),
        //               )
        //             : const SizedBox(
        //                 width: 48,
        //                 height: 48,
        //                 child: Icon(Icons.category, size: 48),
        //               ),
        //         const SizedBox(height: 12),
        //         // Title (e.g., BASIC Python)
        //         Text(
        //           category.name,
        //           style: const TextStyle(
        //             fontFamily: 'Cairo',
        //             fontSize: 18,
        //             fontWeight: FontWeight.bold,
        //           ),
        //           textAlign: TextAlign.center,
        //           maxLines: 2,
        //           overflow: TextOverflow.ellipsis,
        //         ),
        //         const SizedBox(height: 8),
        //         // Duration (e.g., 7-30 Days)
        //         Text(
        //           '7-30 Days',
        //           style: const TextStyle(
        //             fontSize: 14,
        //             color: Colors.grey,
        //           ),
        //         ),
        //         const Spacer(),
        //         // Start button at the bottom
        //         SizedBox(
        //           width: double.infinity,
        //           child: ElevatedButton(
        //             onPressed: () {},
        //             style: ElevatedButton.styleFrom(
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(24),
        //               ),
        //               backgroundColor: Colors.grey[800],
        //             ),
        //             child: const Text('Start'),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // );
      },
    ),
    );
  }
} 