import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "PressureItem.db"; // DB名
  static const _databaseVersion = 1; // スキーマのバージョン指定
  static const table = 'pressure_item_table'; // テーブル名
  static const columnId = '_id'; // カラム名：ID
  static const columnDateTime = 'datetime'; // カラム名:Name
  static const columnUuid = 'uuid';
  static const columnMaxPressure = 'maxPressure';
  static const columnMinPressure = 'minPressure';
  static const columnPulse = 'pulse';
  static const columnTimeOfDate = 'timeOfDate';

  // DatabaseHelper クラスを定義
  DatabaseHelper._privateConstructor();

  // DatabaseHelper._privateConstructor() コンストラクタを使用して生成されたインスタンスを返すように定義
  // DatabaseHelper クラスのインスタンスは、常に同じものであるという保証
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // データベース接続
  _initDatabase() async {
    // アプリケーションのドキュメントディレクトリのパスを取得
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // 取得パスを基に、データベースのパスを生成
    String path = join(documentsDirectory.path, _databaseName);
    // データベース接続
    return await openDatabase(path,
        version: _databaseVersion,
        // テーブル作成メソッドの呼び出し
        onCreate: _onCreate);
  }

  // テーブル作成
  // 引数:dbの名前
  // 引数:スキーマーのversion
  // スキーマーのバージョンはテーブル変更時にバージョンを上げる（テーブル・カラム追加・変更・削除など）
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnDateTime TEXT NOT NULL,
            $columnUuid TEXT NOT NULL,
            $columnMaxPressure INTEGER NOT NULL,
            $columnMaxPressure INTEGER NOT NULL,
            $columnPulse INTEGER NOT NULL,
            $columnTimeOfDate TEXT NOT NULL,
          )
          ''');
  }
}
