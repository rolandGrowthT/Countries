import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Postmodel.dart';
import 'states.dart';

class TestPage extends StatefulWidget {
  TestPage({super.key});
  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  List<PostModel> countriesList = [];
  String selectedCountry = '';
  String selectedState = '';
  String getid = '';
  List<states> statesList = [];
  
  @override
  void initState() {
    super.initState();
    getAllCountries();
  }

  Future<void> getAllCountries() async {
    var response = await http.get(Uri.parse(
        "http://192.168.88.10:30513/otonomus/common/api/v1/countries?page=0&size=300"));
    var decodedResponse = jsonDecode(response.body);

    var result = decodedResponse['data'] as List;
    final finalResponse = result.map((map) => PostModel.fromJson(map)).toList();
    setState(() {
      countriesList = finalResponse;
    });
  }

  Future<void> getStatesById(String Cid) async {
    try {
      var response = await http.get(Uri.parse(
          "http://192.168.88.10:30513/otonomus/common/api/v1/country/$Cid/states"));
      var decodedResponse = jsonDecode(response.body);
      var result = decodedResponse['data'] as List;

      final finalResponse = result.map((map) => states.fromJson(map)).toList();
      setState(() {
        statesList = finalResponse;
      });
    } catch (e) {
      print('Error, this country has no state!');
    }
  }

  String getIdByName(List<PostModel> Countrylist, String name) {
    for (var c in Countrylist) {
      if (c.countryName == name) {
        return c.idCountry;
      }
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Please select your country',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedCountry == "" ? null : selectedCountry,
              onChanged: (String? newValue) {
                setState(() {
                  selectedState ='';
                  List<states> statesList = [];
                  selectedCountry = newValue!;
                  getid = getIdByName(countriesList, selectedCountry);
                  getStatesById(getid);
                });
              },
              items: countriesList
                  .map<DropdownMenuItem<String>>((PostModel country) {
                return DropdownMenuItem<String>(
                  value: country.countryName,
                  child: Text(country.countryName),
                );
              }).toList(),
            ),
            Text(
              'Please select your State',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedState == "" ? null : selectedState,
              onChanged: (String? newValue2) {
                setState(() {
                  selectedState = newValue2!;
                });
              },
              items: statesList.map<DropdownMenuItem<String>>((states state) {
                return DropdownMenuItem<String>(
                  value: state.stateName,
                  child: Text(state.stateName),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
