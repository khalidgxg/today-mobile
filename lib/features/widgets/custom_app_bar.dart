import 'package:flutter/material.dart';
import 'package:today/features/domain/entities/choice.dart';

/// A custom AppBar widget with the standard app styling.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;

  // Define the standard green color
  static const Color _primaryGreen = Color(0xFF77A69D);

  const CustomAppBar({
    super.key,
    this.title = 'سحر اليوم', // Default title
    this.backgroundColor = _primaryGreen, // Default color
    this.centerTitle = true,
    this.automaticallyImplyLeading = false,
    this.actions,
  });

  static const List<Choice> choices = <Choice>[
    Choice(title: 'القائمة', icon: Icons.category),
    Choice(title: 'المفضلات', icon: Icons.favorite),
  ];

  // إنشاء شريط التبويب
  PreferredSizeWidget get _buildTabBar {
    return TabBar(
      isScrollable: true,
      tabs: choices.map<Widget>((Choice choice) {
        return Tab(
          text: choice.title,
          icon: Icon(choice.icon),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Cairo', // Ensure font is applied
          color: Colors.white,
        ),
      ),
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      actions: actions,
      bottom: _buildTabBar,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      kToolbarHeight + _buildTabBar.preferredSize.height); // Include TabBar height
} 