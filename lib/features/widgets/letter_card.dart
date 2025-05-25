import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../services/image_generator.dart'; // Assuming image_generator.dart is in lib/features/services/
import 'dart:html' as html;

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
                fontSize: 18.0,
                color: textColor,
                fontWeight: FontWeight.bold,
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
                IconButton(
                  icon: const Icon(Icons.download_outlined),
                  onPressed: () async {
                    final Uint8List? imageBytes = await ImageGenerator.generateImageFromText(
                      text: body,
                      context: context,
                      backgroundImage: const AssetImage('assets/images/pexels.jpg'),
                    );

                    if (imageBytes == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to generate image.')),
                      );
                      return;
                    }

                    if (kIsWeb) {
                      // Web platform: Trigger download
                      try {
                        final blob = html.Blob([imageBytes], 'image/png');
                        final url = html.Url.createObjectUrlFromBlob(blob);
                        final anchor = html.AnchorElement(href: url)
                          ..setAttribute("download", "letter_card_${DateTime.now().millisecondsSinceEpoch}.png")
                          ..click();
                        html.Url.revokeObjectUrl(url);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Image downloading...')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error downloading image for web: $e')),
                        );
                      }
                    } else {
                      // Mobile platforms: Use permission_handler and image_gallery_saver
                      var status = await Permission.storage.status;
                      if (!status.isGranted) {
                        status = await Permission.storage.request();
                      }

                      if (status.isGranted) {
                        try {
                          final result = await ImageGallerySaver.saveImage(
                            imageBytes,
                            quality: 90,
                            name: "letter_card_${DateTime.now().millisecondsSinceEpoch}",
                          );

                          if (result != null && result['isSuccess']) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Image saved to gallery!')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to save image: ${result?['errorMessage'] ?? 'Unknown error'}')),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error saving image: $e')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Storage permission denied.')),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 