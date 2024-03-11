import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/models/umkm_store.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/widgets/circular_progress.dart';
import 'package:sadulur/presentations/widgets/flushbar.dart';
import 'package:sadulur/presentations/home/widget/store_card.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/login/login.action.dart';
import 'package:sadulur/store/umkm_store/umkm_store.action.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _UmkmPageViewModel>(
      converter: (Store<AppState> store) => _UmkmPageViewModel(
          error: store.state.umkmStoreState.error,
          umkmStores: store.state.umkmStoreState.umkmStores,
          user: store.state.loginState.user,
          isLoading: store.state.umkmStoreState.loading),
      onInit: (store) {
        store.dispatch(GetAllUmkmStoreAction());
        store.dispatch(
            GetUserDetailAction(userID: store.state.loginState.user.id));
      },
      builder: (BuildContext context, _UmkmPageViewModel viewModel) {
        return _HomePageContent(
          title: "UMKM Dashboard",
          isLoading: viewModel.isLoading,
          stores: viewModel.umkmStores,
        );
      },
      onDidChange: (previousViewModel, viewModel) {
        if (viewModel.error != '') {
          CustomFlushbar.showFlushbar(context, "Error Loading Stores",
              viewModel.error, Colors.red[100]!);
        }
      },
    );
  }
}

class _UmkmPageViewModel {
  final List<UMKMStore> umkmStores;
  final bool isLoading;
  final String error;
  final UMKMUser user;

  _UmkmPageViewModel(
      {required this.umkmStores,
      required this.isLoading,
      required this.error,
      required this.user});
}

class _HomePageContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final List<UMKMStore> stores;

  const _HomePageContent(
      {required this.title, required this.isLoading, required this.stores});

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<_HomePageContent> {
  List<UMKMStore> filteredStores = [];
  String? selectedLevel;
  String query = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      filteredStores = widget.stores;
    });
  }

  @override
  void didUpdateWidget(covariant _HomePageContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      filteredStores = widget.stores;
    });
  }

  void filterStores() {
    setState(() {
      // query = queryValue;
      if (query.isEmpty && selectedLevel == null) {
        filteredStores = widget.stores;
        return;
      } else if (query.isEmpty && selectedLevel != null) {
        filteredStores = widget.stores.where((store) {
          return store.level == selectedLevel;
        }).toList();
      } else if (query.isNotEmpty && selectedLevel == null) {
        filteredStores = widget.stores.where((store) {
          final name = store.umkmName?.toLowerCase() ?? '';
          return name.contains(query.toLowerCase());
        }).toList();
      } else {
        filteredStores = widget.stores.where((store) {
          final name = store.umkmName?.toLowerCase() ?? '';
          return name.contains(query.toLowerCase()) &&
              store.level == selectedLevel;
        }).toList();
      }
    });
  }

  // void filterByLevel(String? level) {
  //   setState(() {
  //     selectedLevel = level;
  //     if (level == null && query == null) {
  //       filteredStores = filteredStores;
  //     } else if (level == null && query != null) {
  //       filterStores(query!);
  //     } else {
  //       filteredStores = widget.stores.where((store) {
  //         return store.level == level;
  //       }).toList();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sadulur',
                style: CustomTextStyles.appBarTitle1,
              ),
              Text(
                widget.title,
                style: CustomTextStyles.appBarTitle2,
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
                color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          constraints: const BoxConstraints(maxHeight: 60),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                query = value;
                              });
                              filterStores();
                            },
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: const Icon(Icons.search),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: AppColor.backgroundGrey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: AppColor.darkDatalab, width: 1.2),
                              ),
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: DropdownButton<String>(
                        value: selectedLevel,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedLevel = newValue;
                          });
                          filterStores();
                        },
                        items: <String?>[
                          null, // Add an option to reset filter
                          'micro',
                          'small',
                          'medium',
                        ].map<DropdownMenuItem<String>>((String? value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value ?? 'All'),
                          );
                        }).toList(),
                      ),
                    ),
                    filteredStores.isNotEmpty
                        ? Expanded(
                            child: RefreshIndicator(
                                color: AppColor.darkDatalab,
                                onRefresh: () async {
                                  StoreProvider.of<AppState>(context)
                                      .dispatch(GetAllUmkmStoreAction());
                                },
                                notificationPredicate:
                                    (ScrollNotification notification) {
                                  return notification.depth == 1;
                                },
                                child: CustomScrollView(slivers: <Widget>[
                                  SliverToBoxAdapter(
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      child: ListView.builder(
                                        itemCount: filteredStores.length,
                                        itemBuilder: (context, index) {
                                          return UMKMStoreCard(
                                              store: filteredStores[index]);
                                        },
                                      ),
                                    ),
                                  ),
                                ])))
                        : Expanded(
                            child: Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                Icon(
                                  MdiIcons.storeOff,
                                  size: 48,
                                  color: AppColor.darkDatalab,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text('Toko Tidak Ditemukan',
                                    style: CustomTextStyles.normalText(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(
                                            255, 111, 34, 34))),
                              ],
                            ),
                          )),
                    const SizedBox(
                      height: 70,
                    ),
                  ],
                )),
            widget.isLoading
                ? const Center(
                    child: CircularProgressCard(),
                  )
                : Container(),
          ],
        ));
  }
}
