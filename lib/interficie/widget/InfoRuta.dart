import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class InfoRuta extends StatelessWidget {
  const InfoRuta({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
          color: mPrimaryColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
//todo:
            ],
          ),
          const Divider(
            height: 16,
            color: Colors.black54,
          ),

        ],
      ),
    );
  }
}