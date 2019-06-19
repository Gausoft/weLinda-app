import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:tts/tts.dart';

class BotAgent extends StatefulWidget {
  @override
  _BotAgentState createState() => new _BotAgentState();
}

/* https://github.com/VictorRancesCode/flutter_dialogflow/blob/master/example/lib/main.dart */

class _BotAgentState extends State<BotAgent> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
double qt = 3.5;
  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new RotationTransition(
                turns: new AlwaysStoppedAnimation(320 / 360),

                child: new IconButton(
                    icon: new Icon(Icons.send, color: Colors.purple,),
                    onPressed: () => _handleSubmitted(_textController.text)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void Response(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "config/welinda.json").build();
    // Select Language.ENGLISH or Language.SPANISH or others...
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);

    ChatMessage message = new ChatMessage(
      text: response.getMessage(),
      name: "Assistant",
      type: false,
    );
    // Tts.speak(response.getMessage());
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    if (text.isEmpty || text == "") {
      return;
    }
    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: text,
      name: "Me",
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    Response(text);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(children: <Widget>[
        new Flexible(
            child: new ListView.builder(
          padding: new EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        new Divider(height: 1.0),
        new Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ]),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: new CircleAvatar(child: new Image.asset("assets/assistant.png")),
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(this.name,
                style: new TextStyle(fontWeight: FontWeight.bold)),
            new Container(

              padding: EdgeInsets.all(15.0),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                color: Colors.purple[200],
              ),
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(this.name, style: Theme.of(context).textTheme.subhead),
            new Container(
              padding: EdgeInsets.all(15.0),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                color: Colors.purple[200],
              ),
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ),
      new Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: new CircleAvatar(child: new Text(this.name[0])),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
