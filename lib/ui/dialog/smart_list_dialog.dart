import 'package:flutter/material.dart';
import 'package:kirana_store/core/core.dart';

class SmartListDialogBuilder {
  SmartListDialogBuilder(
    this.context,
  );

  final BuildContext context;

  final List<Map<String, dynamic>> sortingList = [
    {
      "title": [
        'Rice',
        'Bread',
        'Rice',
        'Bread',
        'Rice',
        'Bread',
        'Rice',
        'Bread',
        'Rice',
        'Bread',
        'Rice',
        'Bread'
      ],
      "value": [
        'Basmati',
        'cake',
        'Basmati',
        'cake',
        'Basmati',
        'cake',
        'Basmati',
        'cake',
        'Basmati',
        'cake',
        'Basmati',
        'cake'
      ],
    }
  ];
  // final List<Map<String, dynamic>> sortingList = [
  //   {
  //     "title": [
  //       'Rice',
  //       'Bread'
  //     ],
  //     "value": [
  //       'Basmati',
  //       'cake'
  //     ],
  //   }
  // ];
  showSmartListDialog(
      BuildContext context, final void Function(String)? onConfirm) {
    var dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: AppTheme.appWhite,
      insetPadding: const EdgeInsets.only(top: 60),
      alignment: Alignment.topCenter,
      child: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: StatefulBuilder(builder: (context, setState) {
            return Column(mainAxisSize: MainAxisSize.min, children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.only(right: 5, top: 10),
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.close),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width - 20,
                    maxHeight: MediaQuery.of(context).size.height*2/3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 60,
                      alignment: Alignment.center,
                      child: Text(
                        'Smart List 1',
                        style: TextStyle(color: AppTheme.appBlack, fontSize: 22),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*2/3-60,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: sortingList[0]["title"].length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              onConfirm!(sortingList[0]["value"][index]);
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width - 20,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        sortingList[0]["value"][index],
                                        style: TextStyle(
                                            color: AppTheme.appBlack, fontSize: 16),
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        sortingList[0]["title"][index],
                                        style: TextStyle(
                                            color: AppTheme.appBlack, fontSize: 16),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  const Divider()
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 60,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_circle_left,
                        size: 28,
                        color: AppTheme.appYellow,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: AppTheme.appGreen,
                          elevation: 3,
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          //fixedSize: const Size(100, 30),
                          //////// HERE
                        ),
                        onPressed: () {},
                        child: const Text(
                          StringConstant.addToCart,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Icon(
                        Icons.arrow_circle_right,
                        size: 28,
                        color: AppTheme.appYellow,
                      ),
                    ],
                  )),
            ]);
          })),
    );
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => dialog);
  }
}
//import 'package:flutter/material.dart';
// import 'package:kirana_store/core/core.dart';
//
// class SmartListDialogBuilder {
//   SmartListDialogBuilder(
//     this.context,
//   );
//
//   final BuildContext context;
//   List smartList = [
//     {
//       'name': 'Smart List 1',
//       "title": [
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread'
//       ],
//       "value": [
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake'
//       ],
//     },
//     {
//       'name': 'Smart List 2',
//       "title": [
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread'
//       ],
//       "value": [
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake'
//       ],
//     },
//     {
//       'name': 'Smart List 3',
//       "title": [
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread'
//       ],
//       "value": [
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake'
//       ],
//     }
//   ];
//   final List<Map<String, dynamic>> sortingList = [
//     {
//       "title": [
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread',
//         'Rice',
//         'Bread'
//       ],
//       "value": [
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake',
//         'Basmati',
//         'cake'
//       ],
//     }
//   ];
//   // final List<Map<String, dynamic>> sortingList = [
//   //   {
//   //     "title": [
//   //       'Rice',
//   //       'Bread'
//   //     ],
//   //     "value": [
//   //       'Basmati',
//   //       'cake'
//   //     ],
//   //   }
//   // ];
//   showSmartListDialog(
//       BuildContext context, final void Function(String)? onConfirm) {
//     var dialog = Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       backgroundColor: AppTheme.appWhite,
//       insetPadding: const EdgeInsets.only(top: 60),
//       alignment: Alignment.topCenter,
//       child: SizedBox(
//           width: MediaQuery.of(context).size.width - 20,
//           height: MediaQuery.of(context).size.height - 150,
//           child: StatefulBuilder(builder: (context, setState) {
//             final controller = PageController(
//               initialPage: 0,
//               viewportFraction: 1,
//             );
//             //smartList
//             return PageView.builder(
//                 padEnds: false,
//                 controller: controller,
//                 itemCount: smartList.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Column(mainAxisSize: MainAxisSize.min, children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(4),
//                         margin: const EdgeInsets.only(right: 5, top: 10),
//                         alignment: Alignment.centerRight,
//                         child: const Icon(Icons.close),
//                       ),
//                     ),
//                     Container(
//                       height: 60,
//                       alignment: Alignment.center,
//                       child: Text(
//                         smartList[index]['name'],
//                         style:
//                             TextStyle(color: AppTheme.appBlack, fontSize: 22),
//                         textAlign: TextAlign.start,
//                       ),
//                     ),
//                     Container(
//                       constraints: BoxConstraints(
//                           minWidth: MediaQuery.of(context).size.width - 20,
//                           maxHeight: MediaQuery.of(context).size.height - 350),
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         physics: const ClampingScrollPhysics(),
//                         itemCount: smartList.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return GestureDetector(
//                             onTap: () {
//                               onConfirm!(smartList[index]["value"][index]);
//                               Navigator.pop(context);
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.all(8),
//                               width: MediaQuery.of(context).size.width - 20,
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Text(
//                                         smartList[index]["value"][index],
//                                         style: TextStyle(
//                                             color: AppTheme.appBlack,
//                                             fontSize: 16),
//                                         textAlign: TextAlign.start,
//                                       ),
//                                       Text(
//                                         smartList[index]["title"][index],
//                                         style: TextStyle(
//                                             color: AppTheme.appBlack,
//                                             fontSize: 16),
//                                         textAlign: TextAlign.start,
//                                       ),
//                                     ],
//                                   ),
//                                   const Divider()
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Container(
//                         height: 60,
//                         alignment: Alignment.center,
//                         padding: const EdgeInsets.all(8),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 controller.previousPage(
//                                     duration: Duration(milliseconds: 300),
//                                     curve: Curves.ease);
//                               },
//                               child: Icon(
//                                 Icons.arrow_circle_left,
//                                 size: 28,
//                                 color: AppTheme.appYellow,
//                               ),
//                             ),
//                             ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 foregroundColor: Colors.white,
//                                 backgroundColor: AppTheme.appGreen,
//                                 elevation: 3,
//                                 padding: const EdgeInsets.all(8),
//                                 alignment: Alignment.center,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30.0)),
//                                 //fixedSize: const Size(100, 30),
//                                 //////// HERE
//                               ),
//                               onPressed: () {},
//                               child: const Text(
//                                 StringConstant.addToCart,
//                                 style: TextStyle(fontSize: 14),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 controller.nextPage(
//                                     duration: Duration(milliseconds: 300),
//                                     curve: Curves.ease);
//                               },
//                               child: Icon(
//                                 Icons.arrow_circle_right,
//                                 size: 28,
//                                 color: AppTheme.appYellow,
//                               ),
//                             ),
//                           ],
//                         )),
//                   ]);
//                 });
//           })),
//     );
//     showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (BuildContext context) => dialog);
//   }
// }