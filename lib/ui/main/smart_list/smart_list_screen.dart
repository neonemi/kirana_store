import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kirana_store/core/core.dart';

import '../../ui.dart';

class SmartListScreen extends StatefulWidget {
  const SmartListScreen({super.key});

  @override
  State<SmartListScreen> createState() => _SmartListScreenState();
}

class _SmartListScreenState extends State<SmartListScreen> {
  late final SmartListCubit _cubit;
  final cartController = Get.find<CartController>();
  int selectedIndex = 0;
  String cartListString = '';
  Future<void> preference() async {
    cartListString = context.read<LocalRepository>().getCartList() ?? '';
    setState(() {
      cartListString;
    });
  }

  @override
  void initState() {
    super.initState();
    // _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SmartListCubit>(create: (context) {
            _cubit = SmartListCubit(context.read<CoreRepository>());
            //_cubit.loadData();
            return _cubit;
          }),
        ],
        child: BlocListener<SmartListCubit, SmartState>(
            listener: (context, state) {
              if (state is SmartStateLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }
              if (state is SmartStateSuccess) {}
              if (state is SmartStateError) {
                context.showToast(state.message);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppTheme.appWhite,
                centerTitle: true,
                elevation: 0.0,
                iconTheme: IconThemeData(color: AppTheme.appBlack),
                title: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    'Your Smart List',
                    style: TextStyle(
                        color: AppTheme.appBlack,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontFamily: StringConstant.fontFamily),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height-200,
                      child: ListView.builder(
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
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        height:60,
                                        width: 60,
                                        padding: const EdgeInsets.all(4),
                                        color: AppTheme.appWhite,
                                            child: AppImageLoader(
                                              imageUrl:
                                              '${Apis.imageBaseUrl}/storage/productimage/wnvzEqDFjGzk4afrN78vgZM7O37zORFuVIsKiPLK.png',
                                              boxFit: BoxFit.cover, height: 60, width: 60,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width-120,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              visualDensity:
                                              const VisualDensity(horizontal: 0, vertical: -4),
                                              title:  Text('Cinnamon',
                                                  style: TextStyle(
                                                      color: AppTheme.appBlack,
                                                      fontSize: 14)),
                                              subtitle:  Text('Orgasatva 1 pack',
                                          style: TextStyle(
                                              color: AppTheme.appBlack,
                                              fontSize: 12)),
                                              trailing:  SizedBox(
                                                width: 60,
                                                height: 20,
                                                child: GetBuilder<CartController>(
                                                  // no need to initialize Controller ever again, just mention the type
                                                    builder: (value) {
                                                      // var cartDataList = <CartData>[].obs;
                                                      // cartListString =
                                                      //     context.read<LocalRepository>().getCartList() ??
                                                      //         '';
                                                      // List<CartData>? cartList;
                                                      // CartData? cartData;
                                                      // if (cartListString != '') {
                                                      //   cartList = CartData.decode(cartListString);
                                                      //
                                                      //   cartDataList.value = cartList;
                                                      //
                                                      //   List<CartData> outputList = cartList
                                                      //       .where((o) => o.id == productData![index].id)
                                                      //       .toList();
                                                      //
                                                      //   if (outputList.isNotEmpty) {
                                                      //     cartData = outputList.first;
                                                      //   } else {
                                                      //     cartData = null;
                                                      //   }
                                                      // }

                                                      return Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          // if (cartData != null &&
                                                          //     cartData.quantity! >= 1 &&
                                                          //     cartData.id == productData![index].id)
                                                            GestureDetector(
                                                              onTap: () {
                                                                // if (kDebugMode) {
                                                                //   print(cartData!.quantity);
                                                                // }
                                                                // cartController
                                                                //     .counterRemoveProductToCart(cartData!);
                                                                // preference();
                                                              },
                                                              child: Container(
                                                                  height: 20,
                                                                  width: 20,
                                                                  alignment: Alignment.center,
                                                                  decoration:
                                                                  BoxDecoration(color: AppTheme.appYellow),
                                                                  child: Icon(
                                                                    Icons.remove,
                                                                    color: AppTheme.appBlack,
                                                                    size: 15,
                                                                  )),
                                                            ),

                                                          // if (cartData != null &&
                                                          //     cartData.quantity! >= 1 &&
                                                          //     cartData.id == productData![index].id)
                                                            Builder(builder: (context) {
                                                              return Container(
                                                                  // padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                                  // margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                                  height: 20,
                                                                  width: 20,
                                                                  alignment: Alignment.center,
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                        color: AppTheme.appYellow,
                                                                      )),
                                                                  child: Text(
                                                                    // cartData != null
                                                                    //     ? '${cartData.quantity}'
                                                                    //     : '',
                                                                    '1',
                                                                    style: TextStyle(
                                                                        color: AppTheme.appYellow,
                                                                        fontWeight: FontWeight.w600),
                                                                  ));
                                                            }),
                                                          // const SizedBox(
                                                          //   width: 5,
                                                          // ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              // if (cartData != null) {
                                                              //   if (kDebugMode) {
                                                              //     print('1 condition');
                                                              //   }
                                                              //   cartController
                                                              //       .counterAddProductToCart(cartData);
                                                              //   preference();
                                                              //   if (kDebugMode) {
                                                              //     print('3 condition');
                                                              //   }
                                                              // } else {
                                                              //   if (kDebugMode) {
                                                              //     print(2);
                                                              //   }
                                                              //   cartController.addProductToCart(
                                                              //       id: productData![index].id!,
                                                              //       orderId: productData![index].id!,
                                                              //       unitPrice: productData![index].price!,
                                                              //       price: productData![index].price!,
                                                              //       quantity: 1,
                                                              //       productId: productData![index].id!,
                                                              //       nameProduct: productData![index].name!,
                                                              //       imageProduct:
                                                              //       productData![index].image!,
                                                              //       unitqty: productData![index]
                                                              //           .unitqty
                                                              //           .toString(),
                                                              //       unitqtyname:
                                                              //       productData![index].unitqtyname!,
                                                              //       categoryName: itemName!, gst: '', isDiscounted: '', discountedPrice: '');
                                                              //   preference();
                                                              // }
                                                            },
                                                            child: Container(
                                                                height: 20,
                                                                width: 20,
                                                                alignment: Alignment.center,
                                                                decoration:
                                                                BoxDecoration(color: AppTheme.appYellow),
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: AppTheme.appBlack,
                                                                  size: 15,
                                                                )),
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(right: 14),
                                              alignment: Alignment.centerRight,
                                              child: Text('${StringConstant.rupeeSymbol}150.00', style: TextStyle(
                                                  color: AppTheme.appYellow,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14)),
                                            )
                                          ],
                                        ),
                                      )
                                      // Expanded(
                                      //   child: Text('Orgasatva',
                                      //       style: TextStyle(
                                      //           color: AppTheme.appBlack,
                                      //           fontSize: 16)),
                                      //),
                                    ],
                                  )),
                            );
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:MediaQuery.of(context).size.height-200),
                      height: 100,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: AppTheme.appGreen,
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
                              _onAddItem(context);
                            },
                            child: const Text(
                              StringConstant.addItem,
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(width: 20,),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: AppTheme.appRed,
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
                              _onBuyItem(context);
                            },
                            child: const Text(
                              StringConstant.buy,
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

//const Center(child: Text("profile",style: TextStyle(color: Colors.red),));
 void _onAddItem(BuildContext context){
   Navigator.of(context).push(MaterialPageRoute(
       builder: (BuildContext context) =>
       const AddItemScreen()));
 }

 void _onBuyItem(BuildContext context){

 }
}
