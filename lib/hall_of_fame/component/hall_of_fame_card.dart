import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/fonts.dart';
import 'package:greaticker/common/utils/date_time_utils.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';

class HallOfFameCard extends ConsumerWidget {
  final Key key;
  final String id;

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

  const HallOfFameCard({
    required this.key,
    required this.id,
    required this.userNickName,
    this.accomplishedTopic,
    this.userAuthId,
    required this.accomplishedDate,
    required this.likeCount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String dispalyedUserAuthId = this.userAuthId == null ? '' : '(${this.userAuthId})';
    String displayedAccomplishedTopic = this.accomplishedTopic == null ? '' : this.accomplishedTopic!;

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
                child: Text(
                  '${userNickName}${dispalyedUserAuthId}님이 ${accomplishedDate}에 ${displayedAccomplishedTopic} 목표를 달성하셨습니다',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: YEONGDEOK_SEA,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(
              width: 65,
              height: 61,
              child: Padding(
                padding: EdgeInsets.only(right: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                        onTap: () => print("clicked like."),
                        child: Icon(Icons.favorite_border_outlined, color: Colors.red)),
                    SizedBox(width: 4),
                    Expanded(child: Text(likeCount.toString())),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  factory HallOfFameCard.fromHallOfFameModel({
    required HallOfFameModel model,
  }) {
    return HallOfFameCard(
      key: Key('HallOfFameCard-${model.id}'),
      id: model.id,
      userNickName: model.userNickName,
      likeCount: model.likeCount,
      accomplishedTopic: model.accomplishedTopic,
      userAuthId: model.userAuthId,
      accomplishedDate: DateTimeUtils.dateTimeToString(model.createdDateTime, 'yyyy-MM-dd'),
    );
  }
}