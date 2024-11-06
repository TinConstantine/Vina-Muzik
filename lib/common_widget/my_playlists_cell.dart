import 'package:flutter/material.dart';

import '../common/color_extension.dart';
import '../common/image.dart';

class MyPlaylistsCell extends StatelessWidget {
  final Map sObj;
  final VoidCallback onPressedPlay;
  final VoidCallback onPressed;

  const MyPlaylistsCell(
      {super.key,
        required this.sObj,
        required this.onPressed,
        required this.onPressedPlay});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  sObj["image"],
                  width: 90,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: 90,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: TColor.primaryText28),
                  borderRadius: BorderRadius.circular(4),
                ),
              )
            ],
          ),
          const SizedBox(height: 12,),
          Text(
            sObj["name"],
            maxLines: 1,
            style: TextStyle(
                color: TColor.primaryText60,
                fontSize: 13,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
