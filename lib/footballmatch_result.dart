import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:flutter/material.dart';
import 'result.dart';
import 'package:selectable_circle/selectable_circle.dart';
import 'package:smart_select/smart_select.dart';

final _firestore = FirebaseFirestore.instance;

class Football extends StatefulWidget {
  @override
  _FootballState createState() => _FootballState();
}
class _FootballState extends State<Football> {



  TextStyle text = TextStyle(fontSize: 30);
  int number = 25;
   var random = Random();
  var list = ['won','loss'];
  String person1 = 'prithivi';
  String person2 = 'venkat';
  List<String> options = [ 'Lose', 'won'];
  List <String> weekDays = ['Monday', 'Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.orange.shade400,
          title: Center(child: Text('Badminton')),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.5,
              ),
             Center(
               child: InkWell(
                 onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> Onpressed())),
                 child: Container(
                   color: Theme.of(context).primaryColor,
                   child:  Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: Text('Badminton',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                   ),
                 ),
               ),
             ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: InkWell(
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> Result())),
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child:  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Result',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
    );
  }

}


class Onpressed extends StatefulWidget {
  @override
  _OnpressedState createState() => _OnpressedState();
}

class _OnpressedState extends State<Onpressed> {
  List<String> _peoples = List();
  List<String> TeamAHandler = List();
  List<String> TeamBHandler = List();
  List image = List();
  List<Widget> people = List();
  List<String> total = List();
  List<String> totaldescription = List();
  List<String> _title = List();
  List<String> _descriptions = List();
  List<Widget> description = List();
  bool result = true;
  var item;
  Uri uri;
  var descriptionItems;
  TextEditingController teamA = TextEditingController();
  String name;
  String descriptions;
  String day;
  String handA;
  String handB;
void pressed (){
  setState(() {
    onpressed();
  });
}

  String value ;
  List<S2Choice<String>> batsmanHand = [
    S2Choice<String>(value: 'left', title: 'Left'),
    S2Choice<String>(value: 'right', title: 'Right'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      Center(
        child: IconButton(
            color: Colors.grey,iconSize: 50,
            icon: Icon(Icons.add,color: Colors.pink,size: 50,
        ), onPressed: onpressed),
      ),
          Text('Press the Plus icon to add players')
        ],
      )),
    );
  }
  onpressed() {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter stateSetter) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Text(
                              "Enter Team A and B Player Details",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: new TextFormField(
                        //     onChanged: (val) {
                        //       setState(() {
                        //         day = val;
                        //       });
                        //     },
                        //     decoration: InputDecoration(
                        //         border: OutlineInputBorder(
                        //             borderRadius: BorderRadius.circular(12.0)),
                        //         hintText: ' Title '),
                        //   ),
                        // ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Widget widget = people.elementAt(index);
                              return Row(
                                children: [
                                  widget,
                                  IconButton(
                                      icon: Icon(
                                        Icons.close,
                                      ),
                                      onPressed: () {
                                        deleted(stateSetter, index);
                                      }),
                                ],
                              );
                            },
                            itemCount: people.length,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                            backgroundColor: Colors.pink,
                            onPressed: () {

                              updated(stateSetter);
                              name != null
                                  ? _peoples.add(name)
                                  : print('Null value');
                              print('Controller : $name');
                              descriptions != null
                                  ? _descriptions.add(descriptions)
                                  : print('Null value');
                              setState(() {
                                name = null;
                                print(image.length);
                              });
                              setState(() {


                                print(TeamAHandler);
                                print(TeamBHandler);
                              });
                              setState(() {
                                value= null;
                                print('value null or not $value');

                              });
                            },
                            child: new Icon(Icons.add),
                          ),
                        ),
                        Row(
                          children: [
                            FlatButton(
                              onPressed: () async {
                                _peoples.add(name);
                                _descriptions.add(descriptions);
                                print('Controller : $name, $descriptions');
                                total.add(_peoples.toString());
                                total.add(_descriptions.toString());


                                await _firestore.collection('FootBall Player').add({
                                  // 'HEADING': teamA.text,
                                  'Team A': _peoples,
                                  'Team B': _descriptions,
                                  'Team A Handling Side' : TeamAHandler,
                                  'Team Bf Handling Side' : TeamBHandler,
                                });
                                print('_peoples --$_peoples');
                                print('description--$_descriptions');
                                print('Handler $TeamAHandler');
                                print(total);
                                _peoples.clear();
                                people.clear();
                                teamA.clear();
                                _descriptions.clear();
                                image.clear();
                                setState(() {
                                  name = null;
                                  descriptions = null;
                                  result = false;
                                  print(image);
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=> Football()));
                              },
                              child: Text('Submit'),
                            ),
                            FlatButton(
                              onPressed: () {
                                // _peoples.clear();
                                // people.clear();
                                teamA.clear();

                                setState(() {
                                  name = null;
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }),
          );
        });
  }

  Future updated(StateSetter updateState) {
    updateState(() {
      people.add(Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      hintText: '${people.length + 1}- Team A player '),
                ),
              ),
          SmartSelect<String>.single(
              title: 'Left or Right Hand Batsman',
              value: value,
              choiceItems: batsmanHand,
              onChange: (state){
                setState(() {
                  handA = state.value;
                  TeamAHandler.add(handA);

                });
              }
          ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  onChanged: (val) {
                    setState(() {
                      descriptions = val;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      hintText: '${people.length + 1}- Team B player '),
                ),
              ),
              SmartSelect<String>.single(
                  title: 'Left or Right Hand Batsman',
                  value: value,
                  choiceItems: batsmanHand,
                  onChange: (state){
                    setState(() {
                      handB = state.value;
                      print('demo $handB');
                      TeamBHandler.add(handB);
                    });
                  }
              ),
            ],
          )));
      setState(() {});
    });
  }

  deleted(StateSetter updateState, index) {
    updateState(() {
      people.removeAt(index);
    });
  }

}
