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

class _NotificationsListPageState extends State<NotificationsListPage> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  CtrlPresentation ctrlPresentation = CtrlPresentation();

  AppBar buildAppBar(BuildContext context, String title, double latitud, double longitud) {
    return AppBar(
      backgroundColor: mPrimaryColor,
      elevation: 0,
      title: AutoSizeText("Notifications point " + title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,), //todo: traduccion peilin
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
    List<List<String>> notifications = ctrlPresentation.getNotifications(notificationsInfo.latitud, notificationsInfo.longitud);
    return Scaffold(
      appBar: buildAppBar(context, notificationsInfo.title, notificationsInfo.latitud, notificationsInfo.longitud),
      body: notifications.isEmpty
          ? const Center(
            child: AutoSizeText("There's no notifications yet. Add one...",
        style: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
          ) //todo: translate AppLocalizations
          : AnimatedList(
        key: _key,
        initialItemCount: notifications.length,
        itemBuilder: (context, index, animation) {
          print(index);
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
          leading: AutoSizeText("Notification "+index.toString()),
          title: Text(notification[0]),
          subtitle: Text(buildDays(notification).toString()),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () async{
              _removeItem(index,notification, latitud, longitud);
              await Future.delayed(const Duration(milliseconds: 350), () {});
              ctrlPresentation.removeNotification(latitud, longitud, int.parse(notification[0].split(":")[0]), int.parse(notification[0].split(":")[1]), notification.sublist(1).map(int.parse).toList());
              setState(() {
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
          days.add("Mon"); //todo: translate AppLocalizations
          break;
        case "2":
          days.add("Tues"); //todo: translate AppLocalizations
          break;
        case "3":
          days.add("Wedn"); //todo: translate AppLocalizations
          break;
        case "4":
          days.add("Thurs"); //todo: translate AppLocalizations
          break;
        case "5":
          days.add("Fri"); //todo: translate AppLocalizations
          break;
        case "6":
          days.add("Sat"); //todo: translate AppLocalizations
          break;
        case "7":
          days.add("Sun"); //todo: translate AppLocalizations
          break;
        default:
          break;
      }
    }
    return days;
  }

}