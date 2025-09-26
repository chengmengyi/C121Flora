import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_num_hep.dart';

StorageData<bool> musicSwitch=StorageData<bool>(key: "musicSwitch", defaultValue: true);

class AudioName{
  static const String click="click";
  static const String clickPaoPao="click_paopao";
  static const String fail="fail";
  static const String wheel="wheel";
  static const String win="win";
  static const String dice="dice";
  static const String money="money";
}

class Flora121MusicHep{
  static final Flora121MusicHep _hep = Flora121MusicHep();
  static Flora121MusicHep get instance => _hep;


  final AudioPlayer _bgm=AudioPlayer();
  // final AudioPlayer _audio=AudioPlayer();

  init()async{
    final audioContext = AudioContext(
      android: const AudioContextAndroid(
        isSpeakerphoneOn: true,
        stayAwake: false,
        contentType: AndroidContentType.music,
        usageType: AndroidUsageType.media,
        audioFocus: AndroidAudioFocus.none,
      ),
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.playback,
        options: {
          AVAudioSessionOptions.mixWithOthers
        },
      ),
    );
    await AudioPlayer.global.setAudioContext(audioContext);

    // _audio.onPlayerStateChanged.listen((event) {
    //   if(musicSwitch.getData()){
    //     if(event==PlayerState.playing){
    //       _bgm.pause();
    //     }else if(event==PlayerState.completed){
    //       _bgm.resume();
    //     }
    //   }
    // });
    playBgm();
  }

  playBgm(){
    if(musicSwitch.getData()){
      _bgm.setReleaseMode(ReleaseMode.loop);
      _bgm.play(AssetSource("bgm1.MP3"));
    }
  }

  pauseBgm(){
    if(_bgm.state==PlayerState.playing){
      _bgm.pause();
    }
  }

  onOrOffMusic(){
    if(musicSwitch.getData()){
      musicSwitch.saveData(false);
      _bgm.pause();
    }else{
      musicSwitch.saveData(true);
      playBgm();
    }
  }

  playOtherAudio(String audioName){
    if(musicSwitch.getData()){
      AudioPlayer audio=AudioPlayer();
      audio.onPlayerStateChanged.listen((state){
        if(state==PlayerState.completed){
          audio.dispose();
        }
      });
      audio.play(AssetSource("$audioName.MP3"));
    }
  }
}