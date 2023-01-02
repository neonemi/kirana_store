import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirana_store/core/core.dart';
import 'package:kirana_store/ui/main/main.dart';

class SmartListDialogBuilder {
  SmartListDialogBuilder(
    this.context,
  );

  final BuildContext context;
  final _controller = PageController();
  final cartController = Get.find<CartController>();
  // List smartList = [
  //   {
  //     'name': 'Smart List 1',
  //     "title": [
  //       'Rice',
  //       'Bread',
  //       'Rice',
  //       'Bread',
  //       'Rice',
  //       'Bread',
  //       'Rice',
  //       'Bread',
  //       'Rice',
  //       'Bread',
  //       'Rice',
  //       'Bread'
  //     ],
  //     "value": [
  //       'Basmati',
  //       'cake',
  //       'Basmati',
  //       'cake',
  //       'Basmati',
  //       'cake',
  //       'Basmati',
  //       'cake',
  //       'Basmati',
  //       'cake',
  //       'Basmati',
  //       'cake'
  //     ],
  //   },
  //   {
  //     'name': 'Smart List 2',
  //     "title": ['Rice', 'Bread', 'Rice', 'Bread', 'Rice', 'Bread'],
  //     "value": ['Basmati', 'cake', 'Basmati', 'cake', 'Basmati', 'cake'],
  //   },
  //   {
  //     'name': 'Smart List 3',
  //     "title": ['Rice', 'Bread', 'Rice'],
  //     "value": ['Basmati', 'cake', 'Basmati'],
  //   },
  //   {
  //     'name': 'Smart List 4',
  //     "title": ['Rice'],
  //     "value": ['Basmati'],
  //   }
  // ];

  showSmartListDialog(
      BuildContext context,
      final void Function(String)? onConfirm,
      SmartListResponse smartProductResponse) {
    var dialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: AppTheme.appWhite,
      alignment: Alignment.topCenter,
      insetPadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.all(8),
      content: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.height - 100,
          child: StatefulBuilder(builder: (context, setState) {
            return GetBuilder<CartController>(
                // no need to initialize Controller ever again, just mention the type
                builder: (value) {
              return PageView.builder(
                controller: _controller,
                itemCount: smartProductResponse.data!.length,
                physics: const NeverScrollableScrollPhysics(),
                padEnds: false,
                itemBuilder: (BuildContext context, int index1) {
                  print(index1 + 1);
                  print(index1 + 1);
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _pop(context);
                          },
                          child: Container(
                            height: 60,
                            alignment: Alignment.centerRight,
                            child: const Icon(Icons.close),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 60,
                              alignment: Alignment.center,
                              child: Text(
                                'Smart List ${index1 + 1}',
                                style: TextStyle(
                                    color: AppTheme.appBlack, fontSize: 22),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 2 / 3 -
                                      60,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: smartProductResponse
                                    .data![index1].smartList!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding: const EdgeInsets.all(8),
                                    width:
                                        MediaQuery.of(context).size.width - 20,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                smartProductResponse
                                                    .data![index1]
                                                    .smartList![index]
                                                    .category
                                                    .toString(),
                                                maxLines: 1,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: AppTheme.appBlack,
                                                    fontSize: 16),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 150,
                                              child: Text(
                                                smartProductResponse
                                                    .data![index1]
                                                    .smartList![index]
                                                    .name
                                                    .toString(),
                                                maxLines: 1,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: AppTheme.appBlack,
                                                    fontSize: 16),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider()
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                            height: 60,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                index1 > 0
                                    ? GestureDetector(
                                        onTap: () {
                                          _controller.previousPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.ease);
                                        },
                                        child: Icon(
                                          Icons.arrow_circle_left,
                                          size: 28,
                                          color: AppTheme.appYellow,
                                        ),
                                      )
                                    : const SizedBox(height: 28, width: 28),
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
                                    var smartList = smartProductResponse
                                        .data![index1].smartList!;
                                    for (int i = 0; i < smartList.length; i++) {
                                      cartController.addProductToCart(
                                        id: smartList[i].id!,
                                        productId: smartList[i].id!,
                                        unitPrice: smartList[i].price!,
                                        unitqty:
                                            smartList[i].unitqty.toString(),
                                        unitqtyname: smartList[i].unitqtyname!,
                                        quantity: smartList[i].quantity!,
                                        price: smartList[i].price!,
                                        imageProduct: smartList[i].image!,
                                        isDiscounted: smartList[i]
                                            .isDiscounted
                                            .toString(),
                                        orderId: smartList[i].id!,
                                        discountedPrice: smartList[i]
                                            .discountedPrice
                                            .toString(),
                                        categoryName: smartList[i].category!,
                                        gst: '',
                                        nameProduct: smartList[i].name!,
                                      );
                                    }
                                    _pop(context);
                                  },
                                  child: const Text(
                                    StringConstant.addToCart,
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                index1 + 1 < smartProductResponse.data!.length
                                    ? GestureDetector(
                                        onTap: () {
                                          _controller.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.ease);
                                        },
                                        child: Icon(
                                          Icons.arrow_circle_right,
                                          size: 28,
                                          color: AppTheme.appYellow,
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 28,
                                        width: 28,
                                      ),
                              ],
                            )),
                      ]);
                  //_samplePages[index % _samplePages.length];
                },
              );
            });
          })),
    );
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => dialog);
  }

  void _pop(BuildContext context) {
   // Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return const HomeContainer(homeItem:HomeItems.myCart);
      },
    ));
  }

}

// cart.add(CartData(
//   id: smartList[i].id,
//   productId: smartList[i].id,
//   unitPrice: smartList[i].price,
//   unitqty:
//       smartList[i].unitqty.toString(),
//   unitqtyname: smartList[i].unitqtyname,
//   quantity: smartList[i].quantity,
//   price: smartList[i].price,
//   image: smartList[i].image,
//   isDiscounted: smartList[i]
//       .isDiscounted
//       .toString(),
//   orderId: smartList[i].id,
//   discountedPrice: smartList[i]
//       .discountedPrice
//       .toString(),
//   categoryName: smartList[i].category,
//   gst: '',
//   name: smartList[i].name,
// ));
// productDataList.add(ProductArray(
//     id: smartList[i].id.toString(),
//     price: smartList[i].price.toString(),
//     name: smartList[i].name.toString(),
//     unitqty:
//         smartList[i].unitqty.toString(),
//     unitqtyname: smartList[i].unitqtyname.toString(),
//     unitprice:
//         smartList[i].price.toString(),
//     qty: smartList[i]
//         .quantity
//         .toString()));
// final String encodedData =
//     CartData.encode(cart);
// context
//     .read<LocalRepository>()
//     .setCartList(encodedData);
// final String encodedProductData =
//     ProductArray.encode(productDataList);
// context
//     .read<LocalRepository>()
//     .setProductList(encodedProductData);
