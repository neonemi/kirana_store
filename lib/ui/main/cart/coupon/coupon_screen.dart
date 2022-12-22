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
  double fontSize = 14.0;
  String _couponController = "";
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
                     child: ListView(
                       children: [
                         Padding(
                           padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width * 0.07, vertical: 22),
                           child: TextFormField(
                             style: TextStyle(
                                 fontSize: fontSize, color: AppTheme.appBlack),
                             decoration:  InputDecoration(
                               hintText: 'Enter Promo Code',
                                 contentPadding:
                                 const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                 enabledBorder:  UnderlineInputBorder(
                                   borderSide: BorderSide(color:  AppTheme.appLightGrey),
                                 ),
                                 focusedBorder:  UnderlineInputBorder(
                                   borderSide: BorderSide(color:  AppTheme.appLightGrey),
                                 ),
                                 counterStyle: const TextStyle(
                                   height: double.minPositive,
                                 ),
                                 counterText: "",
                               suffixIcon: Container(
                                 padding: EdgeInsets.only(top:10),
                                 child: Text('Apply',style: TextStyle(
                                     fontSize: 16, color: AppTheme.appRed,fontWeight: FontWeight.w600),),
                               )
                             ),
                             onChanged: (landmark) {
                               _couponController = landmark;
                             },
                             initialValue: _couponController,
                             maxLength: 200,
                             // controller: _emailController,
                             keyboardType: TextInputType.text,
                             inputFormatters: <TextInputFormatter>[
                               FilteringTextInputFormatter.singleLineFormatter
                             ],
                           ),
                         ),

                         Container(
                           width: MediaQuery.of(context).size.width,
                           height: 40,
                           margin: const EdgeInsets.only(left: 20,right: 20),
                           decoration: BoxDecoration(color: AppTheme.appLightGrey),
                           alignment: Alignment.centerLeft,
                           padding: EdgeInsets.all(8),
                           child: const Text('Available Offers'),
                         ),
                         Container(
                             width: MediaQuery.of(context).size.width,
                             height: 40,
                             margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
                             alignment: Alignment.center,
                             child: const Text('Sorry No Coupon Found'))
                       ],
                     ),
                ))));
  }




}