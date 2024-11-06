
import 'package:flutter/material.dart';

extension StateHelper<T extends StatefulWidget> on State<T>{
  Spacer get spacer => const Spacer();

  SizedBox space(double size) => SizedBox(width: size,height: size,);

  SizedBox get space0 => space(0);

  SizedBox get space2 => space(2);

  SizedBox get space4 => space(4);

  SizedBox get space8 => space(8);

  SizedBox get space12 => space(12);

  SizedBox get space16 => space(16);

  SizedBox get space20 => space(20);

  SizedBox get space24 => space(24);

  SizedBox get space32 => space(32);

  SizedBox get space40 => space(40);

  MediaQueryData get media => MediaQuery.of(context);

  Size get mediaSize => media.size;

}
