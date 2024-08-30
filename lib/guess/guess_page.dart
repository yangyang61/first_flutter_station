import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first_station/guess/guess_app_bar.dart';
import 'package:flutter_first_station/guess/result_notice.dart';

class GuessPage extends StatefulWidget {
  const GuessPage({super.key, required this.title});

  final String title;

  @override
  State<GuessPage> createState() => _GuessPageState();
}


class _GuessPageState extends State<GuessPage> {
  int _value = 0;
  bool _guessing = false;
  bool? _isBig;

  TextEditingController _guessCtrl = TextEditingController();

  @override
  void dispose() {
    _guessCtrl.dispose();
    super.dispose();
  }
  void _generateRandomValue() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      Random random = Random();
      _value = random.nextInt(100);
      _guessing = true;
    });
  }

  void _onCheck() {
     print('---------------object $_value----------$_guessCtrl.text');
     int? guessValue = int.tryParse(_guessCtrl.text);
     if(!_guessing||guessValue== null)return;
     if(guessValue==_value) {
       setState(() {
         _isBig=null;
         _guessing=false;
       });
       return;
     }
     setState(() {
       _isBig=guessValue > _value;;
     });

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: GuessAppBar( onCheck:_onCheck,controller: _guessCtrl,),
      body:Stack(
        children: [
          if(_isBig!=null)
             Column(children: [
             if(_isBig!)
               ResultNotice(color:Colors.redAccent,info:'大了'),
             Spacer(),
             if(!_isBig!) ResultNotice(color:Colors.blueAccent,info:'小了'),
            ],),


          Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  Text(
                  '点击生成随机数字:',
                ),
                Text(
                  _guessing?'**':'$_value',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _guessing?null: _generateRandomValue,
        tooltip: 'Increment',
        backgroundColor:_guessing?Colors.grey:Colors.blue,
        child: const Icon(Icons.generating_tokens_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
