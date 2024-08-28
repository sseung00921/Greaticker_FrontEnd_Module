import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/component/text_style.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/utils/date_time_utils.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';
import 'package:greaticker/hall_of_fame/view/hall_of_fame_screen.dart';

class HallOfFameCard extends ConsumerStatefulWidget {
  final Key key;
  final String hallOfFameModelId;

  // 유저 닉네임
  final String userNickName;

  // 달성한 목표
  final String? accomplishedTopic;

  // 유저 auth ID
  final String? userAuthId;

  // 좋아요 횟수
  final int likeCount;

  // 달성 일시
  final String accomplishedDate;
  final bool isWrittenByMe;
  final bool isHitGoodByMe;

  const HallOfFameCard({
    required this.key,
    required this.hallOfFameModelId,
    required this.userNickName,
    this.accomplishedTopic,
    this.userAuthId,
    required this.accomplishedDate,
    required this.likeCount,
    required this.isWrittenByMe,
    required this.isHitGoodByMe,
  });

  @override
  _HallOfFameCardState createState() => _HallOfFameCardState();

  factory HallOfFameCard.fromHallOfFameModel({
    required HallOfFameModel model,
  }) {
    return HallOfFameCard(
      key: Key('HallOfFameCard-${model.id}'),
      hallOfFameModelId: model.id,
      userNickName: model.userNickName,
      likeCount: model.likeCount,
      accomplishedTopic: model.accomplishedGoal,
      userAuthId: model.userAuthId,
      accomplishedDate:
          DateTimeUtils.dateTimeToString(model.createdDateTime, 'yyyy-MM-dd'),
      isWrittenByMe: model.isWrittenByMe,
      isHitGoodByMe: model.isHitGoodByMe,
    );
  }
}

class _HallOfFameCardState extends ConsumerState<HallOfFameCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Color _iconColor = Colors.grey;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 2)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse(); // 한쪽 방향으로 회전이 끝나면 반대 방향으로 회전
        } else if (status == AnimationStatus.dismissed) {
          _controller.reset(); // 반대 방향으로 회전이 끝나면 다시 회전 시작
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onIconTapped() {
    _controller.repeat(reverse: true); // 아이콘 클릭 시 반복적으로 회전
    Future.delayed(Duration(milliseconds: 1000), () {
      _controller.stop();
      _controller.reset(); // 일정 시간이 지난 후 회전을 멈춤
    });

    Future.delayed(Duration(seconds: 1), () {
      final parentWidget =
          context.findAncestorStateOfType<HallOfFameScreenState>();
      parentWidget!.actionToDoWhenHallOfFameHitGoodIconWasPressed(
          widget.hallOfFameModelId);
    });
  }

  @override
  Widget build(BuildContext context) {
    String dispalyedUserAuthId =
        widget.userAuthId == null ? '' : '(${widget.userAuthId})';
    String displayedAccomplishedTopic =
        widget.accomplishedTopic == null ? '' : widget.accomplishedTopic!;
    _iconColor = widget.isHitGoodByMe ? Colors.red : Colors.grey;

    Text _cardText = Text(
      _accomplishmentComment(dispalyedUserAuthId, displayedAccomplishedTopic),
      textAlign: TextAlign.start,
      style: YeongdeokSeaTextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
    );

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // 테두리 색상
            width: 1.0, // 테두리 두께
          ),
          borderRadius: BorderRadius.circular(16.0), // 둥근 테두리 (Optional)
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: SizedBox(
                width: 75,
                height: 75,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                  child: Image.asset('assets/img/hall_of_fame/gold_medal.png'),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: _cardText,
                        );
                      },
                    );
                  },
                  child: _cardText,
                ),
              ),
            ),
            SizedBox(
              width: 65,
              height: 61,
              child: Padding(
                padding: EdgeInsets.only(right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: _onIconTapped,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: _animation.value,
                                child: child,
                              );
                            },
                            child: Icon(
                              key: Key("HallOfFameCardHitGoodIcon-${widget.hallOfFameModelId}"),
                              Icons.favorite_border_outlined,
                              color: _iconColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          // 자릿수에 따라 width 조정
                          width: _calculateSpacing(widget.likeCount),
                        ),
                        Expanded(child: Text(widget.likeCount.toString())),
                      ],
                    ),
                    widget.isWrittenByMe
                        ? Flexible(
                            child: IconButton(
                              key: Key(
                                  "HallOfFameCardDeleteButton-${widget.hallOfFameModelId}"),
                              icon: Icon(Icons.delete_forever_outlined),
                              onPressed: () async {
                                final parentWidget =
                                    context.findAncestorStateOfType<
                                        HallOfFameScreenState>();
                                parentWidget!
                                    .actionToDoWhenHallOfFameDeleteIconWasPressed(
                                        widget.hallOfFameModelId);
                              },
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _accomplishmentComment(
      String dispalyedUserAuthId, String displayedAccomplishedTopic) {
    if (dotenv.get(LANGUAGE) == 'KO') {
      return '${widget.userNickName}${dispalyedUserAuthId}님이 ${widget.accomplishedDate}에 ${displayedAccomplishedTopic} 목표를 달성하셨습니다';
    } else if (dotenv.get(LANGUAGE) == 'EN') {
      return '${widget.userNickName}${dispalyedUserAuthId} has achieved the ${displayedAccomplishedTopic} goal on ${widget.accomplishedDate}';
    } else {
      throw Exception();
    }
  }

  double _calculateSpacing(int likeCount) {
    int digitCount = likeCount.toString().length;

    switch (digitCount) {
      case 1:
        return 16.0; // 1자리일 때
      case 2:
        return 8.0;  // 2자리일 때
      case 3:
      default:
        return 4.0;  // 3자리 이상일 때
    }
  }

}
