import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/NextPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localization/localization/localizations.dart';
import 'package:flutter_localization/localization/LocaleHelper.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => new _MyAppState();
}
class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  Locale locale;
  SpecificLocalizationDelegate _specificLocalizationDelegate;

  @override
   void initState() {
    // TODO: implement initState
//    helper.onLocaleChanged = onLocaleChange;
//    _specificLocalizationDelegate = SpecificLocalizationDelegate(new Locale('ar'));
    this._fetchLocale().then((locale) {
      setState(() {
        this.locale = locale;
        helper.onLocaleChanged = onLocaleChange;
        _specificLocalizationDelegate = SpecificLocalizationDelegate(locale);
      });
    });
    super.initState();
  }

  _fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    return Locale(prefs.getString('lang') ?? "en");
  }

 onLocaleChange(Locale locale){
    setState((){
      _specificLocalizationDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this.locale == null) {
      return Center(child: CircularProgressIndicator(),);
    } else {
      return MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          //app-specific localization
          _specificLocalizationDelegate
        ],
        supportedLocales: [Locale('en'), Locale('ar')],
        locale: _specificLocalizationDelegate.overriddenLocale,
        //_specificLocalizationDelegate.overriddenLocale ,
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      );
    }
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage( {Key key, this.title}) : super(key: key);
    final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(AppLocalizations.of(context).title),
          actions: <Widget>[
            new FlatButton(
              child: new Text("English"), color: AppLocalizations.of(context).locale == "en" ? Colors.grey : Colors.blue, onPressed: (){
                  this.setState((){
                    helper.onLocaleChanged(new Locale("en"));
                    setLocale(lang: 'en');
                  });
              },
            ),

            new FlatButton(
              child: Text("عربى"),color:  AppLocalizations.of(context).locale == "ar" ? Colors.grey : Colors.blue,onPressed: (){
                this.setState((){
                    helper.onLocaleChanged(new Locale("ar"));
                    setLocale(lang: 'ar');
                  });
              },
            )
          ],

        ),
        body: new Form(
          key: _formKey,
          child: new SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 24.0),
                new TextFormField(
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    icon: const Icon(Icons.person),
                    hintText: '',
                    labelText: AppLocalizations.of(context).lblname,
                  ),
                  onSaved: (String value) {},
                ),
                const SizedBox(height: 24.0),
                new TextFormField(
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    icon: const Icon(Icons.phone),
                    hintText: '',
                    labelText: AppLocalizations.of(context).lblphone,
                    prefixText: '',
                  ),
                  keyboardType: TextInputType.phone,
                  onSaved: (String value) {},
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly,
                  ],
                ),
                const SizedBox(height: 24.0),
                new TextFormField(
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    icon: const Icon(Icons.email),
                    labelText: AppLocalizations.of(context).lblemail,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String value) {},
                ),
                const SizedBox(height: 24.0),
                const SizedBox(height: 24.0),
                new Center(
                  child: new RaisedButton(
                    child:  Text(AppLocalizations.of(context).btnsubmit),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NextPage()));
                    },
                  ),
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ));
  }

  void setLocale({String lang}) async {
    print("longage is: $lang");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("lang", lang);
  }
}
