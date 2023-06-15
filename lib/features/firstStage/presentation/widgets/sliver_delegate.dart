import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/common/colors.dart';
import 'package:todo_list/common/fonts_size.dart';
import 'package:todo_list/features/firstStage/presentation/provider/provider.dart';

class CustomSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  double closedHeight;
  double openHeight;

  CustomSliverPersistentHeaderDelegate({
    required this.closedHeight,
    required this.openHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    ProviderTask provider = Provider.of<ProviderTask>(context);

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: iconPaddingtop(shrinkOffset),
                    left: titlePaddingleft(shrinkOffset)),
                child: Text(
                  "Мои дела",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      height: AppHeights.largeTitle,
                      color: AppColorsLightTheme.primary,
                      fontSize: titleFontSize(shrinkOffset)),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: 25.0, top: titlePaddingtop(shrinkOffset)),
                  child: InkWell(
                    onTap: () {
                      provider.changedshow();
                      if (!provider.showedAllTasks) {
                        provider.getUncompletedTasks();
                      }
                    },
                    child: Image.asset(
                      provider.showedAllTasks
                          ? 'assets/icons/visibility_off.png'
                          : 'assets/icons/visibility.png',
                      color: AppColorsLightTheme.blue,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 60, top: titlePaddingtop(shrinkOffset)),
                child: Text(
                  'Выполнено - ${provider.listComletedTasks.length}',
                  style: TextStyle(
                      fontSize: AppTextSizes.body,
                      height: AppHeights.body,
                      color: shrinkOffset > 10
                          ? Colors.transparent
                          : AppColorsLightTheme.tertiary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double titleFontSize(double shrinkOffset) {
    double maxFontSize = 32;
    double minFontSize = 20;
    double shrinkRange = maxFontSize - minFontSize;

    double reducedFontSize =
        maxFontSize - (shrinkOffset / maxExtent) * shrinkRange;

    double finalFontSize = reducedFontSize.clamp(minFontSize, maxFontSize);

    return finalFontSize;
  }

  double iconPaddingtop(double shrinkOffset) {
    double maxPadding = 84;
    double minPadding = 48;
    double shrinkRange = maxPadding - minPadding;

    double reducedPadding =
        maxPadding - (shrinkOffset * 4 / maxExtent) * shrinkRange;

    double finalPadding = reducedPadding.clamp(minPadding, maxPadding);

    return finalPadding;
  }

  double titlePaddingtop(double shrinkOffset) {
    double maxPadding = 125;
    double minPadding = 58;
    double shrinkRange = maxPadding - minPadding;

    double reducedPadding =
        maxPadding - (shrinkOffset * 4 / maxExtent) * shrinkRange;

    double finalPadding = reducedPadding.clamp(minPadding, maxPadding);

    return finalPadding;
  }

  double titlePaddingleft(double shrinkOffset) {
    double maxPadding = 60;
    double minPadding = 16;
    double shrinkRange = maxPadding - minPadding;

    double reducedPadding =
        maxPadding - (shrinkOffset * 2 / maxExtent) * shrinkRange;

    double finalPadding = reducedPadding.clamp(minPadding, maxPadding);

    return finalPadding;
  }

  @override
  double get maxExtent => openHeight;

  @override
  double get minExtent => closedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
