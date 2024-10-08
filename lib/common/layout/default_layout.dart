import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:greaticker/common/component/iconWithLabel.dart';
import 'package:greaticker/common/component/modal/swipeable_modal.dart';
import 'package:greaticker/common/component/text_style.dart';
import 'package:greaticker/common/constants/colors.dart';
import 'package:greaticker/common/constants/fonts.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/language/tap_label.dart';
import 'package:greaticker/common/constants/language/title.dart';
import 'package:greaticker/common/constants/language/tutorial.dart';
import 'package:greaticker/common/constants/tabs.dart';



class DefaultLayout extends StatefulWidget {
  static String get routeName => 'DefaultLayout';

  final Key key;
  final String language;
  final Widget child;
  final String title_key;

  const DefaultLayout({
    required this.key,
    required this.language,
    required this.child,
    required this.title_key,
  }) : super(key: key);

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout>
    with TickerProviderStateMixin {
  late final TabController bottomTabController;
  late final Map<String, String> TAB_LABEL_TRANS_DICT;
  late final Map<String, String> TITLE_TRANS_DICT;
  late String title;
  late int
      selectedTapIndex; //Bottom인덱스는 BottomNavigaionBar의 속성으로 구현할 수 있으므로 커스텀하게 구현할 필요가 없다.

  @override
  void initState() {
    super.initState();

    TAB_LABEL_TRANS_DICT = TAB_LABEL_DICT[widget.language]!;
    TITLE_TRANS_DICT = TITLE_DICT[widget.language]!;

    title = TITLE_TRANS_DICT[widget.title_key]!;
    selectedTapIndex = _transTitleKeyToIndex(widget.title_key)!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(OUR_MAIN_BASE_COLOR),
      appBar: _renderAppBar(Key('CommonAppBar'), title),
      body: widget.child,
      bottomNavigationBar:
          _renderBottomNavigationBar(Key('CommonBottomNavigationBar')),
    );
  }

  AppBar? _renderAppBar(Key key, String title) {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        key: key,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title,
          style: YeongdeokSeaTextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        foregroundColor: Colors.black,
        actions: widget.title_key == 'tutorial' || widget.title_key == 'history' || widget.title_key == 'profile'
            ? []
            : TOP_TABS
                .map((e) => Material(
                      key: Key(e.label_key + "TopTapButton"),
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => e.label_key == 'tutorial' ? _showTutorial() :
                            context.push(_transTapIndexToUrlPath(e.index!)!),
                        borderRadius: BorderRadius.circular(24.0),
                        child: Container(
                          color: Colors.transparent,
                          // 클릭 가능한 영역을 시각적으로 확인하기 위해 색상을 설정할 수 있음
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: IconWithLabel(
                              icon: e.icon,
                              label: TAB_LABEL_TRANS_DICT[e.label_key]!,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
      );
    }
  }

  BottomNavigationBar? _renderBottomNavigationBar(Key key) {
    if (['history', 'profile'].contains(widget.title_key)) {
      //topIcon이 선택되면 바텀네비게이션 내린다.
      return null;
    }
    return BottomNavigationBar(
      key: key,
      currentIndex: _transTitleKeyToIndex(widget.title_key)!,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: (index) {
        context.go(_transTapIndexToUrlPath(index)!);
      },
      items: BOTTOM_TABS
          .map(
            (e) => BottomNavigationBarItem(
              key: Key(e.label_key + "BottomTapButton"),
              icon: Icon(
                e.icon,
              ),
              label: TAB_LABEL_TRANS_DICT[e.label_key],
            ),
          )
          .toList(),
    );
  }

  int? _transTitleKeyToIndex(String titleKey) {
    if (titleKey == 'home')
      return 0;
    else if (titleKey == 'diary')
      return 1;
    else if (titleKey == 'hall_of_fame')
      return 2;
    else if (titleKey == 'popular_chart')
      return 3;
    else if (titleKey == 'history')
      return 4;
    else if (titleKey == 'profile') return 5;
  }

  String? _transTapIndexToUrlPath(int tapIndex) {
    if (tapIndex == 0)
      return '/home';
    else if (tapIndex == 1)
      return '/diary';
    else if (tapIndex == 2)
      return '/hall-of-fame';
    else if (tapIndex == 3)
      return '/popular-chart';
    else if (tapIndex == 5)
      return '/history';
    else if (tapIndex == 6) return '/profile';
  }

  _showTutorial() {
    List<String> turorialList = TUTORIAL_TEXT_LIST[dotenv.get(LANGUAGE)]!;
    showSwipeableDialog(context: context, comments: turorialList);
  }
}
