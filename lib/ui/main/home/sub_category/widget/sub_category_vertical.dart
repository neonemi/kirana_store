import 'package:flutter/material.dart';
import 'package:kirana_store/core/core.dart';
import 'package:kirana_store/ui/main/home/home.dart';
import 'package:kirana_store/ui/ui.dart';

class SubCategoryVerticalList extends StatelessWidget {
  final List<SubCategoryData>? categoryData;
  final String bannerImage;
  const SubCategoryVerticalList(
      {super.key, required this.categoryData, required this.bannerImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: categoryData!.length,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => FoodItemScreen(
                          itemName: categoryData![index].name != null
                              ? categoryData![index].name.toString()
                              : "",
                          id: categoryData![index].id != null
                              ? (categoryData![index].id!).toString()
                              : "",
                        )))
              },
              child: Stack(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 200,
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: AppImageLoader(
                        imageUrl: bannerImage,
                        boxFit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width - 60,
                        height: 200,
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 200,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 50,
                          //  width: 100,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppTheme.appWhite, width: 2),
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            categoryData![index].name!,
                            style: TextStyle(
                                color: AppTheme.appWhite,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
