import 'package:budget_app/app_const.dart';
import 'package:budget_app/models/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class DatabaseRepository {
  Database? _database;

  static final DatabaseRepository instance = DatabaseRepository._init();
  DatabaseRepository._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('budget.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    //databaseFactory.deleteDatabase(path);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  _createDB(Database db, int version) async {
    await db.execute('''
    create table categories (
      id integer primary key autoincrement,
      title text not null,
      date text not null,
      iconId integer not null,
      iconFontFamily text not null,
      lastState integer not null
    );
    ''');
    await db.execute('''
    create table wallets (
      id integer primary key autoincrement,
      title text not null,
      date text not null,
      iconId integer not null,
      iconFontFamily text not null,
      lastState integer not null
    );
    ''');
    await db.execute('''
    create table entries (
      id integer primary key autoincrement,
      name text not null,
      amount integer not null,
      swId integer,
      swShare real,
      walletId integer not null,
      categoryId integer not null,
      date text not null
    );
    ''');
  }

  Future<void> insert({required Model o}) async {
    var now = DateTime.now();
    var formatter = DateFormat('yyy-MM-dd');
    String formattedDate = formatter.format(now);

    Map<String, dynamic> map = o.toMap();
    map.update('date', (value) => formattedDate, ifAbsent: () => formattedDate);

    try {
      final db = await database;
      db.insert(AppConst.table_name_dict[o.runtimeType]!, map);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> delete({required Model o}) async {
    final db = await database;
    db.delete(AppConst.table_name_dict[o.runtimeType]!,
        where: 'id = ?', whereArgs: [o.id]);
  }

  Future<List<Model>> getAllOfType<T extends Model>() async {
    final db = await instance.database;
    final result = await db.query(AppConst.table_name_dict[T]!);
    if (T == CategoryModelGen) {
      return result.map((json) => CategoryModelGen.fromJson(json)).toList();
    }
    if (T == WalletModelGen) {
      return result.map((json) => WalletModelGen.fromJson(json)).toList();
    }
    throw Exception();
  }

  Future<void> update({required Model o}) async {
    final db = await instance.database;
    await db.update(
      AppConst.table_name_dict[o.runtimeType]!,
      o.toMap(),
      where: "id = ?",
      whereArgs: [o.id],
    );
  }
}
