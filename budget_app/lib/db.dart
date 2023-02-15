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

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    create table categories (
      id integer primary key autoincrement,
      title text not null,
      date text not null
    );
    ''');
    await db.execute('''
    create table wallets (
      id integer primary key autoincrement,
      title text not null,
      date text not null
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

    Map<String, dynamic> map = (o).toMap();
    map.update('date', (value) => formattedDate, ifAbsent: () => formattedDate);

    try {
      final db = await database;
      switch (o.runtimeType) {
        case EntryModelGen:
          db.insert('entries', map);
          break;
        case WalletModelGen:
          db.insert('wallets', map);
          break;
        case CategoryModelGen:
          db.insert('categories', map);
          break;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  /*
  Future<List<CategoryModelGen>> getAllCategories() async {
    final db = await instance.database;
    final result = await db.query('categories');
    return result.map((json) => CategoryModelGen.fromJson(json)).toList();
  }

  Future<List<WalletModelGen>> getAllWallets() async {
    final db = await instance.database;
    final result = await db.query('wallets');
    return result.map((json) => WalletModelGen.fromJson(json)).toList();
  }*/

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
}
