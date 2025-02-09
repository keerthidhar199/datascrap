// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:tuple/tuple.dart';

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
///
class Batting_player {
  /// Creates the employee class with required details.
  Batting_player(
    this.player,
    this.runs,
    this.balls,
    this.fours,
    this.sixes,
    this.sr,
    this.team,
    this.opposition,
    this.ground,
    this.match_date,
    this.score_card,
    this.player_link,
  );

  final String player;
  final int runs;
  final int balls;
  final int fours;
  final int sixes;
  final double sr;
  final String opposition;
  final String ground;
  final String match_date;
  final String team;
  final String score_card;
  final String player_link;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class BattingDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  BattingDataSource({List<Batting_player>? batData}) {
    _batData = batData!
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'player', value: e.player),
              DataGridCell<int>(columnName: 'runs', value: e.runs),
              DataGridCell<int>(columnName: 'balls', value: e.balls),
              DataGridCell<int>(columnName: 'fours', value: e.fours),
              DataGridCell<int>(columnName: 'sixes', value: e.sixes),
              DataGridCell<double>(columnName: 'sr', value: e.sr),
              DataGridCell<String>(columnName: 'team', value: e.team),
              DataGridCell<String>(
                  columnName: 'opposition', value: e.opposition),
              DataGridCell<String>(columnName: 'ground', value: e.ground),
              DataGridCell<String>(
                  columnName: 'match date', value: e.match_date),
              DataGridCell<String>(
                  columnName: 'score card', value: e.score_card),
              DataGridCell<String>(
                  columnName: 'player link', value: e.player_link),
            ]))
        .toList();
  }

  List<DataGridRow> _batData = [];
  @override
  List<DataGridRow> get rows => _batData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          e.value.toString(),
          style: const TextStyle(
              color: Colors.black87, fontFamily: 'Cocosharp'),
        ),
      );
    }).toList());
  }
}

batting_teams_info(var team1Info, String team1Name) async {
  List<List<String>> allplayers = [];
  List<List<String>> allplayersscript = [];

  List<String> headings = [];
  dom.Document document1 = parser.parse(team1Info.body);

  var battingdata =
      json.decode(document1.getElementById('__NEXT_DATA__')!.text)['props']
          ['appPageProps']['data']['data']['content'];

  print(
      'battingdata ${json.decode(document1.getElementById('__NEXT_DATA__')!.text)['props']['appPageProps']['data']}');
  battingdata =
      json.decode(document1.getElementById('__NEXT_DATA__')!.text)['props']
          ['appPageProps']['data']['data']['content']['tables'];
  // print(document
  //     .querySelectorAll('table.engineTable>tbody')[1]
  //     .text
  //     .contains('Records'));
  List<String> headers = [];
  for (var i in battingdata[0]['headers']) {
    headers.add(i['label']);
  }
  headers.insert(headers.length, 'Player Link');

  for (var players in battingdata[0]['rows']) {
    List<String> playerbattingdata = [];

    for (var player in players['items']) {
      playerbattingdata.add(player['value'].toString());
    }
    playerbattingdata.insert(
        headers.indexOf('Player Link'), players['items'][0]['link'].toString());
    allplayersscript.add(playerbattingdata);
  }
  allplayersscript.sort((a, b) => int.parse(b[1].replaceAll('*', ''))
      .compareTo(int.parse(a[1].replaceAll('*', ''))));

  print('Neel bat $headers');
  print('Neel bat $allplayersscript');

  // var headers1 = document1.querySelectorAll('table>thead>tr')[0];
  // var titles1 = headers1.querySelectorAll('td');

  // titles1.removeWhere((element) => element.text.isEmpty);
  // for (int i = 0; i < titles1.length; i++) {
  //   print(titles1[i].text.toString().trim());
  //   if (titles1[i].text.toString().trim().contains('4')) {
  //     headings.add('fours');
  //   } else if (titles1[i].text.toString().trim().contains('6')) {
  //     headings.add('sixes');
  //   } else {
  //     headings.add(titles1[i].text.toString().trim());
  //   }
  // }
  // // headings.insert(headings.length, "Team");
  // headings.insert(headings.length, 'Player Link');
  // var element = document1.querySelectorAll('table>tbody')[0];
  // var data = element.querySelectorAll('tr');
  // data.removeWhere((element) => element.text.isEmpty);
  // for (int i = 0; i < data.length; i++) {
  //   List<String> playerwise = [];
  //   for (int j = 0; j < data[i].children.length; j++) {
  //     if (data[i].children[j].text.isNotEmpty) {
  //       playerwise.add(data[i].children[j].text.toString().trim());
  //     }
  //   }

  //   // playerwise.removeAt(9);
  //   // playerwise.join(',');

  //   playerwise.removeAt(headings.indexOf('Team'));
  //   playerwise.insert(
  //     headings.indexOf('Team'),
  //     team1Name,
  //   );
  //   playerwise.add(data[i].getElementsByTagName('a')[0].attributes['href']);
  //   allplayers.add(playerwise);
  //   allplayers.sort((a, b) => int.parse(b[1].replaceAll('*', ''))
  //       .compareTo(int.parse(a[1].replaceAll('*', ''))));
  // }

  // print(headings);
  // print(allplayers);
  // print('batting headers' + headings.length.toString());
  // print('batting data' + allplayers.toString());
  // print(allplayers[0].length);
  // print(headings.length);
  // ground_based = allplayers
  //     .where((stats) => stats.elementAt(7) == globals.ground)
  //     .toList();
  return Tuple2(headers, allplayersscript);
}
