import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kirana_store/ui/main/home/home.dart';

import '../../../core/core.dart';
import '../../ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String addressName = 'No Address Available';
  loadData(BuildContext context) async {
    return HomeCubit(context.read<CoreRepository>())..getBannerImage();
  }
  late final HomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    getAddress();
  }

  Future<void> getAddress() async {
    String address1= await context.read<LocalRepository>().getAddress();
    if(address1.isNotEmpty){
      setState(() {
        addressName = address1;
      });
    }
  }
  @override
  void dispose() {
    super.dispose();
    _cubit.close();
  }
  @override
  Widget build(BuildContext context) {
    return   MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>(
        create: (context) {
          _cubit=HomeCubit(context.read<CoreRepository>())..getBannerImage();
          return _cubit;
        }),
          // BlocProvider<HomeCubit>(
          //     create: (context) {
          //       return HomeCubit(context.read<CoreRepository>())..getFoodCategory();
          //     }),
    ],
        child: BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (kDebugMode) {
              print(state);
            }
            if (state is HomeLoading) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }
          },
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: AppTheme.appWhite,
              iconTheme: IconThemeData(color: AppTheme.appWhite),
              centerTitle: true,
              elevation: 0.0,
              leading:  Container(
                // padding: EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: Image.asset(AppIconKeys.homeIcon,
                        width: 37,
                        color: AppTheme.appBlack,
                        height: 30),
                  ),
                ),
              ),
              title: Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    addressName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppTheme.appBlack,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontFamily: StringConstant.fontFamily),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    SmartListResponse smartProductResponse = SmartListResponse.fromJson(smartData);
                    if(smartProductResponse.data != null ){
                      if(smartProductResponse.data!.isNotEmpty){
                        debugPrint('smart $smartProductResponse');
                        SmartListDialogBuilder(context)
                            .showSmartListDialog(context, (String value) {
                          debugPrint(value);
                        }, smartProductResponse);
                      }
                    }
                  },
                  child:
                    Container(
                      height: 20,
                      width: 20,
                    margin: const EdgeInsets.only(right: 20),
                    child: Center(
                      child: Icon( FontAwesome.list_alt,
                          size: 32,
                          color: AppTheme.appBlack,),
                    ),
                  ),
                ),
              ],

            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    alignment: Alignment.topLeft,
                    child: RefreshIndicator(
                      color: AppTheme.appYellow,
                      onRefresh: () => loadData(context),
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          BlocBuilder<HomeCubit, HomeState>(
                              buildWhen: (previous, current) =>
                                  current is HomeSuccess,

                              builder: (context, state) {
                                if (state is HomeLoading) {
                                  context.loaderOverlay.show();
                                } else {
                                  context.loaderOverlay.hide();
                                }
                                if (state is HomeSuccess) {
                                  GetBannerImage bannerImage = state.response;
                                  if (kDebugMode) {
                                    print(
                                        'response 3  $bannerImage');
                                  }
                                  return bannerImage.data == null
                                      ?  Container( height: 200,)
                                      : HomeHorizontalList(
                                          bannerData: bannerImage.data!,
                                        );
                                }
                                return Container( height: 200,);
                              }),
                          searchBarClick(context,
                              MediaQuery.of(context).size.width * 0.02),
                          BlocBuilder<HomeCubit, HomeState>(
                              buildWhen: (previous, current) =>
                                  current is HomeCategorySuccess,
                              builder: (context, state) {
                                if (state is HomeCategorySuccess) {
                                  GetFoodCategory foodCategory =
                                      state.response;
                                  if (kDebugMode) {
                                    print(
                                        'response 3  ${foodCategory.data}');
                                  }
                                  return foodCategory.data == null
                                      ? const SizedBox.shrink(): SizedBox(
                                     // height: 300,
                                      child: HomeVerticalList(categoryData: foodCategory.data!,));
                                }
                                return const SizedBox.shrink();
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }



  Widget searchBarClick(BuildContext context, double bodyMargin) {
    var searchController = TextEditingController();
    return Container(
      margin: EdgeInsets.only(
          left: bodyMargin, right: bodyMargin, top: 12, bottom: 14),
      child: TextField(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
              const SearchScreen()));
        },
        controller: searchController,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.none,
        textDirection: TextDirection.ltr,
        cursorColor: Colors.grey.shade300,
        cursorHeight: 0.0,
        cursorWidth: 0.0,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            suffixIcon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            fillColor: Colors.grey.shade300,
            filled: true,
            hintText: StringConstant.searchHint,
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            disabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                borderSide: BorderSide(color: Colors.grey.shade300))),
        onChanged: (value) {
          debugPrint(value);
          // searchController.text = value;
        },
        onSubmitted: (String value) {},
      ),
    );
  }
}
