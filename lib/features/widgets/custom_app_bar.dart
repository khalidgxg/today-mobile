import 'package:flutter/material.dart';
import 'package:today/features/domain/entities/choice.dart';
import 'app_bar_custom_clipper.dart';

/// A custom AppBar widget with the standard app styling.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;

  // Define the standard green color
  static const Color _lightGreen = Color(0xFFAAC6BA);
  static const Color _primaryGreen = Color(0xFF77A69D);
  static const Color _indicatorColor = Color(0xFFF1BC90);
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
    Choice(title: 'التنبيهات', icon: Icons.notification_important),
    Choice(title: 'الاعدادات', icon: Icons.settings),
  ];

  // إنشاء شريط التبويب المحسن
  PreferredSizeWidget get _buildTabBar {
    return TabBar(
      isScrollable: false,
      //  labelColor: _indicatorColor,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 4,
      indicatorPadding: EdgeInsets.all(0),
      //dividerHeight:1,
      dividerColor:_lightGreen ,
      unselectedLabelColor: const Color.fromARGB(85, 99, 96, 93),
      unselectedLabelStyle: TextStyle(
        color: const Color.fromARGB(255, 29, 27, 25),
      ),
      tabAlignment: TabAlignment.center,
      indicatorColor: Colors.white,
      labelStyle: const TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      tabs:
          choices.map<Widget>((Choice choice) {
            return Container(
              height: 75,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      choice.icon,
                      size: 28,
                      color: _primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    choice.title,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AppBarCustomClipper(),
      child: Container(
        // margin: EdgeInsets.all(0),
        // padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 25),
        //  alignment: Alignment.topCenter,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: automaticallyImplyLeading,
            centerTitle: centerTitle,

            bottom: _buildTabBar,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 70); // زيادة الارتفاع لاستيعاب الأيقونات المحسنة
}
