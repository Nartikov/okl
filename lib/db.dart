import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "Linssesokl.db";
  static final _databaseVersion = 1;

  static final table_client = 'client';
  static final table_settings = 'settings';
  static final table_payments = 'payments';

  static final columnId = 'id';
  static final columnFamile = 'famile';
  static final columnName = 'name';
  static final columnPhone = 'phone';
  static final columnLl = 'll';
  static final columnRl = 'rl';

  static final columnSetId = 'id';
  static final columnSetTaxrate = 'tax_rate';
  static final columnSetIncomeExpense = 'income_expense';

  static final columnPayId = 'id';
  static final columnPayDate = 'date';
  static final columnPayPay = 'pay';
  static final columnPayIdClient = 'id_client';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table_client (
            $columnId INTEGER PRIMARY KEY,
            $columnFamile TEXT NOT NULL,
            $columnName TEXT NOT NULL,
            $columnPhone TEXT NOT NULL,
            $columnLl TEXT NOT NULL,
            $columnRl TEXT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $table_settings (
            $columnSetId INTEGER PRIMARY KEY,
            $columnSetTaxrate TEXT NOT NULL,
            $columnSetIncomeExpense INTEGER NOT NULL
          )
          ''');

   /* await db.execute('''
          CREATE TABLE $table_payments (
            $columnPayId INTEGER PRIMARY KEY,
            $columnPayDate TEXT NOT NULL,
            $columnPayPay INTEGER NOT NULL,
            FOREIGN KEY ($columnPayIdClient) REFERENCES $table_client($columnId)
          )
          ''');*/
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table_client, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table_client);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table_client'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db
        .update(table_client, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db
        .delete(table_client, where: '$columnId = ?', whereArgs: [id]);
  }
}
