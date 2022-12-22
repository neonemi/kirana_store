import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kirana_store/core/core.dart';


class CouponScreen extends StatefulWidget {
  const CouponScreen({Key? key}) : super(key: key);

  @override
  CouponScreenState createState() => CouponScreenState();
}

class CouponScreenState extends State<CouponScreen> {
  late final CouponCubit _cubit;
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiBlocProvider(
        providers: [
          BlocProvider<CouponCubit>(
              create: (context) {
                _cubit=CouponCubit(context.read<CoreRepository>());
                return _cubit;
              }),

        ],
        child: BlocListener<CouponCubit, CouponState>(
            listener: (context, state) {
              print(state);
              if (state is CouponLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }
            },
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: AppTheme.appYellow,
                  iconTheme: IconThemeData(color: AppTheme.appWhite),
                  centerTitle: true,
                  elevation: 0.0,
                  title: Container(
                    margin: const EdgeInsets.only(right: 40),
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      'Coupon Screen',
                      style: TextStyle(
                          color: AppTheme.appWhite,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontFamily: "Montserrat"),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                body: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),

                ))));
  }




}