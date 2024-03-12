import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:redux/redux.dart';
import 'package:sadulur/constants/colors.dart';
import 'package:sadulur/constants/text_styles.dart';
import 'package:sadulur/main.dart';
import 'package:sadulur/models/forum_post.dart';
import 'package:sadulur/models/user.dart';
import 'package:sadulur/presentations/widgets/circular_progress.dart';
import 'package:sadulur/presentations/widgets/flushbar.dart';
import 'package:sadulur/presentations/forum/widget/new_post_editor.dart';
import 'package:sadulur/presentations/forum/widget/post_card.dart';
import 'package:sadulur/store/app.state.dart';
import 'package:sadulur/store/forum/forum.action.dart';

class ForumPage extends StatelessWidget {
  const ForumPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ForumPageViewModel>(
      converter: (Store<AppState> store) => _ForumPageViewModel(
          posts: store.state.forumState.posts,
          isLoading: store.state.forumState.loading,
          error: store.state.forumState.error,
          user: store.state.loginState.user),
      onInit: (store) => store.dispatch(ForumInitAction()),
      onDidChange: (previousViewModel, viewModel) {
        if (viewModel.error != '') {
          CustomFlushbar.showFlushbar(context, "Error Forum", viewModel.error,
              AppColor.flushbarErrorBG);
        }
      },
      builder: (BuildContext context, _ForumPageViewModel viewModel) {
        return _ForumPageContent(
            title: title,
            isLoading: viewModel.isLoading,
            posts: viewModel.posts,
            user: viewModel.user);
      },
    );
  }
}

class _ForumPageViewModel {
  final List<ForumPost> posts;
  final bool isLoading;
  final UMKMUser user;
  final String error;

  _ForumPageViewModel(
      {required this.posts,
      required this.isLoading,
      required this.user,
      required this.error});
}

class _ForumPageContent extends StatefulWidget {
  final String title;
  final bool isLoading;
  final List<ForumPost> posts;
  final UMKMUser? user;

  const _ForumPageContent(
      {required this.title,
      required this.isLoading,
      required this.posts,
      this.user});

  @override
  _ForumPageContentState createState() => _ForumPageContentState();
}

class _ForumPageContentState extends State<_ForumPageContent> {
  @override
  void didUpdateWidget(covariant _ForumPageContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black), // Plus icon
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                context,
                settings: const RouteSettings(name: '/forum/create'),
                screen: const NewForumEditor(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
          ),
        ],
      ),
      body: Stack(children: [
        RefreshIndicator(
            color: AppColor.darkDatalab,
            onRefresh: () async {
              StoreProvider.of<AppState>(context).dispatch(ForumInitAction());
            },
            notificationPredicate: (ScrollNotification notification) {
              return notification.depth == 1;
            },
            child: CustomScrollView(slivers: <Widget>[
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.builder(
                    itemCount: widget.posts.length,
                    itemBuilder: (context, index) {
                      return ForumPostCard(
                          post: widget.posts[index], user: widget.user!);
                    },
                  ),
                ),
              ),
            ])),
        widget.isLoading
            ? const Center(
                child: CircularProgressCard(),
              )
            : Container(),
      ]),
    );
  }
}
