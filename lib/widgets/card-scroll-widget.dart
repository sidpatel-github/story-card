import 'dart:math';

import 'package:flutter/material.dart';
import 'package:story_app/utils/data.dart';

class CardScrollWidget extends StatelessWidget {
  final padding = 20.0;
  final verticalInset = 20.0;

  var currentPage;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    double cardAspectRatio = 12.0 / 16.0;
    double widgetAspectRatio = cardAspectRatio * 1.2;

    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          var width = constraints.maxWidth;
          var height = constraints.maxHeight;

          var safeWidth = width - 2 * padding;
          var safeHeight = height - 2 * padding;

          var heightOfPrimaryCard = safeHeight;
          var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

          var primaryCardLeft = safeWidth - widthOfPrimaryCard;
          var horizontalInset = primaryCardLeft / 2;

          List<Widget> cardList = new List();

          for (var i = 0; i < images.length; i++) {
            var delta = i - currentPage;
            bool isOnRight = delta > 0;
            var start = padding +
                max(
                    primaryCardLeft -
                        horizontalInset * -delta * (isOnRight ? 15 : 1),
                    0.0);

            var cardItem = Positioned.directional(
              top: padding + verticalInset * max(-delta, 0.0),
              bottom: padding + verticalInset * max(-delta, 0.0),
              start: start,
              textDirection: TextDirection.rtl,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0,
                    )
                  ]),
                  child: AspectRatio(
                    aspectRatio: cardAspectRatio,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.asset(images[i], fit: BoxFit.cover),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Text(
                                  title[i],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontFamily: 'SF-Pro-Text-Regular',
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, bottom: 12.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 6.0),
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Text(
                                    'Read Later',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
            cardList.add(cardItem);
          }
          return Stack(
            children: cardList,
          );
        },
      ),
    );
  }
}
