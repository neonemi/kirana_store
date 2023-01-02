import 'package:flutter/material.dart';
import 'package:kirana_store/core/core.dart';

class CouponWidgetScreen extends StatelessWidget {
  const CouponWidgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 1,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            shadowColor: AppTheme.appGrey,
            elevation: 2,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppTheme.appWhite,
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                title: Text(
                  'WELCOME10',
                  style: TextStyle(
                      color: AppTheme.appBlack,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontFamily: StringConstant.fontFamily),
                ),
                subtitle: Text(
                  'Apply welcome coupon on your first purchase to get cashback of  worth ${StringConstant.rupeeSymbol}10',
                  style: TextStyle(
                      color: AppTheme.appGrey,
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontFamily: StringConstant.fontFamily),
                ),
                // trailing: Container(
                //   height: 50,
                //   width: 100,
                //   padding: const EdgeInsets.all(8),
                //   decoration: BoxDecoration(
                //       border: Border.all(color: AppTheme.appYellow, width: 2),
                //       color: AppTheme.appWhite,
                //       borderRadius: BorderRadius.circular(10)),
                //   child: Center(
                //       child: Text(
                //     'Apply',
                //     style: TextStyle(
                //         color: AppTheme.appYellow, fontWeight: FontWeight.w600),
                //     textAlign: TextAlign.center,
                //   )),
                // ),
              ),
            ),
          );
        });
  }
}
