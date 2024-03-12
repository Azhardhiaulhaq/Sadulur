import 'package:flutter/material.dart';
import 'package:sadulur_admin/core/size_constants.dart';
import 'package:sadulur_admin/presentation/dashboard/widgets/header.dart';
import 'package:sadulur_admin/presentation/dashboard/widgets/mini_information.dart';
import 'package:sadulur_admin/presentation/dashboard/widgets/recent_user.dart';
import 'package:sadulur_admin/responsive.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        //padding: EdgeInsets.all(defaultPadding),
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              MiniInformation(),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        //MyFiels(),
                        //SizedBox(height: defaultPadding),
                        RecentUsers(),
                        // SizedBox(height: defaultPadding),
                        // RecentDiscussions(),
                        // if (Responsive.isMobile(context))
                        //   SizedBox(height: defaultPadding),
                        // if (Responsive.isMobile(context)) UserDetailsWidget(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  // // On Mobile means if the screen is less than 850 we dont want to show it
                  // if (!Responsive.isMobile(context))
                  //   Expanded(
                  //     flex: 2,
                  //     child: UserDetailsWidget(),
                  //   ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
