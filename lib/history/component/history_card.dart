import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:greaticker/common/component/text_style.dart';
import 'package:greaticker/common/constants/fonts.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/language/stickers.dart';
import 'package:greaticker/common/utils/date_time_utils.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';
import 'package:greaticker/history/model/enum/history_kind.dart';
import 'package:greaticker/history/model/history_model.dart';
import 'package:greaticker/history/utils/history_utils.dart';

class HistoryCard extends StatelessWidget {
  final Key key;
  final HistoryKind historyKind;
  final String projectName;
  final String? stickerId;
  final int? dayInARow;
  final String dateTime;

  const HistoryCard({
    required this.key,
    required this.historyKind,
    required this.projectName,
    this.stickerId,
    this.dayInARow,
    required this.dateTime,
  });

  factory HistoryCard.fromHistoryModel({
    required HistoryModel model,
  }) {
    return HistoryCard(
      key: Key('HistoryCard-${model.id}'),
      historyKind: model.historyKind,
      projectName: model.projectName,
      stickerId: model.stickerId,
      dayInARow: model.dayInARow,
      dateTime:
          DateTimeUtils.dateTimeToString(model.createdDateTime, 'yyyyMM-dd'),
    );
  }

  @override
  Widget build(BuildContext context) {
    Text _cardText = Text(
      HistoryUtils.historyContentMaker(
          historyKind: historyKind,
          projectName: projectName,
          stickerName: stickerId != null ? STICKER_ID_STICKER_INFO_MAPPER[dotenv.get(LANGUAGE)]![stickerId]!['name'] : null,
          dayInARow: dayInARow),
      textAlign: TextAlign.start,
      style: YeongdeokSeaTextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      maxLines: 3,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
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
            child: Row(children: [
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: SizedBox(
                  width: 75,
                  height: 75,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                    child: Image.asset(HistoryUtils.historyImageUrlSelector(
                        historyKind: historyKind, stickerName: STICKER_ID_NAME_MAPPER[stickerId])),
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
                  child: Center(
                    child: Text(
                      dateTime.substring(0, 4) + '\n' + dateTime.substring(4),
                      textAlign: TextAlign.center,
                      style: YeongdeokSeaTextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            ])));
  }
}
