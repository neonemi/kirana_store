import 'package:flutter/cupertino.dart';
import 'package:kirana_store/core/core.dart';

class AppLogo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height:80,
          width: 80,
          padding: EdgeInsets.all(4),
          color: AppTheme.appWhite,
          child: Image.asset(
            AppIconKeys.dwarikaMain,
            fit: BoxFit.cover,

          ),
        ),
      ),
    );
  }

}