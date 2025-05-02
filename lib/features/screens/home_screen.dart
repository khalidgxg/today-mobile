import 'package:flutter/material.dart';
import 'package:today/features/widgets/custom_app_bar.dart';
import 'package:today/features/domain/entities/choice.dart';
import 'package:today/features/widgets/choice_page.dart';

/// Main screen container that displays the CategoryScreen content.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use DefaultTabController to manage tab state
    return DefaultTabController(
      length: CustomAppBar.choices.length,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: const CustomAppBar(),
          // TabBarView displays different content for each tab
          body: TabBarView(
            children: CustomAppBar.choices.map((Choice choice) {
              return ChoicePage(choice: choice);
            }).toList(),
          ),
        ),
      ),
    );
  }
} 