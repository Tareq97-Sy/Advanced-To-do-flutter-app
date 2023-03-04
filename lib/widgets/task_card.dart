import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../data-base/my_data_base.dart';

class TaskCard extends StatelessWidget {
  TaskCard({
    super.key,
    required this.taskColor,
    required this.t,
  });
  final Task t;
  final Color taskColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Get.toNamed('/details-task', arguments: t),
      // leading: Checkbox(
      //   checkColor: Colors.white,
      //   // ignore: unrelated_type_equality_checks
      //   value: fc.filterTasks![index].isDone,
      //   shape: CircleBorder(),
      //   onChanged: (bool? value) {
      //     tc.maketaskIsDone(
      //       fc.filterTasks![index],
      //       value!,
      //     );

      //   },
      // ),
      title: Text(
        t.title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontStyle: FontStyle.italic),
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          t.content != null
              ? (t.content!.isNotEmpty)
                  ? Text(t.content!.substring(0, 11))
                  : Text("there is no description")
              : Text(""),
          Text(DateFormat("yyyy/MM/dd").format(t.date)),
        ],
      ),
      textColor: taskColor,
      iconColor: taskColor,
      tileColor: Color.fromARGB(215, 238, 242, 247).withOpacity(0.5),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 2, color: taskColor),
        borderRadius: BorderRadius.all(Radius.circular(44)),
      ),
      contentPadding: EdgeInsets.all(15),
      //leading: Icon(icon: Icon(Icons.list)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // IconButton(
          // onPressed: () {
          //   Get.toNamed('/edit-task', arguments: t);
          // },
          // icon: Icon(Icons.edit)),
          // IconButton(
          //   onPressed: () {
          //     fc.deleteTask(tc.allTasks![index].id);
          //   },
          //   icon: Icon(Icons.delete),
          // ),
        ],
      ),
    );
  }
}
