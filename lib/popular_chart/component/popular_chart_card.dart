import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:greaticker/common/component/text_style.dart';
import 'package:greaticker/common/constants/fonts.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/language/stickers.dart';
import 'package:greaticker/common/utils/integer_format_utils.dart';
import 'package:greaticker/common/utils/url_builder_utils.dart';
import 'package:greaticker/popular_chart/model/popular_chart_model.dart';

class PopularChartCard extends StatelessWidget {
  final Key key;
  final String stickerId;
  final int rank;
  final int hitCnt;

  const PopularChartCard({
    required this.key,
    required this.stickerId,
    required this.rank,
    required this.hitCnt,
  });

  factory PopularChartCard.fromPopularChartModel({
    required PopularChartModel model,
  }) {
    return PopularChartCard(
      key: Key('PopularChartCard-${model.id}'),
      stickerId: model.id,
      rank: model.rank,
      hitCnt: model.hitCnt,
    );
  }

  @override
  Widget build(BuildContext context) {
    String stickerName = STICKER_ID_STICKER_INFO_MAPPER[dotenv.get(LANGUAGE)]![stickerId]!["name"]!;
    String stickerDescription = STICKER_ID_STICKER_INFO_MAPPER[dotenv.get(LANGUAGE)]![stickerId]!["description"]!;

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
                      style: YeongdeokSeaTextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w900,
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
                    child: Image.asset(UrlBuilderUtils.imageUrlBuilderByStickerId(stickerId)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    stickerDescription,
                    textAlign: TextAlign.justify,
                    style: YeongdeokSeaTextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
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
