
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_task/controllers/filter_controller.dart';

import '../controllers/routes_controller.dart';
import '../controllers/task_controller.dart';

class ListTasks extends StatelessWidget {
  ListTasks({super.key, required this.fc, required this.tc, required this.rc});
  final FilterController fc;
  final TaskController tc;
  final RoutesController rc;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: fc.filterTasks!.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () => rc.viewDetailsTaskScreen(fc.filterTasks![index]),
            leading: Checkbox(
              checkColor: Colors.white,
              // ignore: unrelated_type_equality_checks
              value: fc.filterTasks![index].isDone,
              shape: CircleBorder(),
              onChanged: (bool? value) {
                tc.maketaskIsDone(
                  fc.filterTasks![index],
                  value!,
                );
              },
            ),
            title: Text(
              fc.filterTasks![index].title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontStyle: FontStyle.italic),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                fc.filterTasks![index].content != null
                    ? (fc.filterTasks![index].content!.isNotEmpty)
                        ? Text(fc.filterTasks![index].content!.substring(0, 11))
                        : Text("there is no description")
                    : Text(""),
                Text(DateFormat("yyyy/MM/dd")
                    .format(fc.filterTasks![index].date)),
              ],
            ),
            textColor: tc.colorTaskByPriority(fc.filterTasks![index].priority),
            iconColor: tc.colorTaskByPriority(fc.filterTasks![index].priority),
            tileColor: Color.fromARGB(215, 238, 242, 247).withOpacity(0.5),
            shape: RoundedRectangleBorder(
              //<-- SEE HERE
              side: BorderSide(
                  width: 2,
                  color:
                      tc.colorTaskByPriority(fc.filterTasks![index].priority)),
              borderRadius: BorderRadius.all(Radius.circular(44)),
            ),
            contentPadding: EdgeInsets.all(15),
            //leading: Icon(icon: Icon(Icons.list)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () => rc.viewEditScreen(fc.filterTasks![index]),
                    icon: Icon(Icons.edit)),
                IconButton(
                  onPressed: () => tc.deleteTask(fc.filterTasks![index].id),
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          );
        });
  }
}
