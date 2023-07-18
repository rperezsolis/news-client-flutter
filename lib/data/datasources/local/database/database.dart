import 'dart:io';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'package:drift/drift.dart';

part 'database.g.dart';

class SavedArticles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get content => text()();
  TextColumn get url => text()();
  TextColumn get urlToImage => text().nullable()();
  TextColumn get author => text().nullable()();
  TextColumn get source => text().nullable()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: [SavedArticles])
class Database extends _$Database {

  Database._create() : super(_openConnection());

  static final Database instance = Database._create();

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // we added the dueDate property in the change from version 1 to
          // version 2
          await m.addColumn(savedArticles, savedArticles.urlToImage);
        }
      },
    );
  }
}
