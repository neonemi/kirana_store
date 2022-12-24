import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../core/core.dart';

class OrderHistoryScreen extends StatefulWidget {
  final bool showAppBar;
  const OrderHistoryScreen({super.key, required this.showAppBar});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  late final OrderCubit _cubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderCubit>(
      create: (context) {
        _cubit = OrderCubit(context.read<CoreRepository>())..getOrder();

        return _cubit;
      },
      child: BlocListener<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state is OrderLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
          if (state is OrderSuccess) {}
          if (state is OrderError) {
            context.showToast(state.message);
          }
        },
        child: Scaffold(
          appBar: widget.showAppBar == true
              ? AppBar(
                  backgroundColor: AppTheme.appYellow,
                  centerTitle: true,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: AppTheme.appWhite),
                  title: Container(
                    margin: const EdgeInsets.only(right: 40),
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      'My Orders',
                      style: TextStyle(
                          color: AppTheme.appWhite,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontFamily: "Montserrat"),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : null,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              shrinkWrap: true,
              children: [
                if (widget.showAppBar == false)
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      'My Orders',
                      style: TextStyle(
                          color: AppTheme.appBlack,
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontFamily: "Montserrat"),
                      textAlign: TextAlign.center,
                    ),
                  ),
                Container(
                  margin: widget.showAppBar == true
                      ? const EdgeInsets.only(top: 10, bottom: 10)
                      : null,
                  child: Text(
                    'We are early waiting for your first order',
                    style: TextStyle(
                        color: AppTheme.appBlack,
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontFamily: "Montserrat"),
                    textAlign: TextAlign.center,
                  ),
                ),
                BlocBuilder<OrderCubit, OrderState>(
                    builder: (context, state) {
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
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Order Id: xyz'),
                                    const Text('Price: xyz'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Date: xyz'),
                                  ],
                                ),
                                const Divider(),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: AppTheme.appYellow,
                                          elevation: 3,
                                          padding: const EdgeInsets.all(8),
                                          alignment: Alignment.center,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(30.0)),
                                          //fixedSize: const Size(100, 30),
                                          //////// HERE
                                        ),
                                        onPressed: () {

                                        },
                                        child: const Text(
                                          'VIEW',
                                          style: TextStyle(fontSize: 14),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(width: 20,),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: AppTheme.appYellow,
                                          elevation: 3,
                                          padding: const EdgeInsets.all(8),
                                          alignment: Alignment.center,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(30.0)),
                                          // fixedSize: const Size(100, 30),
                                          //////// HERE
                                        ),
                                        onPressed: () {

                                        },
                                        child: const Text(
                                          'CANCEL',
                                          style: TextStyle(fontSize: 14),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                })
              ],
            ),
          ),
        ),
      ),
    );
    //const Center(child: Text("order",style: TextStyle(color: Colors.red),));
  }
}
