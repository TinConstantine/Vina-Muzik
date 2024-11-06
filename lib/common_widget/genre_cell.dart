import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class GenreCell extends StatelessWidget {
  final Map obj;
  final VoidCallback? onPressed;

  const GenreCell({super.key, required this.obj, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          obj["image"],
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black54,
          width: double.maxFinite,
          height: double.maxFinite,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,// == wrap_content trong native
          children: [
            Text(
              obj["name"],
              style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              obj["songs"],
              style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 10,),
            ),
          ],
        )
      ],
    );
  }
}
