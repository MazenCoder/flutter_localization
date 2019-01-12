import 'package:flutter/material.dart';
import 'package:flutter_localization/localization/localizations.dart';

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(AppLocalizations.of(context).title),
        actions: <Widget>[
          new FlatButton(
            child: new Text("English"), color: AppLocalizations.of(context).locale == "en" ? Colors.grey : Colors.blue, onPressed: (){
            this.setState((){

            });
          },
          ),

          new FlatButton(
            child: Text("عربى"),color:  AppLocalizations.of(context).locale == "ar" ? Colors.grey : Colors.blue,onPressed: (){
            this.setState((){
            });
          },
          )
        ],

      ),
      body: new Container(
        child: new ListView(
          children: <Widget>[
            new RaisedButton(onPressed: () {
              Navigator.pop(context);
            },
              child: new Text(AppLocalizations.of(context).lblemail),
            )
          ],
        ),
      ),
    );
  }
}
