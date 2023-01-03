import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kirana_store/ui/widget/triangle_paint.dart';

import '../../core/core.dart';

class BottomItemWidget extends StatelessWidget {
  const BottomItemWidget(
      {Key? key,
      required this.isActive,
      required this.image,
      required this.text})
      : super(key: key);

  final IconData image;
  final String text;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(text);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Container(
        //   height: 30,
        //   width: 30,
        //   decoration: BoxDecoration(
        //     color: Colors.black,
        //     shape: BoxShape.values[]
        //   ),
        //
        //   alignment: Alignment.topCenter,
        //   child: RotatedBox(
        //     quarterTurns: 1,
        //     child: Icon(Icons.play_arrow,color:
        //           !isActive
        //               ? AppTheme.appRed
        //               : AppTheme.appWhite,
        //       // size: 30,
        //     ),
        //   ),
        // ),
        RotatedBox(
          quarterTurns: 2,
          child: CustomPaint(
            painter: TrianglePainter(
              strokeColor: !isActive ? AppTheme.appYellow : AppTheme.appWhite,
              //strokeWidth: 3,
              paintingStyle: PaintingStyle.fill,
            ),
            child: const SizedBox(
              height: 20,
              width: 20,
            ),
          ),
        ),

        SizedBox(
          height: 20,
          width: 20,
          child: Icon(
            image,
            size: 22,
            color: AppTheme.appWhite,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 15,
          child: Text(
            text,
            style: TextStyle(color: AppTheme.appWhite, fontSize: 10),
          ),
        ),
      ],
    );
  }
}
