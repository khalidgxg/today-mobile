import 'package:flutter/material.dart';

class LetterCard extends StatelessWidget {
  final String body;
  final Color? backgroundColor;
  final Color? textColor;

  const LetterCard({
    Key? key,
    required this.body,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2.0,
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Text(
              body,
              style: TextStyle(
                fontSize: 14.0,
                color: textColor,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 16.0),
            const Divider(height: 1.0, color: Colors.grey),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('قريبا'),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
              
                IconButton(
                  icon: const Icon(Icons.share_outlined),
                  onPressed: () {
                     ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('قريبا'),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 