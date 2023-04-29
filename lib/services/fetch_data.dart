import 'dart:convert';

import 'package:covid19/utilities/Apis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:covid19/Modals/ApisModal.dart';

class Fetching_data_Api{
  Future<ApisModal> GetAllData()async{
    final responce = await http.get(Uri.parse(AllApis.worldStatesApi));
    if(responce.statusCode == 200){
      var data = jsonDecode(responce.body.toString());
      return ApisModal.fromJson(data);
    }else{
      throw Exception('Api failed to load data');
    }
  }


  Future<List<dynamic>> GetAllCountries()async {
    var countrydata;
    final responce = await http.get(Uri.parse(AllApis.AllCountriesApi));
    if(responce.statusCode == 200){
      countrydata = jsonDecode(responce.body.toString());
      return countrydata;
    }else{
      throw Exception('Countries not loaded');
    }
  }
}
