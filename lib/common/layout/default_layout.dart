import 'package:flutter/material.dart';
import 'package:greaticker/common/components/iconWithLabel.dart';
import 'package:greaticker/common/constants/tabs.dart';
import '../constants/colors.dart';
import '../constants/language.dart';

class DefaultLayout extends StatefulWidget {
  final Key key;
  final String language;

  const DefaultLayout({
    required this.key,
    required this.language,
  }) : super(key: key);

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout>
    with TickerProviderStateMixin {
  late final TabController bottomTabController;
  late final Map<String, String> DICT;
  late String title;

  int _selectedTopIconIndex =
      -1; //Bottom인덱스는 BottomNavigaionBar의 속성으로 구현할 수 있으므로 커스텀하게 구현할 필요가 없다.

  void _onTopIconTapped(int index) {
    setState(() {
      _selectedTopIconIndex = index;
      title = DICT[TOP_TABS[_selectedTopIconIndex].label_key]!;
    });
  }

  @override
  void initState() {
    super.initState();

    DICT = widget.language == 'KO' ? KO : EN;

    bottomTabController = TabController(
      initialIndex: 0,
      length: BOTTOM_TABS.length,
      vsync: this,
    );

    title = DICT[BOTTOM_TABS[bottomTabController.index].label_key]!;
    bottomTabController.addListener(() {
      setState(() {
        title = DICT[BOTTOM_TABS[bottomTabController.index].label_key]!;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(OUR_MAIN_BASE_COLOR),
      appBar: renderAppBar(Key('CommonAppBar'), title),
      body: renderBody(Key('CommonBody')),
      bottomNavigationBar: renderBottomNavigationBar(Key('CommonBottomNavigationBar')),
    );
  }

  AppBar? renderAppBar(Key key, String title) {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        key: key,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
            fontFamily: "YeongdeokSea",
          ),
        ),
        foregroundColor: Colors.black,
        actions: TOP_TABS
            .map((e) => Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _onTopIconTapped(e.index!),
                borderRadius: BorderRadius.circular(24.0),
                child: Container(
                  color: Colors.transparent, // 클릭 가능한 영역을 시각적으로 확인하기 위해 색상을 설정할 수 있음
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: IconWithLabel(
                      icon: e.icon,
                      label: DICT[e.label_key]!,
                      index: e.index!,
                      isSelected: _selectedTopIconIndex == e.index,
                    ),
                  ),
                ),
              ),
            ))
            .toList(),
      );
    }
  }


  renderBody(Key key) {
    return TabBarView(
        key: key,
        controller: bottomTabController,
        children: BOTTOM_TABS
            .map(
              (e) => Center(
                child: Icon(
                  e.icon,
                ),
              ),
            )
            .toList());
  }

  renderBottomNavigationBar(Key key) {
    if (_selectedTopIconIndex != -1) {
      //topIcon이 선택되면 바텀네비게이션 내린다.
        return null;
    }
    return BottomNavigationBar(
      key: key,
      currentIndex: bottomTabController.index,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: (index) {
        bottomTabController.animateTo(index);
        _selectedTopIconIndex = -1;
      },
      items: BOTTOM_TABS
          .map(
            (e) => BottomNavigationBarItem(
              icon: Icon(
                e.icon,
              ),
              label: DICT[e.label_key],
            ),
          )
          .toList(),
    );
  }
}
