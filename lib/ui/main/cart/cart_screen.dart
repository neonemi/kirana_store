import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kirana_store/core/core.dart';
import 'package:kirana_store/core/model/cart_data.dart';

import '../../../core/controller/cart_controller.dart';
import '../../ui.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartCubit _cubit;
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
        BlocProvider<CartCubit>(create: (context) {
          _cubit = CartCubit(context.read<CoreRepository>());
          _cubit.loadData();
          return _cubit;
        }),
        // BlocProvider<CartCubit>(create: (context) {
        //   _cubit = CartCubit(context.read<CoreRepository>());
        //   _cubit.loadData();
        //   return _cubit;
        // }),
      ],
      child: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
          if (state is CartSuccess) {}
          if (state is CartError) {
            context.showToast(state.message);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.appYellow,
            centerTitle: true,
            elevation: 0.0,
            iconTheme: IconThemeData(color: AppTheme.appWhite),
            title: Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(
                'Cart',
                style: TextStyle(
                    color: AppTheme.appWhite,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontFamily: "Montserrat"),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          body: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
            if (state is CartSuccess) {
              String currentLocation = state.address;

              return GetBuilder<CartController>(
                  // no need to initialize Controller ever again, just mention the type
                  builder: (value) {
                var cartDataList = <CartData>[].obs;
                cartListString =
                    context.read<LocalRepository>().getCartList() ?? '';
                List<CartData> cartList = [];
                CartData? cartData;
                if (cartListString != '') {
                  cartList = CartData.decode(cartListString);

                  cartDataList.value = cartList;
                }
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            color: AppTheme.appYellow,
                             height: MediaQuery.of(context).size.height * 1 / 5,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    'Only one offer/coupon will be applicable on one order at a time.',
                                    style: TextStyle(
                                        color: AppTheme.appWhite,
                                        fontSize: 14,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: "Montserrat"),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'DELIVERY AT',
                                    style: TextStyle(
                                        color: AppTheme.appWhite,
                                        fontSize: 16,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: "Montserrat"),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                90,
                                        child: Text(currentLocation,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: AppTheme.appWhite,
                                                fontSize: 16,
                                                fontStyle: FontStyle.normal,
                                                fontFamily: "Montserrat")),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const AddressScreen()));
                                          },
                                          child: Text('Change',
                                              style: TextStyle(
                                                  color: AppTheme.appWhite,
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.normal,
                                                  fontFamily: "Montserrat")),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 1 / 4,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: cartList!.length,
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  List<CartData> outputList = cartList
                                      .where((o) => o.id == cartList[index].id)
                                      .toList();

                                  if (outputList.isNotEmpty) {
                                    cartData = outputList.first;
                                  } else {
                                    cartData = null;
                                  }
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title: Text(
                                              '${cartList[index].name!} ( ${cartList[index].unitqty} ${cartList[index].unitqtyname})',
                                              style: TextStyle(
                                                  color: AppTheme.appBlack,
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.normal,
                                                  fontFamily: "Montserrat")),
                                          subtitle: Text(
                                              "₹${cartList[index].price}",
                                              style: TextStyle(
                                                  color: AppTheme.appBlack,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: FontStyle.normal,
                                                  fontFamily: "Montserrat")),
                                          trailing: Container(
                                            margin:
                                                const EdgeInsets.only(top: 20),
                                            height: 30,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                if (cartData != null &&
                                                    cartData!.quantity! >= 1 &&
                                                    cartData!.id ==
                                                        cartList[index].id!)
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (kDebugMode) {
                                                        print(
                                                            cartData!.quantity);
                                                      }
                                                      cartController
                                                          .counterRemoveProductToCart(
                                                              context,
                                                              cartData!);
                                                      preference();
                                                    },
                                                    child: Container(
                                                        height: 20,
                                                        width: 20,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: AppTheme
                                                                    .appYellow),
                                                        child: Icon(
                                                          Icons.remove,
                                                          color:
                                                              AppTheme.appBlack,
                                                          size: 15,
                                                        )),
                                                  ),
                                                if (cartData != null &&
                                                    cartData!.quantity! >= 1 &&
                                                    cartData!.id ==
                                                        cartList[index].id!)
                                                  // const SizedBox(
                                                  //   width: 5,
                                                  // ),
                                                  if (cartData != null &&
                                                      cartData!.quantity! >=
                                                          1 &&
                                                      cartData!.id ==
                                                          cartList[index].id!)
                                                    Container(
                                                        padding:
                                                            const EdgeInsets.fromLTRB(
                                                                5, 0, 5, 0),
                                                        margin: const EdgeInsets
                                                                .fromLTRB(
                                                            0, 5, 0, 5),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        decoration:
                                                            BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                          color: AppTheme
                                                              .appYellow,
                                                        )),
                                                        child: Text(
                                                          cartData != null
                                                              ? '${cartData!.quantity}'
                                                              : '',
                                                          style: TextStyle(
                                                              color: AppTheme
                                                                  .appYellow,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )),
                                                // const SizedBox(
                                                //   width: 5,
                                                // ),
                                                GestureDetector(
                                                    onTap: () {
                                                      if (cartData != null) {
                                                        if (kDebugMode) {
                                                          print('1 condition');
                                                        }
                                                        cartController
                                                            .counterAddProductToCart(
                                                                cartData!);
                                                        preference();
                                                        if (kDebugMode) {
                                                          print('3 condition');
                                                        }
                                                      } else {
                                                        if (kDebugMode) {
                                                          print(2);
                                                        }
                                                        cartController.addProductToCart(
                                                            id: cartList[index]
                                                                .id!,
                                                            orderId: cartList[index]
                                                                .id!,
                                                            unitPrice: cartList[index]
                                                                .price!,
                                                            price: cartList[index]
                                                                .price!,
                                                            quantity: 1,
                                                            productId:
                                                                cartList[index]
                                                                    .id!,
                                                            nameProduct:
                                                                cartList[index]
                                                                    .name!,
                                                            imageProduct:
                                                                cartList[index]
                                                                    .image!,
                                                            unitqty: cartList[index]
                                                                .unitqty!,
                                                            unitqtyname:
                                                                cartList[index]
                                                                    .unitqtyname!,
                                                            categoryName:
                                                                cartList[index]
                                                                    .categoryName!,
                                                            gst: cartList[index]
                                                                .gst!,
                                                            isDiscounted:
                                                                cartList[index]
                                                                    .isDiscounted!,
                                                            discountedPrice:
                                                                cartList[index]
                                                                    .discountedPrice!);
                                                        preference();
                                                      }
                                                    },
                                                    child: Container(
                                                        height: 20,
                                                        width: 20,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: AppTheme
                                                                    .appYellow),
                                                        child: Icon(
                                                          Icons.add,
                                                          color:
                                                              AppTheme.appBlack,
                                                          size: 15,
                                                        )))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          if(cartList!.length>=1)
                          Container(
                            height: MediaQuery.of(context).size.height * 1 / 4,
                            child: Column(
                              children: [
                                ListTile(
                                  dense: true,
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  title: Text('Item Total',
                                      style: TextStyle(
                                          color: AppTheme.appBlack,
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: "Montserrat")),
                                  trailing: Text('₹17.00',
                                      style: TextStyle(
                                          color: AppTheme.appBlack,
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: "Montserrat")),
                                ),
                                ListTile(
                                  dense: true,
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  title: Text('GST',
                                      style: TextStyle(
                                          color: AppTheme.appBlack,
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: "Montserrat")),
                                  trailing: Text('₹1.00',
                                      style: TextStyle(
                                          color: AppTheme.appBlack,
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: "Montserrat")),
                                ),
                                ListTile(
                                  dense: true,
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  minLeadingWidth: 0,
                                  title: Text('Delivery Charge',
                                      style: TextStyle(
                                          color: AppTheme.appBlack,
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: "Montserrat")),
                                  trailing: Text('₹30.00',
                                      style: TextStyle(
                                          color: AppTheme.appBlack,
                                          fontSize: 14,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: "Montserrat")),
                                ),
                                ListTile(
                                  dense: true,
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  title: Text('Apply Coupons',
                                      style: TextStyle(
                                          color: AppTheme.appYellow,
                                          fontSize: 16,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: "Montserrat")),
                                  onTap: (){
                                    _onApplyCoupon(context);
                                  },
                                ),
                                Divider(
                                  color: AppTheme.appGrey,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                ListTile(
                                  dense: true,
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  minLeadingWidth: 0,
                                  title: Text('Grand Total',
                                      style: TextStyle(
                                          color: AppTheme.appBlack,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: "Montserrat")),
                                  trailing: Text('₹48.00',
                                      style: TextStyle(
                                          color: AppTheme.appBlack,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: "Montserrat")),
                                ),
                              ],
                            ),
                          ),
                          if(cartList!.length>=1)
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            child: Container(
                              width: 200,
                              child: ListTile(
                                dense: true,
                                tileColor: AppTheme.appYellow,
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -4),
                                minLeadingWidth: 0,
                                title: Text('Total',
                                    style: TextStyle(
                                        color: AppTheme.appWhite,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: "Montserrat")),
                                subtitle: Text('₹48.00',
                                    style: TextStyle(
                                        color: AppTheme.appWhite,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: "Montserrat")),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Place Order',
                                        style: TextStyle(
                                            color: AppTheme.appWhite,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: "Montserrat")),
                                    Icon(
                                      Icons.arrow_right,
                                      color: AppTheme.appWhite,
                                      size: 22,
                                    )
                                  ],
                                ),
                                onTap: () {
                                  _onTap(context, currentLocation);
                                },
                              ),
                            ),
                          )
                        ]));
              });
            }
            return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: AppTheme.appYellow,
                         height: MediaQuery.of(context).size.height * 1 / 5,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Only one offer/coupon will be applicable on one order at a time.',
                                style: TextStyle(
                                    color: AppTheme.appWhite,
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: "Montserrat"),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.topLeft,
                              child: Text(
                                'DELIVERY AT',
                                style: TextStyle(
                                    color: AppTheme.appWhite,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: "Montserrat"),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 90,
                                    child: Text('NA',
                                        style: TextStyle(
                                            color: AppTheme.appWhite,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: "Montserrat")),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text('ADD',
                                          style: TextStyle(
                                              color: AppTheme.appWhite,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: "Montserrat")),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ]));
          }),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, String currentLocation) {
    AlertExtension(context).showPlaceOrderAlert(
        address: currentLocation,
        onProceed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const OrderHistoryScreen(
                    showAppBar: true,
                  )));
        },
        onAddressChange: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const AddressScreen()));
        });
  }

  void _onApplyCoupon(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
        const CouponScreen()));
  }
}
