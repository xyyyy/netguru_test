import 'dart:async';
import 'dart:math';

import 'package:netguru_test/data/value.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ValuesData{


   int _currentValue;
   SharedPreferences _prefs;
   


   List<String> _values = ["Exceed clients' and colleagues' expectations", "Take ownership and question the status quo in a constructive manner",
    "Be brave, curious and experiment. Learn from all successes and failures", "Act in a way that makes all of us proud",
    "Build an inclusive, transparent and socially responsible culture", "Be ambitious, grow yourself and the people around you",
    "Recognize excellence and engagement"];

   ValuesData(){
    _initState();
   }

   void _initState() async{
      _prefs = await SharedPreferences.getInstance();
   }


   Future<Value> getNextValue() async{
     int amountOfValues;
     List<String> customValues;
     List<String> favorites;
     if(_prefs == null){
       _prefs = await SharedPreferences.getInstance();
     }

     if(_prefs != null){
       amountOfValues = _prefs.getInt("amount_of_values");
       customValues = _prefs.getStringList("custom_values");
       favorites = _prefs.getStringList("favorites");
     }
     if(amountOfValues == null || customValues == null || customValues.length != amountOfValues - 7){
       amountOfValues = 7;
     }

     if(_currentValue == null){
       _currentValue = Random().nextInt(6); //include new values as well
     }else{
       _currentValue++;
       _currentValue %= amountOfValues;
     }

     bool favorite = false;

     if(favorites != null && favorites.contains(_currentValue.toString())){
       favorite = true;
     }


     if(_currentValue < 7){
       return Value(_values[_currentValue], favorite);
     }
          
     return Value(customValues[_currentValue - 7], favorite);
     
   }

   Future<bool> addValue(String value) async{
     if(_prefs == null){
       _prefs = await SharedPreferences.getInstance();
     }
     if(_prefs != null){
       int amountOfValues = _prefs.getInt("amount_of_values");
       List<String> customValues = _prefs.getStringList("custom_values");
       if(amountOfValues == null || amountOfValues < 7){
         amountOfValues = 7;
       }

       if(customValues == null){
         customValues = List<String>();
       }
       amountOfValues++;
       customValues.add(value);
       bool res =  await _prefs.setInt("amount_of_values", amountOfValues);
       if(res) {
         return _prefs.setStringList("custom_values", customValues);
       }
     }
     return false;

   }

   Future<Value> changeFavoriteStatus() async{
     if(_prefs == null){
       _prefs = await SharedPreferences.getInstance();
     }
     bool res = true;
     List<String> favorites =  _prefs.getStringList("favorites");
     if(favorites != null && favorites.contains(this._currentValue.toString())){
       favorites.remove(this._currentValue.toString());
       res = false;

     }else{
       if(favorites == null){
         favorites = List<String>();
       }
       favorites.add(this._currentValue.toString());
     }
      await _prefs.setStringList("favorites", favorites);
     if(_currentValue < 7){
       return Value(_values[_currentValue], res);
     }
     List<String> customValues;
     if(_prefs != null){
       customValues = _prefs.get("custom_values");
     }
     if(customValues != null){
      return Value(customValues[_currentValue - 7], res);
     }
     return Value("", res);



   }



   Stream<Future<Value>> valueStream({int duration}) {
     return Stream.periodic(Duration(seconds: duration), (x) => getNextValue());
   }

   Future<List<String>> _getAllValues() async{
     if(_prefs == null){
       _prefs = await SharedPreferences.getInstance();
     }
     if(_prefs != null) {
       List<String> allValues = List<String>();
       if(this._values != null) {
         allValues.addAll(this._values);
       }
       List<String> customValues = await _prefs.getStringList("custom_values");
       if(customValues != null) {
         allValues.addAll(customValues);
       }
       return allValues;
     }
     return List<String>();
   }


   Future<List<String>> getFavoriteValues() async{
     List<String> allValues = await _getAllValues();
     List<String> res = List<String>();
     if(_prefs == null){
       _prefs = await SharedPreferences.getInstance();
     }
     if(_prefs != null){
       List<String> favorites =  _prefs.getStringList("favorites");
       if(favorites != null){
         for(String favorite in favorites){
           int tmp;
           try{
             tmp = int.parse(favorite);
           }catch(e){
             continue;
           }

           if(allValues.length > tmp){
             res.add(allValues[tmp]);
           }
         }
         return res;
       }

     }

     return List<String>();
   }




}