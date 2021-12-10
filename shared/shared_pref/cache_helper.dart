import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CacheHelper
{
 static SharedPreferences sharedPreferences ;

  static  init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

 static Future<bool> setData({
 @required String key,
 @required bool isDark,
})async
  {
    return await sharedPreferences.setBool(key, isDark);
  }

  static dynamic getData({@required key})
  {
    return  sharedPreferences.get(key);
  }

 static Future<bool> saveData
  ({
    @required String key,
    @required dynamic value,
  })async
  {
    if(value is String ) return await sharedPreferences.setString(key, value);
    if(value is int ) return await sharedPreferences.setInt(key, value);
    if(value is bool ) return await sharedPreferences.setBool(key, value);

    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> removeData(key) async
  {
   return await sharedPreferences.remove(key);
  }

  static Future setList(key,List<String>value) async => await sharedPreferences.setStringList(key, value);
  static List<String> getList(key) => sharedPreferences.getStringList(key);
}