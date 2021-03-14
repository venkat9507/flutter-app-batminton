import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:flutter/material.dart';

import 'footballmatch_result.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  bool ischecked = false;
  int pageindex = 0;
  int stepCounter = 0;
  int index;
  var items;
  String check = "false";
  List<String> options = [ 'Lose', 'won'];
  List<String>handA = [ 'Left', 'Right'];
  List<String> handB = [ 'Left', 'Right'];
  List <String> weekDays = ['Mon', 'Tue','Wed','Thu','Fri','Sat','Sun','Mon', 'Tue','Wed','Thu','Fri','Sat','Sun','Mon', 'Tue','Wed','Thu','Fri','Sat','Sun','Mon', 'Tue','Wed','Thu','Fri','Sat','Sun','Mon', 'Tue','Wed','Thu','Fri','Sat','Sun'];
List<int> numb = [1,2,3,4,];
  PageController controller = PageController(viewportFraction: 0.7);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: StreamBuilder(

          stream:
          FirebaseFirestore.instance.collection('FootBall Player').snapshots(),
          builder: (context, snapshot){
            if (!snapshot.hasData) {
              print(snapshot.error);
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else
              {

                  return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Center(
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          controller: controller,
                          physics: NeverScrollableScrollPhysics(),
                          onPageChanged: (int index) {
                            setState(() {
                              pageindex = index;
                            });
                          },
                          children: [
                            for (MapEntry j in snapshot.data.docs.asMap().entries)

                              Container(
                                height: MediaQuery.of(context).size.height * 0.7,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  clipBehavior: Clip.antiAlias,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text('Demo Score Board Month-1'),
                                       Row(

                                         children: [
                                           SizedBox(
                                             width:18,
                                           ),
                                           Column(
                                             crossAxisAlignment: CrossAxisAlignment.center,
                                             children: [
                                               Text('Day',style: TextStyle(fontSize: 10)),
                                             ],
                                           ),
                                           SizedBox(
                                             width: 25,
                                           ),
                                           Column(
                                             children: [
                                               Text('Team A',style: TextStyle(fontSize: 10)),
                                             ],
                                           ),
                                           SizedBox(
                                             width: 3,
                                           ),
                                           Column(
                                             children: [
                                               Text('Hand A',style:  TextStyle(fontSize: 10),),
                                             ],
                                           ),
                                           SizedBox(
                                             width: 3,
                                           ),
                                           Column(
                                             children: [
                                               Text('Team B',style: TextStyle(fontSize: 10)),
                                             ],
                                           ),
                                           SizedBox(
                                             width: 3,
                                           ),
                                           Column(
                                             children: [
                                               Text('Hand B',style:  TextStyle(fontSize: 10),),
                                             ],
                                           ),
                                           SizedBox(
                                             width: 3,
                                           ),
                                           Column(
                                             crossAxisAlignment: CrossAxisAlignment.end,
                                             children: [
                                               Text('W/L',style: TextStyle(fontSize: 10)),
                                             ],
                                           ),
                                         ],
                                       ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                for(  int i= 1; i<32; i++)
                                                  Text(' $i - ${weekDays[i].replaceAll('[', '').replaceAll(']', '',)}',style: TextStyle(fontSize: 9.9,color: weekDays[i] == 'Wed' || weekDays[i] == 'Sat' ? Colors.red : Colors.black ))
                                              ]
                                            ),
                                          Column(
                                            children: [
                                              for(int i = 1; i<32; i++)
                                                Text(
                                                     snapshot.data.docs[j.key]
                                                      .get('Team A').toString(),
                                                    style: TextStyle(fontSize: 10,color: weekDays[i] == 'Wed' || weekDays[i] == 'Sat' ? Colors.red : Colors.black )
                                                ),
                                            ],
                                          ),
                                            Column(
                                              children: [
                                                for(int i = 1; i<32; i++)
                                                  Text(  (randomChoice<String>(handA, )),
                                                      style: TextStyle(fontSize: 10,color: weekDays[i] == 'Wed' || weekDays[i] == 'Sat' ? Colors.red : Colors.black )
                                                  ),

                                              ],
                                            ),
                                            Column(
                                              children: [
                                                for(int i = 1; i<32; i++)
                                                  Text(
                                                      snapshot.data.docs[j.key]
                                                        .get('Team B').toString(),
                                                      style: TextStyle(fontSize: 10,color: weekDays[i] == 'Wed' || weekDays[i] == 'Sat' ? Colors.red : Colors.black )
                                                  ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                for(int i = 1; i<32; i++)
                                                  Text(  (randomChoice<String>(handB, )),
                                                      style: TextStyle(fontSize: 10,color: weekDays[i] == 'Wed' || weekDays[i] == 'Sat' ? Colors.red : Colors.black )
                                                  ),

                                              ],
                                            ),
                                            Column(
                                              children: [
                                                for(int i = 1; i<32; i++)
                                                Text(  (randomChoice<String>(options, )),
                                                    style: TextStyle(fontSize: 10,color: weekDays[i] == 'Wed' || weekDays[i] == 'Sat' ? Colors.red : Colors.black )
                                                ),

                                              ],
                                            )


                                          ],
                                        ),
                                        SizedBox(height: 10,),

                                        Text('Demo Score Board Month -2'),
                                        Row(

                                          children: [
                                            SizedBox(
                                              width:18,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text('Day',style: TextStyle(fontSize: 10)),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 25,
                                            ),
                                            Column(
                                              children: [
                                                Text('Team A',style: TextStyle(fontSize: 10)),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Column(
                                              children: [
                                                Text('Hand A',style:  TextStyle(fontSize: 10),),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Column(
                                              children: [
                                                Text('Team B',style: TextStyle(fontSize: 10)),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Column(
                                              children: [
                                                Text('Hand B',style:  TextStyle(fontSize: 10),),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text('W/L',style: TextStyle(fontSize: 10)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  for(  int i= 1; i<32; i++)
                                                    Text(' $i - ${weekDays[i].replaceAll('[', '').replaceAll(']', '',)}',style: TextStyle(fontSize: 9.9,color: weekDays[i] == 'Wed' || weekDays[i] == 'Sat' ? Colors.red : Colors.black ))
                                                ]
                                            ),
                                            Column(
                                              children: [
                                                for(int i = 1; i<32; i++)
                                                  Text(
                                                      snapshot.data.docs[j.key]
                                                          .get('Team A').toString(),
                                                      style: TextStyle(fontSize: 10,color: weekDays[i] == 'Wed' || weekDays[i] == 'Sat' ? Colors.red : Colors.black )
                                                  ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                for(int i = 1; i<32; i++)
                                                  Text(  (randomChoice<String>(handA, )),
                                                      style: TextStyle(fontSize: 10,color: weekDays[i] == 'Wed' || weekDays[i] == 'Sat' ? Colors.red : Colors.black )
                                                  ),

                                              ],
                                            ),
                                            Column(
                                              children: [
                                                for(int i = 1; i<32; i++)
                                                  Text(
                                                      snapshot.data.docs[j.key]
                                                          .get('Team B').toString(),
                                                      style: TextStyle(fontSize: 10,color: weekDays[i] == 'Wed' || weekDays[i] == 'Sat' ? Colors.red : Colors.black )
                                                  ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                for(int i = 1; i<32; i++)
                                                  Text(  (randomChoice<String>(handB, )),
                                                      style: TextStyle(fontSize: 10,color: weekDays[i] == 'Wed' || weekDays[i] == 'Sat' ? Colors.red : Colors.black )
                                                  ),

                                              ],
                                            ),
                                            Column(
                                              children: [
                                                for(int i = 1; i<32; i++)
                                                  Text(  (randomChoice<String>(options, )),
                                                      style: TextStyle(fontSize: 10,color: weekDays[i] == 'Wed' || weekDays[i] == 'Sat' ? Colors.red : Colors.black )
                                                  ),

                                              ],
                                            )


                                          ],
                                        ),
                                        SizedBox(height: 10,),

                                        Text('Demo Score Board Month -3'),
                                        Row(

                                          children: [
                                            SizedBox(
                                              width:18,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text('Day',style: TextStyle(fontSize: 10)),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 25,
                                            ),
                                            Column(
                                              children: [
                                                Text('Team A',style: TextStyle(fontSize: 10)),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Column(
                                              children: [
                                                Text('Hand A',style:  TextStyle(fontSize: 10),),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Column(
                                              children: [
                                                Text('Team B',style: TextStyle(fontSize: 10)),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Column(
                                              children: [
                                                Text('Hand B',style:  TextStyle(fontSize: 10),),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text('W/L',style: TextStyle(fontSize: 10)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  for(  int i= 1; i<32; i++)
                                                    Text(' $i - ${weekDays[i].replaceAll('[', '').replaceAll(']', '',)}',style: TextStyle(fontSize: 9.9,color: weekDays[i] == 'Wed' || weekDays[i] == 'Sat' ? Colors.red : Colors.black ))
                                                ]
                                            ),
                                            Column(
                                              children: [
                                                for(int i = 1; i<32; i++)
                                                  Text(
                                                      snapshot.data.docs[j.key]
                                                          .get('Team A').toString(),
                                                      style: TextStyle(fontSize: 10,color: weekDays[i] == 'Wed' || weekDays[i] == 'Sat' ? Colors.red : Colors.black )
                                                  ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                for(int i = 1; i<32; i++)
                                                  Text(  (randomChoice<String>(handA, )),
                                                      style: TextStyle(fontSize: 10,color: weekDays[i] == 'Wed' || weekDays[i] == 'Sat' ? Colors.red : Colors.black )
                                                  ),

                                              ],
                                            ),
                                            Column(
                                              children: [
                                                for(int i = 1; i<32; i++)
                                                  Text(
                                                      snapshot.data.docs[j.key]
                                                          .get('Team B').toString(),
                                                      style: TextStyle(fontSize: 10,color: weekDays[i] == 'Wed' || weekDays[i] == 'Sat' ? Colors.red : Colors.black )
                                                  ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                for(int i = 1; i<32; i++)
                                                  Text(  (randomChoice<String>(handB, )),
                                                      style: TextStyle(fontSize: 10,color: weekDays[i] == 'Wed' || weekDays[i] == 'Sat' ? Colors.red : Colors.black )
                                                  ),

                                              ],
                                            ),
                                            Column(
                                              children: [
                                                for(int i = 1; i<32; i++)
                                                  Text(  (randomChoice<String>(options, )),
                                                      style: TextStyle(fontSize: 10,color: weekDays[i] == 'Wed' || weekDays[i] == 'Sat' ? Colors.red : Colors.black )
                                                  ),

                                              ],
                                            )


                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlatButton(
                                color: Colors.white,
                                child: Center(child: Text('Back')),
                                onPressed: () {
                                  controller.previousPage(
                                      duration: Duration(milliseconds: 1000),
                                      curve: Curves.easeOutQuad);
                                })),
                        pageindex + 1 == snapshot.data.docs.length
                            ? FlatButton(
                          color: Colors.pink,
                          child: Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              )),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=> Football()));
                          },
                        )
                            : FlatButton(
                          color: Colors.pink,
                          child: Center(
                              child: Text(
                                'Next',
                                style: TextStyle(color: Colors.white),
                              )),
                          onPressed: () {




                            controller.nextPage(
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.easeOutQuad);

                          },
                        ),
                      ],
                    ),
                  ],
                );
              }
      }),
    ));
  }
}
