import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greaticker/common/constants/fonts.dart';
import 'package:greaticker/common/utils/date_time_utils.dart';
import 'package:greaticker/common/utils/integer_format_utils.dart';
import 'package:greaticker/common/utils/url_builder_utils.dart';
import 'package:greaticker/hall_of_fame/model/hall_of_fame_model.dart';
import 'package:greaticker/history/model/enum/history_kind.dart';
import 'package:greaticker/history/model/history_model.dart';
import 'package:greaticker/history/utils/history_utils.dart';
import 'package:greaticker/popular_chart/model/popular_chart_model.dart';

class PopularChartCard extends StatelessWidget {
  final Key key;
  final int rank;
  final String stickerName;
  final String stickerDescription;
  final int hitCnt;

  const PopularChartCard({
    required this.key,
    required this.rank,
    required this.stickerName,
    required this.stickerDescription,
    required this.hitCnt,
  });

  factory PopularChartCard.fromPopularChartModel({
    required PopularChartModel model,
  }) {
    return PopularChartCard(
      key: Key('PopularChartCard-${model.id}'),
      rank: model.rank,
      stickerName: model.stickerName,
      stickerDescription: model.stickerDescription,
      hitCnt: model.hitCnt,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  width: 60,
                  height: 48,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                    child: Text(
                      IntegerFormatUtils.convertToOrdinal(rank) + '\n' + stickerName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w900,
                        fontFamily: YEONGDEOK_SEA,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: SizedBox(
                  width: 75,
                  height: 75,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                    child: Image.asset(UrlBuilderUtils.imageUrlBuilderByStickerName(
                        stickerName)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    stickerDescription,
                    textAlign: TextAlign.justify,
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
                      Icon(Icons.favorite_border_outlined,
                          color: Colors.red),
                      SizedBox(width: 4),
                      Expanded(child: Text(hitCnt.toString())),
                    ],
                  ),
                ),
              )
            ])));
  }
}
