import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'my_data_base.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 6, max: 20)();

  TextColumn get content => text().nullable()();

  DateTimeColumn get date => dateTime().withDefault(Constant(DateTime.now()))();

  IntColumn get priority => integer().withDefault(Constant(3))();

  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Tasks])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'todo_app.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
