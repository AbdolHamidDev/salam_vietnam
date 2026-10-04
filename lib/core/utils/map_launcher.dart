import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class MapLauncher {
  static Future<void> launchDirections({
    required double latitude,
    required double longitude,
    required String placeName,
    required BuildContext context,
  }) async {
    final googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );

    try {
      if (await canLaunchUrl(googleMapsUrl)) {
        await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Không thể mở bản đồ chỉ đường cho $placeName'),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Mở chỉ đường tới $placeName ($latitude, $longitude)',
            ),
          ),
        );
      }
    }
  }
}
