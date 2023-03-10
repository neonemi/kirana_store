import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kirana_store/core/core.dart';

import '../../../ui.dart';
import 'widget/widget.dart';

class FoodItemScreen extends StatefulWidget {
  final String itemName;
  final String id;
  const FoodItemScreen({Key? key, required this.itemName, required this.id})
      : super(key: key);

  @override
  FoodItemScreenState createState() => FoodItemScreenState();
}

class FoodItemScreenState extends State<FoodItemScreen> {
  late final FoodItemCubit _cubit;
  String itemName = "";
  String itemId = "";
  bool visibleBestSeller = true;
  @override
  void initState() {
    super.initState();

    itemName = widget.itemName;
    itemId = widget.id;
    if (kDebugMode) {
      print(itemId);
    }
    // _cubit = FoodItemCubit(context.read<CoreRepository>())
    //   ..getFoodProduct(itemId);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiBlocProvider(
        providers: [
          // BlocProvider<FoodItemCubit>(create: (context) {
          //   _cubit = FoodItemCubit(context.read<CoreRepository>())
          //     ..getSubCategory(itemId);
          //   return _cubit;
          // }),
          BlocProvider<FoodItemCubit>(create: (context) {
            _cubit = FoodItemCubit(context.read<CoreRepository>())
              ..getFoodBestSeller(itemId);
            return _cubit;
          }),
        ],
        child: BlocListener<FoodItemCubit, FoodItemState>(
            listener: (context, state) {
              if (kDebugMode) {
                print('state : $state');
              }
              if (state is FoodItemLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }

              if (state is FoodItemError) {
                context.showToast(state.message);
              }
            },
            child:
                // BlocBuilder<FoodItemCubit, FoodItemState>(
                //     buildWhen: (previous, current) =>
                //     current is FoodSubCategorySuccess,
                //     builder: (context, state) {
                //       if(state is FoodSubCategorySuccess) {
                //         GetSubCategory getSubCategory = state.response;
                //         // for(var i=0;i<=getSubCategory.data!.length;i++) {
                //            if( getSubCategory.data!=null && getSubCategory.data!.isNotEmpty) {
                //           _cubit.getFoodBestSeller(
                //               getSubCategory.data![0].id.toString());
                //         }
                //         // }
                //       return
                Scaffold(
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
                    itemName,
                    style: TextStyle(
                        color: AppTheme.appWhite,
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontFamily: StringConstant.fontFamily),
                    textAlign: TextAlign.center,
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      SortDialogBuilder(context).showSortDialog(context,
                          (String value) {
                        setState(() {
                          visibleBestSeller = false;
                        });
                        // _cubit.getFoodProduct(getSubCategory.data![0].id.toString(), value, "");
                        _cubit.getFoodProduct(itemId, value, "");
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: RotatedBox(
                          quarterTurns: 1,
                          child: Image.asset(
                            AppIconKeys.swap,
                            color: AppTheme.appWhite,
                            height: 20,
                            width: 20,
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      FilterDialogBuilder(context).showFilterDialog(context,
                          (String value) {
                        setState(() {
                          visibleBestSeller = false;
                        });
                        // _cubit.getFoodProduct(getSubCategory.data![0].id.toString(), "", value);
                        _cubit.getFoodProduct(itemId, "", value);
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: RotatedBox(
                          quarterTurns: 1,
                          child: Image.asset(
                            AppIconKeys.filter,
                            color: AppTheme.appWhite,
                            height: 20,
                            width: 20,
                          )),
                    ),
                  )
                ],
              ),
              body:
                  // getSubCategory.data==null?const SizedBox.shrink():
                  //                   getSubCategory.data!.isEmpty?const SizedBox.shrink():
                  SingleChildScrollView(
                      child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            // getSubCategory.data![0].name.toString(),
                            itemName,
                            style: TextStyle(
                                color: AppTheme.appYellow,
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                                fontFamily: StringConstant.fontFamily),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(40, 0, 20, 20),
                          // height: 50,
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.circle,
                            size: 10,
                            color: AppTheme.appBlack,
                          ),
                        ),
                        Visibility(
                          visible: visibleBestSeller,
                          child: BlocBuilder<FoodItemCubit, FoodItemState>(
                              buildWhen: (previous, current) =>
                                  current is FoodItemBestSellerSuccess,
                              builder: (context, state) {
                                if (state is FoodItemBestSellerSuccess) {
                                  GetBestSellerResponse bestSellerData =
                                      state.response;
                                  if (kDebugMode) {
                                    print('response 3  $bestSellerData');
                                  }
                                  return bestSellerData.data == null
                                      ? const SizedBox.shrink()
                                      : bestSellerData.data!.isEmpty
                                          ? const SizedBox.shrink()
                                          : Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Best Sellers',
                                                    style: TextStyle(
                                                        color:
                                                            AppTheme.appBlack,
                                                        fontSize: 18,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            StringConstant
                                                                .fontFamily),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                FoodBestSellerList(
                                                  bestSellerData:
                                                      bestSellerData.data!,
                                                  itemName: itemName,
                                                ),
                                              ],
                                            );
                                }
                                return Container(
                                  // margin: const EdgeInsets.only(top: 50),
                                  height: 250,
                                );
                              }),
                        ),
                        BlocBuilder<FoodItemCubit, FoodItemState>(
                            buildWhen: (previous, current) =>
                                current is FoodItemProductSuccess,
                            builder: (context, state) {
                              if (state is FoodItemProductSuccess) {
                                FoodAllProduct productData = state.response;
                                if (kDebugMode) {
                                  print('response 3  $productData');
                                  var pro = jsonEncode(productData);
                                  print('response 3 $pro');
                                }
                                return productData.data == null
                                    ? const SizedBox.shrink()
                                    : productData.data!.data!.isEmpty
                                        ? const SizedBox.shrink()
                                        : Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'All Products',
                                                  style: TextStyle(
                                                      color: AppTheme.appBlack,
                                                      fontSize: 18,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: StringConstant
                                                          .fontFamily),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              FoodAllProductScreen(
                                                productData:
                                                    productData.data!.data!,
                                                itemName: itemName,
                                              ),
                                            ],
                                          );
                              }
                              return Container(
                                // margin: const EdgeInsets.only(top: 300),
                                height: 200,
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              )),
            )
            //;
            // }
            //  return Scaffold(
            //    appBar: AppBar(
            //      backgroundColor: AppTheme.appYellow,
            //      iconTheme: IconThemeData(color: AppTheme.appWhite),
            //      centerTitle: true,
            //      elevation: 0.0,
            //      title: Container(
            //        margin: const EdgeInsets.only(right: 40),
            //        height: 50,
            //        alignment: Alignment.center,
            //        child: Text(
            //          itemName,
            //          style: TextStyle(
            //              color: AppTheme.appWhite,
            //              fontSize: 20,
            //              fontStyle: FontStyle.normal,
            //              fontFamily: StringConstant.fontFamily),
            //          textAlign: TextAlign.center,
            //        ),
            //      ),
            //      actions: [
            //        GestureDetector(
            //          onTap:(){
            //            SortDialogBuilder(context).showSortDialog(context, (String value) {
            //              print(value);
            //              setState((){
            //                visibleBestSeller=false;
            //              });
            //              _cubit.getFoodProduct(itemId, value, "");
            //              // Navigator.of(context).pop;
            //            });
            //          },
            //          child: Container(
            //            margin: const EdgeInsets.only(right: 10),
            //            child: RotatedBox(
            //                quarterTurns: 1,
            //                child: Image.asset(
            //                  AppIconKeys.swap,
            //                  color: AppTheme.appWhite,
            //                  height: 20,
            //                  width: 20,
            //                )),
            //          ),
            //        ),
            //        GestureDetector(
            //          onTap: (){
            //            FilterDialogBuilder(context).showFilterDialog(context, (String value) {
            //              print(value);
            //              setState((){
            //                visibleBestSeller=false;
            //              });
            //              _cubit.getFoodProduct(itemId, "", value);
            //            });
            //          },
            //          child: Container(
            //            margin: const EdgeInsets.only(right: 10),
            //            child: RotatedBox(
            //                quarterTurns: 1,
            //                child: Image.asset(
            //                  AppIconKeys.filter,
            //                  color: AppTheme.appWhite,
            //                  height: 20,
            //                  width: 20,
            //                )),
            //          ),
            //        )
            //      ],
            //    ),
            //  );

            // }
            ));
// );
  }
}
