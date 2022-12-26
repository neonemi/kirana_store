import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kirana_store/core/core.dart';


class OrderDetailsScreen extends StatefulWidget {
  List<Orderitems>? orderitems;
   OrderDetailsScreen({super.key,required this.orderitems});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  List<Orderitems>? orderitems;


  @override
  void initState() {
    super.initState();
    orderitems=widget.orderitems;
  }

  @override
  Widget build(BuildContext context) {
    print(jsonEncode(orderitems));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.appYellow,
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(color: AppTheme.appWhite),
        title: Container(
          height: 50,
          margin: const EdgeInsets.only(right: 40),
          alignment: Alignment.center,
          child: Text(
            StringConstant.orderDetails,
            style: TextStyle(
                color: AppTheme.appWhite,
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontFamily: StringConstant.fontFamily),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            orderitems==null?const SizedBox.shrink():ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount:orderitems!.length,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                              '${orderitems![index].name!} ( ${orderitems![index].unitqty} ${orderitems![index].unitqtyname})',
                              style: TextStyle(
                                  color: AppTheme.appBlack,
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: StringConstant.fontFamily)),
                          subtitle: Text(
                              "${StringConstant.rupeeSymbol}${orderitems![index].price}",
                              style: TextStyle(
                                  color: AppTheme.appBlack,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: StringConstant.fontFamily)),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }


}
