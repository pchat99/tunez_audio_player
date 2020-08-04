import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(App());

_launchurl() async {
  const url =
      'https://play.google.com/store/apps/details?id=com.spotify.music&hl=en_IN';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'error';
  }
}

var MySpotifyIcon = Icon(
  FontAwesomeIcons.spotify,
  color: Colors.black,
);
// ignore: non_constant_identifier_names
var MySpotifyButton = IconButton(icon: MySpotifyIcon, onPressed: _launchurl);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AudioPlayerScreen(),
        theme: ThemeData(primaryColor: Colors.black));
  }
}

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String currentTime = "00:00";
  String completeTime = "00:00";

  @override
  void initState() {
    super.initState();
    _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      setState(() {
        currentTime = duration.toString().split(".")[0];
      });
    });
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        completeTime = duration.toString().split(".")[0];
      });
    });
  }

  var myappbar = AppBar(
    title: Text(
      'Audio Player',
      style: TextStyle(
        color: Colors.black,
      ),
      textDirection: TextDirection.ltr,
    ),
    backgroundColor: Colors.yellow,
    actions: <Widget>[
      MySpotifyButton,
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: myappbar,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.audiotrack),
        backgroundColor: Colors.yellow,
        onPressed: () async {
          String filePath = await FilePicker.getFilePath();

          int status = await _audioPlayer.play(filePath, isLocal: true);

          if (status == 1) {
            setState(() {
              _isPlaying = true;
            });
          }
        },
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(
                  left: 10,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(FontAwesomeIcons.chevronDown),
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.yellow.shade300,
                      offset: Offset(0, 20),
                      spreadRadius: 0,
                      blurRadius: 20,
                    ),
                    BoxShadow(
                      color: Colors.yellow.shade300,
                      offset: Offset(0, 20),
                      spreadRadius: 0,
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image(
                    image: NetworkImage(
                        "https://raw.githubusercontent.com/pchat99/flutter_audio_player/master/shutdown.jpg"),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.width * 0.7,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                "SHUTDOWN",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Divine, GullyGang and MassAppeal",
                style: TextStyle(color: Colors.yellow),
              ),
              SizedBox(
                height: 20,
              ),
              Slider(
                  onChanged: (duration) {},
                  value: 10,
                  max: 100,
                  min: 0,
                  activeColor: Colors.yellow),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.backward),
                    color: Colors.yellow,
                  ),
                  IconButton(
                    icon: Icon(
                      _isPlaying
                          ? FontAwesomeIcons.pause
                          : FontAwesomeIcons.play,
                      color: Colors.yellow,
                    ),
                    onPressed: () {
                      if (_isPlaying) {
                        _audioPlayer.pause();
                        setState(() {
                          _isPlaying = false;
                        });
                      } else {
                        _audioPlayer.resume();
                        setState(() {
                          _isPlaying = true;
                        });
                      }
                    },
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.forward),
                    color: Colors.yellow,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
