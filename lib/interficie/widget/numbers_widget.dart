import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_grid/responsive_grid.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => ResponsiveGridRow(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ResponsiveGridCol(
        xs: 4,
        child: buildButton(context, ctrlPresentation.getCarsList().length.toString(), AppLocalizations.of(context).vehicles, "garage"),
      ),

      ResponsiveGridCol(
        xs: 4,
        child: buildButton(context, ctrlPresentation.numThrophyUnlocked().toString(), AppLocalizations.of(context).trophies, "trophies"),
      ),

      ResponsiveGridCol(
        xs: 4,
        child: buildButton(context, ctrlPresentation.getNumRoutessaved().ceil().toString(), AppLocalizations.of(context).routestaken, "num routes calculated"),
      ),

      ResponsiveGridCol(
        xs: 4,
        child: buildButton(context, ctrlPresentation.getCO2saved().toStringAsFixed(2)+" kg", AppLocalizations.of(context).savedco2, "co2"),
      ),

      ResponsiveGridCol(
        xs: 4,
        child: buildButton(context, ctrlPresentation.getKmsaved().toStringAsFixed(2)+" km", AppLocalizations.of(context).kilometerstraveled, "kilometers done"),
      ),

    ],
  );
  Widget buildDivider() => const SizedBox(
    height: 24,
    child: VerticalDivider(),
  );

  Widget buildButton(BuildContext context, String value, String text, String toPage) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            switch (toPage){
              case "garage":
                ctrlPresentation.toGaragePage(context);
                break;
              case "trophies":
                ctrlPresentation.toRewardsPage(context);
                break;
              case "co2":
                break;
              default:
                break;
            }
          },
          //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildDivider(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(
                      value,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 2),
                    AutoSizeText(
                      text,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              buildDivider(),
            ],
          ),
        ),
      );
}