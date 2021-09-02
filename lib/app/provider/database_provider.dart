import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static final _instance = DatabaseProvider._internal();
  static DatabaseProvider get = _instance;
  DatabaseProvider._internal();
  bool _isInitialized = false;
  late Database _db;

  Future<Database> db() async {
    if (!_isInitialized) await _init();
    return _db;
  }

  Future _init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'tasks.db');

    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE tasks("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "description TEXT,"
          "done INTEGER DEFAULT 0 );");
    });
    _isInitialized = true;
  }
}
