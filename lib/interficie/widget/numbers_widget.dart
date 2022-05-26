import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/page/profile_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_grid/responsive_grid.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8.0, // gap between adjacent chips
    runSpacing: 12.0, // gap between lines
    alignment: WrapAlignment.center,
    children: <Widget>[
      buildButton(context, ctrlPresentation.getCarsList().length.toString(), AppLocalizations.of(context).vehicles, "garage"),
      buildButton(context, ctrlPresentation.numThrophyUnlocked().toString(), AppLocalizations.of(context).trophies, "trophies"),
      buildButton(context, ctrlPresentation.getNumRoutessaved().ceil().toString(), AppLocalizations.of(context).routestaken, "num routes calculated"),
      buildButton(context, ctrlPresentation.getCO2saved().toStringAsFixed(2)+" kg", AppLocalizations.of(context).savedco2, "co2"),
      buildButton(context, ctrlPresentation.getKmsaved().toStringAsFixed(2)+" km", AppLocalizations.of(context).kilometerstraveled, "kilometers done"),
    ],
  );

  Widget buildDivider() => const SizedBox(
    height: 24,
    child: VerticalDivider(),
  );

  Widget buildButton(BuildContext context, String value, String text, String toPage) =>
     GestureDetector(
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildDivider(),
              Column(
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
              buildDivider(),
            ],
          ),
      );
}