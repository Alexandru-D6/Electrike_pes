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
    return Scaffold(
      appBar: buildAppBar(context, notificationsInfo.title, notificationsInfo.latitud, notificationsInfo.longitud),
      body: notificationsInfo.notifications.isEmpty
          ? const Text("There's no notifications yet. Add one...")
          : AnimatedList(
        key: _key,
        initialItemCount: notificationsInfo.notifications.length,
        itemBuilder: (context, index, animation) {
          print(index);
          return _buildItem(notificationsInfo.notifications[index], animation, index);
        },
      ),
    );
  }

  Widget _buildItem(List<String> notifications, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        elevation: 2,
        child: ListTile(
          leading: AutoSizeText("Notification "+index.toString()),
          title: Text(notifications[0]),
          subtitle: Text(buildDays(notifications).toString()),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () async{
              _removeItem(index,notifications);
              await Future.delayed(const Duration(milliseconds: 350), () {});
              setState(() {
                notifications.removeAt(index);
              });
            },
          ),
        ),
      ),
    );
  }

  void _removeItem(int index, List<String> removeItem) {
    builder(context, animation) {
      return _buildItem(removeItem, animation, index);
    }
    _key.currentState?.removeItem(index, builder);
  }

  buildDays(List<String> notification) {
    List<String> days = <String>[];
    for(int i = 1; i<notification.length; ++i){
      switch(notification[i]){
        case "1":
          days.add("Mon");
          break;
        case "2":
          days.add("Tues");
          break;
        case "3":
          days.add("Wedn");
          break;
        case "4":
          days.add("Thurs");
          break;
        case "5":
          days.add("Fri");
          break;
        case "6":
          days.add("Sat");
          break;
        case "7":
          days.add("Sun");
          break;
        default:
          break;
      }
    }
    return days;
  }
}
