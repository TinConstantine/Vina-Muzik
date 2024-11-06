import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

Future<AudioHandler> initAudioService() async {
  return await AudioService.init(
    builder: () => MyAudioHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelId: "com.example.vina_music_app.channel.audio",
      androidNotificationChannelName: "vina_music_app",
      androidNotificationIcon: "drawable/ic_stat_music_note",
      androidShowNotificationBadge: true,
      androidStopForegroundOnPause: true,
      notificationColor: Colors.grey[900],
    ),
  );
}

abstract class AudioPlayerHandler implements AudioHandler {
  Future<void> setNewPlaylist(
      {required List<MediaItem> mediaItems, required int index});

  Future<void> moveQueueItem(
      {required int currentIndex, required int newIndex});

  Future<void> removeQueueItemIndex(int index);
}

class MyAudioHandler extends BaseAudioHandler implements AudioPlayerHandler {
  final _player = AudioPlayer();
  final _playlist = ConcatenatingAudioSource(
    children: [],
    useLazyPreparation: true,
  );
  late List<int> preferredCompactNotificationButton = [1, 2, 3];

  MyAudioHandler() {
    loadEmptyPlaylist();
    notifyAudioHandlerAboutPlayBackEvents();
    listenForDurationChanges();
    listenForCurrentSongIndexChange();
    listenForSequenceStateChanges();
  }

  Future<void> loadEmptyPlaylist() async {
    try {
      preferredCompactNotificationButton = [0, 1, 2];
      await _player.setAudioSource(_playlist);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> notifyAudioHandlerAboutPlayBackEvents() async {
    _player.playbackEventStream.listen(
      (event) {
        final playing = _player.playing;
        playbackState.add(
          PlaybackState(
            controls: [
              MediaControl.skipToPrevious,
              if (playing) MediaControl.pause else MediaControl.play,
              MediaControl.stop,
              MediaControl.skipToNext,
            ],
            systemActions: const {
              MediaAction.seek,
            },
            androidCompactActionIndices: const [0, 1, 3],
            processingState: const {
              ProcessingState.idle: AudioProcessingState.idle,
              ProcessingState.loading: AudioProcessingState.loading,
              ProcessingState.buffering: AudioProcessingState.buffering,
              ProcessingState.completed: AudioProcessingState.completed,
              ProcessingState.ready: AudioProcessingState.ready,
            }[_player.processingState]!,
            repeatMode: const {
              LoopMode.all: AudioServiceRepeatMode.all,
              LoopMode.off: AudioServiceRepeatMode.none,
              LoopMode.one: AudioServiceRepeatMode.one,
            }[_player.loopMode]!,
            shuffleMode: _player.shuffleModeEnabled
                ? AudioServiceShuffleMode.all
                : AudioServiceShuffleMode.none,
            playing: playing,
            updatePosition: _player.position,
            bufferedPosition: _player.bufferedPosition,
            speed: _player.speed,
            queueIndex: event.currentIndex,
          ),
        );
      },
    );
  }

  Future<void> listenForDurationChanges() async {
    _player.durationStream.listen(
      (event) {
        var index = _player.currentIndex;
        final newQueue = queue.value;
        if (index == null || newQueue.isEmpty || newQueue.length < index) return;
        if (_player.shuffleModeEnabled) {
          index = _player.shuffleIndices!.indexOf(index);
        }
        final oldMediaItem = newQueue[index];
        final newMediaItem = oldMediaItem.copyWith(duration: event);
        newQueue[index] = newMediaItem;
        queue.add(newQueue);
        mediaItem.add(newMediaItem);
      },
    );
  }

  Future<void> listenForCurrentSongIndexChange() async {
    _player.currentIndexStream.listen(
      (event) {
        final pPlaylist = queue.value;
        if (event == null || pPlaylist.isEmpty) return;
        if (_player.shuffleModeEnabled) {
          event = _player.shuffleIndices!.indexOf(event);
        }
        mediaItem.add(pPlaylist[event]);
      },
    );
  }

  Future<void> listenForSequenceStateChanges() async {
    _player.sequenceStateStream.listen(
      (sequenceState) {
        final sequence = sequenceState?.effectiveSequence;
        if (sequenceState == null || sequence!.isEmpty) return;
        final items = sequence.map(
          (source) => source.tag as MediaItem,
        );
        queue.add(items.toList());
      },
    );
  }

  UriAudioSource createAudioSource(MediaItem mediaItem) {
    return AudioSource.uri(Uri.parse(mediaItem.extras?['url'] as String),
        tag: mediaItem);
  }

  List<UriAudioSource> createAudioSources(List<MediaItem> mediaItem) {
    return mediaItem
        .map(
          (e) => AudioSource.uri(Uri.parse(e.extras?['url'] as String),
              tag: e),
        )
        .toList();
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    final audioSource = createAudioSource(mediaItem);
    await _playlist.add(audioSource);
    final newQueue = queue.value..add(mediaItem);
    queue.add(newQueue);
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    final audioSource = createAudioSources(mediaItems);
    await _playlist.addAll(audioSource);
    final newQueue = queue.value..addAll(mediaItems);
    queue.add(newQueue);
  }

  @override
  Future<void> updateMediaItem(MediaItem mediaItem) async {
    final index = queue.value.indexWhere(
      (element) => element.id == mediaItem.id,
    );
    var dataArr = queue.value;
    dataArr[index] = mediaItem;
    queue.add(dataArr);
  }

  @override
  Future<void> removeQueueItemAt(int index) async {
    await _playlist.removeRange(0, index);
    final newQueue = queue.value..clear();
    queue.add(newQueue);
  }

  @override
  Future<void> play() async {
    await _player.play();
  }

  @override
  Future<void> pause() async {
    await _player.pause();
  }

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= queue.value.length) return;
    if (_player.shuffleModeEnabled) {
      index = _player.shuffleIndices![index];
    }
    _player.seek(Duration.zero, index: index);
  }

  @override
  Future<void> skipToNext() async {
    await _player.seekToNext();
  }

  @override
  Future<void> skipToPrevious() async {
    await _player.seekToPrevious();
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    switch (repeatMode) {
      case AudioServiceRepeatMode.none:
        _player.setLoopMode(LoopMode.off);
        break;
      case AudioServiceRepeatMode.group:
      case AudioServiceRepeatMode.all:
        _player.setLoopMode(LoopMode.all);
        break;
      case AudioServiceRepeatMode.one:
        _player.setLoopMode(LoopMode.one);
        break;
    }
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    if (shuffleMode == AudioServiceShuffleMode.none) {
      _player.setShuffleModeEnabled(false);
    } else {
      _player.shuffle();
      _player.setShuffleModeEnabled(true);
    }
  }

  @override
  Future<void> updateQueue(List<MediaItem> queue) async {
    await _playlist.clear();
    await _playlist.addAll(createAudioSources(queue));
  }

  @override
  Future customAction(String name, [Map<String, dynamic>? extras]) async {
    if (name == 'dispose') {
      await _player.dispose();
      super.stop();
    }
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    playbackState.add(playbackState.value
        .copyWith(processingState: AudioProcessingState.idle));
    return super.stop();
  }

  @override
  Future<void> moveQueueItem(
      {required int currentIndex, required int newIndex}) async {
    await _playlist.move(currentIndex, newIndex);

  }

  @override
  Future<void> removeQueueItemIndex(int index) async {
    await _playlist.removeAt(index);

  }

  @override
  Future<void> setNewPlaylist(
      {required List<MediaItem> mediaItems, required int index}) async {
    if (!Platform.isAndroid) await _player.stop();
    var getCount = queue.value.length;
    await _playlist.removeRange(0, getCount);
    final audioSource = createAudioSources(mediaItems);
    await _playlist.addAll(audioSource);
    final newQueue = queue.value..addAll(mediaItems);
    queue.add(newQueue);
    await _player.setAudioSource(_playlist,
        initialIndex: index, initialPosition: Duration.zero);
  }
}
