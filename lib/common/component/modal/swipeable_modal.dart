import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:greaticker/common/component/text_style.dart';
import 'package:greaticker/common/constants/language/button.dart';
import 'package:greaticker/common/constants/language/common.dart';

Future<void> showSwipeableDialog({
  required BuildContext context,
  required List<String> comments, // 모달에 표시할 텍스트 리스트
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return SwipeableDialog(comments: comments);
    },
  );
}

class SwipeableDialog extends StatefulWidget {
  final List<String> comments;

  SwipeableDialog({required this.comments});

  @override
  _SwipeableDialogState createState() => _SwipeableDialogState();
}

class _SwipeableDialogState extends State<SwipeableDialog> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: 400, // 모달의 높이를 고정하여 레이아웃 문제 해결
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '${_currentPage + 1} / ${widget.comments.length}',
                style: YeongdeokSeaTextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              // PageView를 Expanded로 감싸서 레이아웃 문제 해결
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: widget.comments.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Text(
                      widget.comments[index],
                      style: YeongdeokSeaTextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    if (_currentPage > 0) {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    BUTTON_DICT[dotenv.get(LANGUAGE)]!['close']!,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (_currentPage < widget.comments.length - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
