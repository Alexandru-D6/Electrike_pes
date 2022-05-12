import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_project/interficie/widget/edit_car_arguments.dart';

class NotificationsListPage extends StatefulWidget {

  const NotificationsListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationsListPage> createState() => _NotificationsListPageState();
}

class _NotificationsListPageState extends State<NotificationsListPage> {
  CtrlPresentation ctrlPresentation = CtrlPresentation();

  AppBar buildAppBar(BuildContext context, String title, double latitud, double longitud) {
    return AppBar(
      backgroundColor: mPrimaryColor,
      elevation: 0,
      title: AutoSizeText("Notifications point " + title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,), //todo: AppLocalizations.of(context).garage LA PRIMERA PARTE
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notification_add,
            color: Colors.white,
          ),
          onPressed: (){
            ctrlPresentation.toTimePicker(context, latitud, longitud, title);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final notificationsInfo = ModalRoute.of(context)!.settings.arguments as NotificationsArgs;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: notificationsInfo.title,
      home: Scaffold(
        appBar: buildAppBar(context, notificationsInfo.title, notificationsInfo.latitud, notificationsInfo.longitud),
        body: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: notificationsInfo.notifications.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = notificationsInfo.notifications[index];

            return ListTile(
              title: Text(
                "Notification " + index.toString(), //todo: translate
                style: Theme.of(context).textTheme.headline5,
              ),
              subtitle: const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
