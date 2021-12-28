// import 'dart:async';
// import 'package:audio_service/audio_service.dart';
// import 'package:just_audio/just_audio.dart';
// MediaControl playControl = MediaControl(
//   androidIcon: 'drawable/ic_action_play_arrow',
//   label: 'Play',
//   action: MediaAction.play,
// );
// MediaControl pauseControl = MediaControl(
//   androidIcon: 'drawable/ic_action_pause',
//   label: 'Pause',
//   action: MediaAction.pause,
// );
// MediaControl skipToNextControl = MediaControl(
//   androidIcon: 'drawable/ic_action_skip_next',
//   label: 'Next',
//   action: MediaAction.skipToNext,
// );
// MediaControl skipToPreviousControl = MediaControl(
//   androidIcon: 'drawable/ic_action_skip_previous',
//   label: 'Previous',
//   action: MediaAction.skipToPrevious,
// );
// MediaControl stopControl = MediaControl(
//   androidIcon: 'drawable/ic_action_stop',
//   label: 'Stop',
//   action: MediaAction.stop,
// );
// class AudioPlayerTask extends BackgroundAudioTask {
//   //
//   var _queue = <MediaItem>[];
// int _queueIndex = -1;
// AudioPlayer _audioPlayer = new AudioPlayer();
//   AudioProcessingState _skipState;
//   bool _playing;
// bool get hasNext => _queueIndex + 1 < _queue.length;
// bool get hasPrevious => _queueIndex > 0;
// MediaItem get mediaItem => _queue[_queueIndex];
// StreamSubscription<AudioPlaybackState> _playerStateSubscription;
//   StreamSubscription<AudioPlaybackEvent> _eventSubscription;
// @override
//   void onStart(Map<String, dynamic> params) {
//     _queue.clear();
//     List mediaItems = params['data'];
//     for (int i = 0; i < mediaItems.length; i++) {
//       MediaItem mediaItem = MediaItem.fromJson(mediaItems[i]);
//       _queue.add(mediaItem);
//     }
//     _playerStateSubscription = _audioPlayer.playbackStateStream
//         .where((state) => state == AudioPlaybackState.completed)
//         .listen((state) {
//       _handlePlaybackCompleted();
//     });
//     _eventSubscription = _audioPlayer.playbackEventStream.listen((event) {
//       final bufferingState =
//           event.buffering ? AudioProcessingState.buffering : null;
//       switch (event.state) {
//         case AudioPlaybackState.paused:
//           _setState(
//               processingState: bufferingState ?? AudioProcessingState.ready,
//               position: event.position);
//           break;
//         case AudioPlaybackState.playing:
//           _setState(
//               processingState: bufferingState ?? AudioProcessingState.ready,
//               position: event.position);
//           break;
//         case AudioPlaybackState.connecting:
//           _setState(
//               processingState: _skipState ?? AudioProcessingState.connecting,
//               position: event.position);
//           break;
//         default:
//       }
//     });
//     AudioServiceBackground.setQueue(_queue);
//     onSkipToNext();
//   }
// @override
//   void onPlay() {
//     if (_skipState == null) {
//       _playing = true;
//       _audioPlayer.play();
//     }
//   }
// @override
//   void onPause() {
//     _playing = false;
//     _audioPlayer.pause();
//   }
// @override
//   void onSkipToNext() async {
//     skip(1);
//   }
// @override
//   void onSkipToPrevious() {
//     skip(-1);
//   }
// void skip(int offset) async {
//     int newPos = _queueIndex + offset;
//     if (!(newPos >= 0 && newPos < _queue.length)) {
//       return;
//     }
//     if (null == _playing) {
//       _playing = true;
//     } else if (_playing) {
//       await _audioPlayer.stop();
//     }
//     _queueIndex = newPos;
//     _skipState = offset > 0
//         ? AudioProcessingState.skippingToNext
//         : AudioProcessingState.skippingToPrevious;
//     AudioServiceBackground.setMediaItem(mediaItem);
//     await _audioPlayer.setUrl(mediaItem.id);
//     print(mediaItem.id);
//     _skipState = null;
//     if (_playing) {
//       onPlay();
//     } else {
//       _setState(processingState: AudioProcessingState.ready);
//     }
//   }
// @override
//   Future<void> onStop() async {
//     _playing = false;
//     await _audioPlayer.stop();
//     await _audioPlayer.dispose();
//     _playerStateSubscription.cancel();
//     _eventSubscription.cancel();
//     return await super.onStop();
//   }
// @override
//   void onSeekTo(Duration position) {
//     _audioPlayer.seek(position);
//   }
// @override
//   void onClick(MediaButton button) {
//     playPause();
//   }
// @override
//   Future<void> onFastForward() async {
//     await _seekRelative(fastForwardInterval);
//   }
// @override
//   Future<void> onRewind() async {
//     await _seekRelative(rewindInterval);
//   }
// Future<void> _seekRelative(Duration offset) async {
//     var newPosition = _audioPlayer.playbackEvent.position + offset;
//     if (newPosition < Duration.zero) {
//       newPosition = Duration.zero;
//     }
//     if (newPosition > mediaItem.duration) {
//       newPosition = mediaItem.duration;
//     }
//     await _audioPlayer.seek(_audioPlayer.playbackEvent.position + offset);
//   }
// _handlePlaybackCompleted() {
//     if (hasNext) {
//       onSkipToNext();
//     } else {
//       onStop();
//     }
//   }
// void playPause() {
//     if (AudioServiceBackground.state.playing)
//       onPause();
//     else
//       onPlay();
//   }
// Future<void> _setState({
//     AudioProcessingState processingState,
//     Duration position,
//     Duration bufferedPosition,
//   }) async {
//     print('SetState $processingState');
//     if (position == null) {
//       position = _audioPlayer.playbackEvent.position;
//     }
//     await AudioServiceBackground.setState(
//       controls: getControls(),
//       systemActions: [MediaAction.seekTo],
//       processingState:
//           processingState ?? AudioServiceBackground.state.processingState,
//       playing: _playing,
//       position: position,
//       bufferedPosition: bufferedPosition ?? position,
//       speed: _audioPlayer.speed,
//     );
//   }
// List<MediaControl> getControls() {
//     if (_playing) {
//       return [
//         skipToPreviousControl,
//         pauseControl,
//         stopControl,
//         skipToNextControl
//       ];
//     } else {
//       return [
//         skipToPreviousControl,
//         playControl,
//         stopControl,
//         skipToNextControl
//       ];
//     }
//   }
// }
// class AudioState {
//   final List<MediaItem> queue;
//   final MediaItem mediaItem;
//   final PlaybackState playbackState;
// AudioState(this.queue, this.mediaItem, this.playbackState);
// }
// and our Main UI will be like this.
// import 'dart:math';
// import 'package:audio_service/audio_service.dart';
// import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart';
// import 'AudioPlayerTask.dart';
// class BGAudioPlayerScreen extends StatefulWidget {
//   @override
//   _BGAudioPlayerScreenState createState() => _BGAudioPlayerScreenState();
// }
// class _BGAudioPlayerScreenState extends State<BGAudioPlayerScreen> {
//   final BehaviorSubject<double> _dragPositionSubject =
//       BehaviorSubject.seeded(null);
// final _queue = <MediaItem>[
//     MediaItem(
//       id: "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3",
//       album: "Science Friday",
//       title: "A Salute To Head-Scratching Science",
//       artist: "Science Friday and WNYC Studios",
//       duration: Duration(milliseconds: 5739820),
//       artUri:
//           "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
//     ),
//     MediaItem(
//       id: "https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3",
//       album: "Science Friday",
//       title: "From Cat Rheology To Operatic Incompetence",
//       artist: "Science Friday and WNYC Studios",
//       duration: Duration(milliseconds: 2856950),
//       artUri:
//           "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
//     ),
//   ];
// bool _loading;
// @override
//   void initState() {
//     super.initState();
//     _loading = false;
//   }
// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Audio Player'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20.0),
//         color: Colors.white,
//         child: StreamBuilder<AudioState>(
//           stream: _audioStateStream,
//           builder: (context, snapshot) {
//             final audioState = snapshot.data;
//             final queue = audioState?.queue;
//             final mediaItem = audioState?.mediaItem;
//             final playbackState = audioState?.playbackState;
//             final processingState =
//                 playbackState?.processingState ?? AudioProcessingState.none;
//             final playing = playbackState?.playing ?? false;
//             return Container(
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   if (processingState == AudioProcessingState.none) ...[
//                     _startAudioPlayerBtn(),
//                   ] else ...[
//                     //positionIndicator(mediaItem, playbackState),
//                     SizedBox(height: 20),
//                     if (mediaItem?.title != null) Text(mediaItem.title),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         !playing
//                             ? IconButton(
//                                 icon: Icon(Icons.play_arrow),
//                                 iconSize: 64.0,
//                                 onPressed: AudioService.play,
//                               )
//                             : IconButton(
//                                 icon: Icon(Icons.pause),
//                                 iconSize: 64.0,
//                                 onPressed: AudioService.pause,
//                               ),
//                         // IconButton(
//                         //   icon: Icon(Icons.stop),
//                         //   iconSize: 64.0,
//                         //   onPressed: AudioService.stop,
//                         // ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.skip_previous),
//                               iconSize: 64,
//                               onPressed: () {
//                                 if (mediaItem == queue.first) {
//                                   return;
//                                 }
//                                 AudioService.skipToPrevious();
//                               },
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.skip_next),
//                               iconSize: 64,
//                               onPressed: () {
//                                 if (mediaItem == queue.last) {
//                                   return;
//                                 }
//                                 AudioService.skipToNext();
//                               },
//                             )
//                           ],
//                         ),
//                       ],
//                     )
//                   ]
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// _startAudioPlayerBtn() {
//     List<dynamic> list = List();
//     for (int i = 0; i < 2; i++) {
//       var m = _queue[i].toJson();
//       list.add(m);
//     }
//     var params = {"data": list};
//     return MaterialButton(
//       child: Text(_loading ? "Loading..." : 'Start Audio Player'),
//       onPressed: () async {
//         setState(() {
//           _loading = true;
//         });
//         await AudioService.start(
//           backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
//           androidNotificationChannelName: 'Audio Player',
//           androidNotificationColor: 0xFF2196f3,
//           androidNotificationIcon: 'mipmap/ic_launcher',
//           params: params,
//         );
//         setState(() {
//           _loading = false;
//         });
//       },
//     );
//   }
// Widget positionIndicator(MediaItem mediaItem, PlaybackState state) {
//     double seekPos;
//     return StreamBuilder(
//       stream: Rx.combineLatest2<double, double, double>(
//           _dragPositionSubject.stream,
//           Stream.periodic(Duration(milliseconds: 200)),
//           (dragPosition, _) => dragPosition),
//       builder: (context, snapshot) {
//         double position =
//             snapshot.data ?? state.currentPosition.inMilliseconds.toDouble();
//         double duration = mediaItem?.duration?.inMilliseconds?.toDouble();
//         return Column(
//           children: [
//             if (duration != null)
//               Slider(
//                 min: 0.0,
//                 max: duration,
//                 value: seekPos ?? max(0.0, min(position, duration)),
//                 onChanged: (value) {
//                   _dragPositionSubject.add(value);
//                 },
//                 onChangeEnd: (value) {
//                   AudioService.seekTo(Duration(milliseconds: value.toInt()));
//                   // Due to a delay in platform channel communication, there is
//                   // a brief moment after releasing the Slider thumb before the
//                   // new position is broadcast from the platform side. This
//                   // hack is to hold onto seekPos until the next state update
//                   // comes through.
//                   // TODO: Improve this code.
//                   seekPos = value;
//                   _dragPositionSubject.add(null);
//                 },
//               ),
//             Text("${state.currentPosition}"),
//           ],
//         );
//       },
//     );
//   }
// }
// Stream<AudioState> get _audioStateStream {
//   return Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState,
//       AudioState>(
//     AudioService.queueStream,
//     AudioService.currentMediaItemStream,
//     AudioService.playbackStateStream,
//     (queue, mediaItem, playbackState) => AudioState(
//       queue,
//       mediaItem,
//       playbackState,
//     ),
//   );
// }
// void _audioPlayerTaskEntrypoint() async {
//   AudioServiceBackground.run(() => AudioPlayerTask());
// }