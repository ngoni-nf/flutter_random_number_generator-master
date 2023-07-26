import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _result = 100;
  int _rangeInitial = 1;
  int _rangeFinal = 100;

  var minController = TextEditingController();
  var maxController  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Number'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white,),
            onPressed: (){
              _showDialogSetup(context);
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Range $_rangeInitial to $_rangeFinal', style: TextStyle(color: Colors.grey, fontSize: 18)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(_result.toString(), style: TextStyle(color: Colors.grey, fontSize: 60)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton.extended(
                  label: Text('Generate', style: TextStyle(color: Colors.white),),
                  icon: Icon(Icons.refresh, color: Colors.white),
                  onPressed: (){
                    //Generate Ramdom Number
                    var random = math.Random();
                    int max = _rangeFinal - _rangeInitial + 1;

                    int randomNumber = random.nextInt(max);
                    setState(() {
                      _result = randomNumber + _rangeInitial;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showDialogSetup(BuildContext context){
    minController.text = this._rangeInitial.toString();
    maxController.text = this._rangeFinal.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        var WhitelistingTextInputFormatter;
        return AlertDialog(
          title: Center(
            child: Text('Setup Range'),
          ),
          content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      labelText: 'Min',
                      labelStyle: TextStyle(color: Colors.grey[700]),
                      border: OutlineInputBorder(),
                    ),

                    style: TextStyle(color: Colors.grey[700]),
                    controller: minController,
                    keyboardType: TextInputType.number,
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  TextField(
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      labelText: 'Max',
                      labelStyle: TextStyle(color: Colors.grey[700]),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(color: Colors.grey[700]),
                    controller: maxController,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10.0,),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: FlatButton(
                          child: Text(
                            "CLOSE",
                            style: TextStyle(color: Theme.of(context).primaryColor),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: FlatButton(
                          child: Text(
                            "SETUP",
                            style: TextStyle(color: Theme.of(context).primaryColor),
                          ),
                          onPressed: () {
                            if(_rangeInitial < _rangeFinal){
                              setState(() {
                                _rangeInitial = int.parse(minController.text);
                                _rangeFinal = int.parse(maxController.text);
                              });
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ),
        );
      },
    );
  }
}

FlatButton({required Text child, required Null Function() onPressed}) {
}