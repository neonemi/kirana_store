import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kirana_store/core/core.dart';

class OrderDetailsScreen extends StatefulWidget {
  List<Orderitems>? orderitems;
  CustomerOrderData? customerOrderData;
  OrderDetailsScreen(
      {super.key, required this.orderitems, this.customerOrderData});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  List<Orderitems>? orderitems;
  CustomerOrderData? customerOrderData;
  @override
  void initState() {
    super.initState();
    orderitems = widget.orderitems;
    customerOrderData = widget.customerOrderData;
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(jsonEncode(orderitems));
    }
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
            ListTile(
              title: Text('${customerOrderData!.name}',
                  style: TextStyle(
                      color: AppTheme.appBlack,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontFamily: StringConstant.fontFamily)),
              subtitle: Text("${customerOrderData!.address}",
                  style: TextStyle(
                      color: AppTheme.appBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontFamily: StringConstant.fontFamily)),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(StringConstant.bill,
                      style: TextStyle(
                          color: AppTheme.appBlack,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontFamily: StringConstant.fontFamily)),
                  Text(
                      '${StringConstant.rupeeSymbol}${customerOrderData!.finalamount}',
                      style: TextStyle(
                          color: AppTheme.appBlack,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontFamily: StringConstant.fontFamily)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(2),
                    4: FlexColumnWidth(2),
                  },
                  border: TableBorder(
                    top: BorderSide(color: AppTheme.appBlack),
                    bottom: BorderSide(color: AppTheme.appBlack),
                  ), // Allows to add a border decoration around your table
                  children: [
                    TableRow(
                        // decoration: BoxDecoration(
                        //     color:  AppTheme.appYellow
                        //         .withAlpha(40)),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              StringConstant.itemName,
                              style: TextStyle(
                                  color: AppTheme.appBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              StringConstant.qty,
                              style: TextStyle(
                                  color: AppTheme.appBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              StringConstant.rate,
                              style: TextStyle(
                                  color: AppTheme.appBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              StringConstant.gst,
                              style: TextStyle(
                                  color: AppTheme.appBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              StringConstant.total,
                              style: TextStyle(
                                  color: AppTheme.appBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ]),
                  ]),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: orderitems == null
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: orderitems!.length,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // ListTile(
                              //   title: Text(
                              //       '${orderitems![index].name!} ( ${orderitems![index].unitqty} ${orderitems![index].unitqtyname})',
                              //       style: TextStyle(
                              //           color: AppTheme.appBlack,
                              //           fontSize: 16,
                              //           fontStyle: FontStyle.normal,
                              //           fontFamily: StringConstant.fontFamily)),
                              //   subtitle: Text(
                              //       "${StringConstant.rupeeSymbol}${orderitems![index].price}",
                              //       style: TextStyle(
                              //           color: AppTheme.appBlack,
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.w600,
                              //           fontStyle: FontStyle.normal,
                              //           fontFamily: StringConstant.fontFamily)),
                              // ),
                              Table(columnWidths: const {
                                0: FlexColumnWidth(3),
                                1: FlexColumnWidth(2),
                                2: FlexColumnWidth(2),
                                3: FlexColumnWidth(2),
                                4: FlexColumnWidth(2),
                              },

                                  children: [
                                    TableRow(children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          orderitems![index].name!,
                                          style: TextStyle(
                                            color: AppTheme.appBlack,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          '${orderitems![index].qty}',
                                          style: TextStyle(
                                            color: AppTheme.appBlack,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          '${orderitems![index].unitprice}',
                                          style: TextStyle(
                                            color: AppTheme.appBlack,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          '${orderitems![index].gst}',
                                          style: TextStyle(
                                            color: AppTheme.appBlack,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          '${orderitems![index].price}',
                                          style: TextStyle(
                                            color: AppTheme.appBlack,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ]),
                            ],
                          ),
                        );
                      }),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(2),
                    4: FlexColumnWidth(2),
                  },
                  border: TableBorder(
                    top: BorderSide(color: AppTheme.appBlack),
                    bottom: BorderSide(color: AppTheme.appBlack),
                  ), // Allows to add a border decoration around your table
                  children: [
                    TableRow(

                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              StringConstant.total,
                              style: TextStyle(
                                  color: AppTheme.appBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              '',
                              style: TextStyle(
                                  color: AppTheme.appBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              '',
                              style: TextStyle(
                                  color: AppTheme.appBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              '',
                              style: TextStyle(
                                  color: AppTheme.appBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              '${customerOrderData!.finalamount}',
                              style: TextStyle(
                                  color: AppTheme.appBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ]),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
