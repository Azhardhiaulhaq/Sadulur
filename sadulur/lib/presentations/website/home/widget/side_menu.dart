import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
  });

  get defaultPadding => 5;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: AppColor.darkDatalab,
      backgroundColor: AppColor.sideMenuColor,
      elevation: 5,
      shadowColor: AppColor.black,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),

            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Card(
                  //   elevation: 2,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   color: Colors.transparent,
                  //   child: Container(
                  //     padding: const EdgeInsets.all(5),
                  //     decoration: BoxDecoration(
                  //         gradient: LinearGradient(
                  //           colors: [
                  //             AppColor.white,
                  //             AppColor.lightGrey
                  //           ], // Define your gradient colors here
                  //           begin: Alignment.topCenter,
                  //           end: Alignment.bottomCenter,
                  //         ),
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: Image.asset(
                  //       "assets/sadulur-logo-no-text.png",
                  //       height: 30,
                  //       width: 30,
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  Flexible(
                      child: Text(
                    "Sadulur Admin",
                    maxLines: 2,
                    style: CustomTextStyles.normalText(
                        color: AppColor.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
            //   child: Card(
            //     elevation: 2,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     color: AppColor.lightMainOrangeColor,
            //     child: Container(
            //         width: MediaQuery.of(context).size.width,
            //         padding:
            //             const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            //         decoration: BoxDecoration(
            //             border: Border.all(
            //               color: AppColor.mainOrangeColor,
            //             ),
            //             borderRadius: BorderRadius.circular(10)),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               maxLines: 2,
            //               "Moch Azhar Dhiaulhaq",
            //               style: CustomTextStyles.normalText(
            //                   color: AppColor.black,
            //                   fontSize: 14,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //             Text(
            //               maxLines: 2,
            //               "Role: Administrator",
            //               style: CustomTextStyles.normalText(
            //                   color: AppColor.black,
            //                   fontSize: 12,
            //                   fontWeight: FontWeight.w400),
            //             ),
            //           ],
            //         )),
            //   ),
            // ),
            const SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: DrawerListTile(
                title: "Dashboard",
                svgSrc: "assets/menu_dashbord.svg",
                press: () {},
                selected: true,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10),
            //   child: DrawerListTile(
            //     title: "Dashboard",
            //     svgSrc: "assets/menu_dashbord.svg",
            //     press: () {},
            //     selected: false,
            //   ),
            // )
            // DrawerListTile(
            //   title: "Posts",
            //   svgSrc: "assets/icons/menu_tran.svg",
            //   press: () {},
            // ),
            // DrawerListTile(
            //   title: "Pages",
            //   svgSrc: "assets/icons/menu_task.svg",
            //   press: () {},
            // ),
            // DrawerListTile(
            //   title: "Categories",
            //   svgSrc: "assets/icons/menu_doc.svg",
            //   press: () {},
            // ),
            // DrawerListTile(
            //   title: "Appearance",
            //   svgSrc: "assets/icons/menu_store.svg",
            //   press: () {},
            // ),
            // DrawerListTile(
            //   title: "Users",
            //   svgSrc: "assets/icons/menu_notification.svg",
            //   press: () {},
            // ),
            // DrawerListTile(
            //   title: "Tools",
            //   svgSrc: "assets/icons/menu_profile.svg",
            //   press: () {},
            // ),
            // DrawerListTile(
            //   title: "Settings",
            //   svgSrc: "assets/icons/menu_setting.svg",
            //   press: () {},
            // ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DrawerListTile extends StatelessWidget {
  DrawerListTile({
    super.key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.selected,
  });
  bool selected;
  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: press,
      iconColor: AppColor.white,
      hoverColor: AppColor.mainOrangeColor.withOpacity(0.4),
      selectedTileColor: AppColor.mainOrangeTileColor,
      horizontalTitleGap: 0.0,
      selected: selected,
      leading: SvgPicture.asset(
        svgSrc,
        color: AppColor.white,
        height: 16,
      ),
      title: Text(
        title,
        style: CustomTextStyles.normalText(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColor.white,
        ),
      ),
    );
  }
}
