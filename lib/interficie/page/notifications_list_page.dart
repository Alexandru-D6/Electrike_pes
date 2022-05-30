import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/interficie/constants.dart';
import 'package:flutter_project/interficie/ctrl_presentation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_project/interficie/widget/edit_car_arguments.dart';

class NotificationsListPage extends StatefulWidget {
  @override
  _NotificationsListPageState createState() => _NotificationsListPageState();
}

class NotificationsArgs {
  final double latitud;
  final double longitud;
  final String title;

  NotificationsArgs(this.latitud, this.longitud, this.title);
}

class _NotificationsListPageState extends State<NotificationsListPage> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  CtrlPresentation ctrlPresentation = CtrlPresentation();

  AppBar buildAppBar(BuildContext context, String title, double latitud, double longitud) {
    return AppBar(
      backgroundColor: mPrimaryColor,
      elevation: 0,
      title: AutoSizeText("Notifications point " + title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,), // traduccion peilin
      actions: [
        IconButton(
          tooltip: AppLocalizations.of(context).addNoti,
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
    final NotificationsArgs notificationsInfo = ModalRoute.of(context)!.settings.arguments as NotificationsArgs;

    List<List<String>> notifications = ctrlPresentation.getNotifications(notificationsInfo.latitud, notificationsInfo.longitud);
    return Scaffold(
      appBar: buildAppBar(context, notificationsInfo.title, notificationsInfo.latitud, notificationsInfo.longitud),
      body: notifications.isEmpty
          ? Center(
            child: AutoSizeText(AppLocalizations.of(context).anynoti,
        style: const TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
          )
          : AnimatedList(
        key: _key,
        initialItemCount: notifications.length,
        itemBuilder: (context, index, animation) {
          return _buildItem(notifications[index], animation, index, notificationsInfo.latitud, notificationsInfo.longitud);
        },
      ),
    );
  }

  Widget _buildItem(List<String> notification, Animation<double> animation, int index, double latitud, double longitud) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        elevation: 2,
        child: ListTile(
          leading: AutoSizeText(AppLocalizations.of(context).notification+index.toString()),
          title: Text(notification[0]),
          subtitle: Text(buildDays(notification).toString()),
          trailing: IconButton(
            tooltip: AppLocalizations.of(context).eliminaNoti,
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () async{
              showDialog(
                // The user CANNOT close this dialog  by pressing outsite it
                  barrierDismissible: false,
                  context: context,
                  builder: (_) {
                    return Dialog(
                      // The background color
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            // The loading indicator
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 15,
                            ),
                            // Some text
                            Text('Loading...')
                          ],
                        ),
                      ),
                    );
                  });

              await ctrlPresentation.removeNotification(latitud, longitud, int.parse(notification[0].split(":")[0]), int.parse(notification[0].split(":")[1]), notification.sublist(1).map(int.parse).toList());

              Navigator.of(context, rootNavigator: true).pop();

              setState(() {
                _removeItem(index,notification, latitud, longitud);
                notification.removeAt(index);
              });
            },
          ),
        ),
      ),
    );
  }
  void _removeItem(int index, List<String> removeItem, double latitud, double longitud) {
    builder(context, animation) {
      return _buildItem(removeItem, animation, index, latitud, longitud);
    }
    _key.currentState?.removeItem(index, builder);
  }

  buildDays(List<String> notification) {
    List<String> days = <String>[];
    for(int i = 1; i<notification.length; ++i){
      switch(notification[i]){
        case "1":
          days.add(AppLocalizations.of(context).shortday1);
          break;
        case "2":
          days.add(AppLocalizations.of(context).shortday2);
          break;
        case "3":
          days.add(AppLocalizations.of(context).shortday3);
          break;
        case "4":
          days.add(AppLocalizations.of(context).shortday4);
          break;
        case "5":
          days.add(AppLocalizations.of(context).shortday5);
          break;
        case "6":
          days.add(AppLocalizations.of(context).shortday6);
          break;
        case "7":
          days.add(AppLocalizations.of(context).shortday7);
          break;
        default:
          break;
      }
    }
    return days;
  }

}