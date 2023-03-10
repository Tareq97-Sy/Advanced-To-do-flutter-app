import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/routes_controller.dart';
import '../data-base/my_data_base.dart';

class TaskCard extends StatelessWidget {
  TaskCard({
    super.key,
    required this.taskColor,
    required this.t,
    required this.routesController,
    required this.makeTaskDone,
    required this.delete,
  });
  final RoutesController routesController;
  final Task t;
  final Function(int) taskColor;
  final Function(Task, bool) makeTaskDone;
  final Function(int) delete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => routesController.viewDetailsTaskScreen(t),
      leading: buildCheckBox(),
      title: buildTitle(),
      subtitle: buildDescription(),
      trailing: buildTrailing(),
      textColor: taskColor(t.priority),
      iconColor: taskColor(t.priority),
      tileColor: Color.fromARGB(215, 238, 242, 247).withOpacity(0.5),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 2, color: taskColor(t.priority)),
        borderRadius: BorderRadius.all(Radius.circular(44)),
      ),
      contentPadding: EdgeInsets.all(15),
      //leading: Icon(icon: Icon(Icons.list)),
    );
  }

  Checkbox buildCheckBox() {
    return Checkbox(
      checkColor: Colors.white,
      value: t.isDone,
      shape: CircleBorder(),
      onChanged: (bool? value) {
        makeTaskDone(t, value!);
      },
    );
  }

  Text buildTitle() {
    return Text(
      t.title,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontStyle: FontStyle.italic),
    );
  }

  Column buildDescription() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        t.content != null ? Text("...") : Text(""),
        Text(DateFormat("yyyy/MM/dd").format(t.date)),
      ],
    );
  }

  Row buildTrailing() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: () => routesController.viewEditScreen(t),
            icon: Icon(Icons.edit)),
        IconButton(
          onPressed: () {
            delete(t.id);
          },
          icon: Icon(Icons.delete),
        ),
      ],
    );
  }
}
