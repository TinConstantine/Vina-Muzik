import 'dart:ui' as ui;

import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vina_music_app/audio_helpers/page_manager.dart';
import 'package:vina_music_app/audio_helpers/service_locator.dart';
import 'package:vina_music_app/common/state_helper.dart';
import 'package:vina_music_app/page/main_player/main_player_page/main_player_page.dart';

import '../common/color_extension.dart';
import '../common/image.dart';
import 'control_buttons.dart';

class MiniPlayer extends StatefulWidget {
  static const MiniPlayer _instance = MiniPlayer._internal();

  factory MiniPlayer() {
    return _instance;
  }

  const MiniPlayer._internal();

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<AudioProcessingState>(
      valueListenable: pageManager.playbackStatNotifier,
      builder: (context, processingState, child) {
        if (processingState == AudioProcessingState.idle) {
          return space0;
        }
        return ValueListenableBuilder<MediaItem?>(
          valueListenable: pageManager.currentSongNotifier,
          builder: (context, mediaItem, child) {
            if (mediaItem == null) return space0;
            return Dismissible(
              key: const Key('mini_player'),
              direction: DismissDirection.down,
              onDismissed: (direction) {
                Feedback.forLongPress(context);
                pageManager.stop();
              },
              child: Dismissible(
                key: Key(mediaItem.id),
                confirmDismiss: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    pageManager.previous();
                  } else {
                    pageManager.next();
                  }
                  return Future.value(false);
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 2.0, vertical: 1.0),
                  elevation: 0,
                  color: Colors.white10,
                  child: SizedBox(
                    height: 76,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ValueListenableBuilder<ProgressBarState>(
                                valueListenable: pageManager.progressNotifier,
                                builder: (context, progressState, child) {
                                  final position = progressState.current;
                                  final totalDuration = progressState.total;
                                  return position == null
                                      ? space0
                                      : (position.inSeconds.toDouble() < 0.0 ||
                                              (position.inSeconds.toDouble() >
                                                  totalDuration.inSeconds
                                                      .toDouble()))
                                          ? space0
                                          : SliderTheme(
                                              data: SliderThemeData(
                                                  activeTrackColor:
                                                      TColor.focus,
                                                  inactiveTrackColor:
                                                      Colors.transparent,
                                                  trackHeight: 3,
                                                  thumbColor: TColor.focus,
                                                  thumbShape:
                                                      const RoundSliderOverlayShape(
                                                          overlayRadius: 1.5),
                                                  overlayColor:
                                                      Colors.transparent,
                                                  overlayShape:
                                                      const RoundSliderOverlayShape(
                                                          overlayRadius: 1.0)),
                                              child: Center(
                                                child: Slider(
                                                  inactiveColor: Colors.transparent,
                                                  max: totalDuration.inSeconds.toDouble(),
                                                  value: position.inSeconds
                                                      .toDouble(),
                                                  onChanged: (value) {
                                                    pageManager.seek(
                                                      Duration(
                                                        seconds: value.round(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                },
                              ),
                              ListTile(
                                dense: false,
                                onTap: () {Get.to(const MainPlayerPage());
                                },
                                title: Text(
                                  mediaItem.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: TColor.primaryText),
                                ),
                                subtitle: Text(
                                  mediaItem.artist ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: TColor.primaryText),
                                ),
                                leading: Hero(
                                  tag: 'currentArtWork',
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: SizedBox.square(
                                      dimension: 40,
                                      child: CachedNetworkImage(
                                        imageUrl: mediaItem.artUri.toString(),
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) {
                                          return Image.asset(
                                            TImage.imgCover,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                trailing: const ControlButtons(
                                  miniPlayer: true,
                                  buttons: ['Play/Pause', 'Next'],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            );
          },
        );
      },
    );
  }
}
