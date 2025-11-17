import 'package:flora121_base/flora121_hep/flora121_sql/flora121_sql_name.dart';
import 'package:sqflite/sqflite.dart';

class Flora121BaseSqlUtils{
  static final Flora121BaseSqlUtils _utils = Flora121BaseSqlUtils();
  static Flora121BaseSqlUtils get instance => _utils;

  Future<Database> initSql() async => await openDatabase(
      "flora121.db",
      version: 4,
      onCreate: (db,version)async{
        db.execute('CREATE TABLE ${Flora121SqlName.aUserInfo} (id INTEGER PRIMARY KEY AUTOINCREMENT, headIcon TEXT, userId TEXT, healthNum INTEGER)');
        db.execute('CREATE TABLE ${Flora121SqlName.aTask} (id INTEGER PRIMARY KEY AUTOINCREMENT, taskText TEXT, timeStr TEXT, currentPro INTEGER, totalPro INTEGER, healthReward INTEGER,taskType TEXT)');
        db.execute('CREATE TABLE ${Flora121SqlName.aEnergy} (id INTEGER PRIMARY KEY AUTOINCREMENT, energyType TEXT, currentTime INTEGER, totalTime INTEGER,addNum INTEGER,taskType TEXT)');
        db.execute('CREATE TABLE ${Flora121SqlName.aSign} (id INTEGER PRIMARY KEY AUTOINCREMENT, signType TEXT, addNum INTEGER, signedTimer TEXT, day INTEGER)');
        _createVersion2DB(db);
        _createVersion3DB(db);
        _createVersion4DB(db);
      },
      onUpgrade: (db,oldVersion,newVersion){
        if(newVersion==2){
          _createVersion2DB(db);
        }else if(newVersion==3){
          _createVersion3DB(db);
        }else if(newVersion==4){
          _createVersion4DB(db);
        }
      }
  );

  _createVersion2DB(Database db){
    db.execute('CREATE TABLE ${Flora121SqlName.bCashTask} (id INTEGER PRIMARY KEY AUTOINCREMENT, cashMoney INTEGER, cashType TEXT, cashTaskIndex TEXT,currentProgress TEXT,totalProgress TEXT,cashAccount TEXT)');
    db.execute('CREATE TABLE ${Flora121SqlName.bSign} (id INTEGER PRIMARY KEY AUTOINCREMENT, addNum INTEGER, signedTimer TEXT, day INTEGER)');
    db.execute('CREATE TABLE ${Flora121SqlName.bQuizRecord} (id INTEGER PRIMARY KEY AUTOINCREMENT, timer TEXT, list TEXT)');
  }

  _createVersion3DB(Database db){
    db.execute('CREATE TABLE ${Flora121SqlName.bCashAccount} (id INTEGER PRIMARY KEY AUTOINCREMENT, cashType TEXT, cashAccount TEXT)');
  }

  _createVersion4DB(Database db){
    db.execute('CREATE TABLE ${Flora121SqlName.bGoldInfo} (id INTEGER PRIMARY KEY AUTOINCREMENT, goldType TEXT, cashMoney INTEGER, cashType TEXT, currentProgress REAL, totalProgress INTEGER)');
    db.execute('CREATE TABLE ${Flora121SqlName.bCashRankInfo} (id INTEGER PRIMARY KEY AUTOINCREMENT, cashMoney INTEGER, cashType TEXT, currentProgress INTEGER, totalProgress INTEGER)');
  }
}