import 'package:flutter/material.dart';

class InitialRoute extends StatefulWidget {
  InitialRoute({Key key}) : super(key: key);
  static String id = 'initialRoute';
  @override
  _InitialRouteState createState() => _InitialRouteState();
}

class _InitialRouteState extends State<InitialRoute> {
 
  var bottomSheetpage = 0;
  var releaseVer = '0.1';
  var taskctr = 0;

  TextEditingController con1 = TextEditingController();
  TextEditingController con2 = TextEditingController();
  var taskTitle;
  var taskDesp;
  var listtaskTitle = List();
  var listtaskDesp = List();
  @override
  Widget build(BuildContext context) {
    var devsize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 30),
                      CircleAvatar(
                        backgroundColor: Colors.grey[50],
                        radius: 25,
                        child: Icon(
                          Icons.list,
                          color: Colors.pink,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 30),
                      Text(
                        'ToDoApp',
                        style: TextStyle(
                          color: Colors.grey[50],
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 120),
                      Text(
                        '$taskctr Tasks',
                        style: TextStyle(
                          color: Colors.grey[50],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            height: devsize.height * 0.3,
            decoration: BoxDecoration(
              color: Colors.pink[500],
            ),
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.pink[50],
              ),
              child: (listtaskTitle.length <= 0)
                  ? ListView(
                      children: [
                        SizedBox(height: devsize.height * 0.2),
                        Text('Tap ➕ to Add Tasks', textAlign: TextAlign.center)
                      ],
                    )
                  : ListView.builder(
                      itemCount: listtaskTitle.length,
                      itemBuilder: (context, index) {
                        final item = listtaskTitle.length-index;
                        return Column(
                          children: [
                            Dismissible(
                                key: Key(item),
                                background:Container(color:Colors.red[600]),
                                onDismissed: (direction){
                                    setState((){
                                        listtaskTitle.removeAt(index);
                                          listtaskDesp.removeAt(index);
                                          taskctr--;
                                    });
                                },
                                child:Card(
                                elevation: 2.0,
                                color: Colors.black87,
                                margin: EdgeInsets.all(3),
                                child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      child: Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    title: Text(
                                      '${listtaskTitle[index]}',
                                      style: TextStyle(
                                        color: Colors.green[400],
                                        fontSize: 18,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '▫ ${listtaskDesp[index]}',
                                      style: TextStyle(
                                        color: Colors.grey[50],
                                        fontSize: 14,
                                      ),
                                    ),
                                    )),//Card
                            ),
                            index == (listtaskTitle.length - 1)
                                ? SizedBox(
                                    height: devsize.height * 0.1,
                                    child: Text('\nTap ➕ to Add more '))
                                : SizedBox(height: 0),
                          ],
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: (context, sheetState) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.pink[500],
                          ),
                          child: TextField(
                            controller: (bottomSheetpage == 0) ? con1 :  con2,
                            cursorColor: Colors.black87,
                            cursorWidth: 4,
                            style: TextStyle(
                              color: Colors.grey[50],
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 20),
                                hintText: (bottomSheetpage == 0)
                                    ? ' Enter Task Title'
                                    : 'Enter Description',
                                hintStyle: TextStyle(
                                  color: Colors.grey[50],
                                  fontSize: 15,
                                )),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                if (bottomSheetpage == 1) {
                                  sheetState(() {
                                    bottomSheetpage = 0;
                                  });
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 15),
                                padding: EdgeInsets.only(
                                    left: 70, right: 70, top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (bottomSheetpage == 0)
                                      ? Colors.black26
                                      : Colors.black87,
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.grey[50],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (bottomSheetpage == 0) {
                                  taskTitle = con1.text;
                                  sheetState(() {
                                    bottomSheetpage = 1;
                                  });
                                } else if (bottomSheetpage == 1) {
                                  taskDesp = con2.text;
                                  setState(() {
                                    sheetState(() {
                                      bottomSheetpage = 0;
                                    });
                                    listtaskTitle.add(taskTitle);
                                    listtaskDesp.add(taskDesp);
                                    
                                    taskctr++;
                                    con1.text = '';
                                    con2.text = '';
                                    taskTitle = '';
                                    taskDesp = '';
                                  });
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                padding: EdgeInsets.only(
                                    left: 70, right: 70, top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black87,
                                ),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[50],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 200),
                        Text(
                          'ToDoApp v$releaseVer',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                });
              });
        },
        backgroundColor: Colors.purple[400],
        child: Icon(Icons.add),
      ),
    );
  }
}
