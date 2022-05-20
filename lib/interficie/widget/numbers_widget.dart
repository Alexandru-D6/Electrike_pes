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
        child: buildButton(context, ctrlPresentation.getCO2saved().toString()+" kg", AppLocalizations.of(context).savedco2, "co2"),
      ),

      ResponsiveGridCol(
        xs: 4,
        child: buildButton(context, ctrlPresentation.getCO2saved().toString()+" kg", AppLocalizations.of(context).savedco2, "co2"),
      ),

      //ToDo:Añadir traducciones Peilin
      ResponsiveGridCol(
        xs: 4,
        child: buildButton(context, ctrlPresentation.getKmsaved().toString()+" km", AppLocalizations.of(context).savedco2, "kilometers done"),
      ),

      //ToDo:Añadir traducciones Peilin
      ResponsiveGridCol(
        xs: 4,
        child: buildButton(context, ctrlPresentation.getNumRoutessaved().toString(), AppLocalizations.of(context).savedco2, "num routes calculated"),
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
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 4),
          onPressed: () {
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
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildDivider(),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    value,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    text,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              buildDivider(),
            ],
          ),
        ),
      );
}