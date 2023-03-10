import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kirana_store/core/core.dart';

import 'search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  late final SearchCubit _cubit;
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>(
            create: (context) {
              _cubit=SearchCubit(context.read<CoreRepository>())..getSearchProduct(text: '5gmYcjfO9q');
              return _cubit;
            }),
        // BlocProvider<HomeCubit>(
        //     create: (context) {
        //       return HomeCubit(context.read<CoreRepository>())..getFoodCategory();
        //     }),
      ],
      child: BlocListener<SearchCubit, SearchState>(
          listener: (context, state) {
            if (kDebugMode) {
              print(state);
            }
            if (state is SearchLoading) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }
          },
        child: Scaffold(
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
                  StringConstant.search,
                  style: TextStyle(
                      color: AppTheme.appWhite,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontFamily: StringConstant.fontFamily),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            body: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Stack(
                children: [
                  Container(
                      height: 90,
                      color: AppTheme.appYellow,
                      child: searchBar(
                          context, MediaQuery.of(context).size.width * 0.07)),
                  BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                        if (state is SearchSuccess) {
                          GetSearchProduct getSearchProduct =
                              state.response;
                          if (kDebugMode) {
                            print(
                                'response 3  ${getSearchProduct.data}');
                          }
                          return getSearchProduct.data == null
                              ?  Container(
                            margin: const EdgeInsets.only(top: 90),
                            child: ListView(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  StringConstant.sorryNoProduct,
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      _navigationPop(context);
                                    },
                                    child: Text(
                                      StringConstant.clickingHere,
                                      style: TextStyle(
                                          color: AppTheme.appYellow,
                                          fontSize: 14,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ))
                              ],
                            ),
                          ):getSearchProduct.data!.isEmpty
                              ?  Container(
                            margin: const EdgeInsets.only(top: 90),
                            child: ListView(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  StringConstant.sorryNoProduct,
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      _navigationPop(context);
                                    },
                                    child: Text(
                                      StringConstant.clickingHere,
                                      style: TextStyle(
                                          color: AppTheme.appYellow,
                                          fontSize: 14,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ))
                              ],
                            ),
                          ): Container(
                              margin: const EdgeInsets.only(top: 100),
                              child: SearchProductScreen(productData: getSearchProduct.data!,));
                        }
                      return Container(
                        margin: const EdgeInsets.only(top: 90),
                        child: ListView(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              StringConstant.sorryNoProduct,
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  _navigationPop(context);

                                },
                                child: Text(
                                  StringConstant.clickingHere,
                                  style: TextStyle(
                                      color: AppTheme.appYellow,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ))
                          ],
                        ),
                      );
                    }
                  )
                ],
              ),
            ))));
      }


  Widget searchBar(BuildContext context, double bodyMargin) {
    var searchController = TextEditingController();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: bodyMargin, vertical: 22),
      child: TextFormField(
        controller: searchController,
        textInputAction: TextInputAction.search,
        textDirection: TextDirection.ltr,
        keyboardType: TextInputType.text,
        style: TextStyle(color: AppTheme.appWhite),
        cursorColor: AppTheme.appYellow,
        cursorHeight: 0.0,
        cursorWidth: 0.0,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            fillColor: AppTheme.appYellow,
            filled: true,
            hintText: StringConstant.searchHint,
            hintStyle: TextStyle(color: AppTheme.appWhite),
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: AppTheme.appWhite)),
            disabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: AppTheme.appWhite)),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: AppTheme.appWhite)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: AppTheme.appWhite)),
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: AppTheme.appWhite))),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter
        ],
        onChanged: (value) {
          debugPrint(value);
        //  _cubit.getSearchProduct(text: searchController.text);
        },
        onFieldSubmitted: (String value) {

          _cubit.getSearchProduct(text: value);
          setState(() {
            searchController.text=value;
          });
        },
      ),
    );
  }
 void _navigationPop(BuildContext context){
   Navigator.of(context).pop();
 }
}