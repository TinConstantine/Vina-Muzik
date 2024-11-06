import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:vina_music_app/common/state_helper.dart';
import 'package:vina_music_app/common_widget/playlist_song_row.dart';
import 'package:vina_music_app/page/songs/all_songs_page/all_songs_viewmodel.dart';

import '../../../audio_helpers/page_manager.dart';
import '../../../audio_helpers/service_locator.dart';
import '../../../common/color_extension.dart';
import '../../../common/image.dart';

class PlayPlaylistPage extends StatefulWidget {
  const PlayPlaylistPage({super.key});

  @override
  State<PlayPlaylistPage> createState() => _PlayPlaylistPageState();
}

class _PlayPlaylistPageState extends State<PlayPlaylistPage> {
  final allSongsViewModel = Get.put(AllSongsViewModel());

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Dismissible(
      direction: DismissDirection.down,
      background: const ColoredBox(
        color: Colors.transparent,
      ),
      key: const Key('playlistScreen'),
      onDismissed: (direction) {
        Get.back();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: TColor.bg,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                TImage.imgBack,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              )),
          centerTitle: true,
          title: Text(
            "Playlist",
            style: TextStyle(
                color: TColor.primaryText80,
                fontSize: 17,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            PopupMenuButton(
              offset: const Offset(-10, 15),
              color: TColor.contextMenu,
              elevation: 1,
              icon: Image.asset(
                TImage.imgMoreButton,
                width: 20,
                height: 20,
                color: TColor.primaryText,
              ),
              padding: EdgeInsets.zero,
              onSelected: null,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    height: 32,
                    value: 1,
                    child: Text(
                      'Social Share',
                      style: TextStyle(fontSize: 12, color: TColor.primaryText),
                    ),
                  ),
                  PopupMenuItem(
                    height: 32,
                    value: 2,
                    child: Text(
                      'Playing Queue',
                      style: TextStyle(fontSize: 12, color: TColor.primaryText),
                    ),
                  ),
                  PopupMenuItem(
                    height: 32,
                    value: 3,
                    child: Text(
                      'Add to playlist...',
                      style: TextStyle(fontSize: 12, color: TColor.primaryText),
                    ),
                  ),
                  PopupMenuItem(
                    height: 32,
                    value: 4,
                    child: Text(
                      'Lyrics',
                      style: TextStyle(fontSize: 12, color: TColor.primaryText),
                    ),
                  ),
                  PopupMenuItem(
                    height: 32,
                    value: 5,
                    child: Text(
                      'Volume',
                      style: TextStyle(fontSize: 12, color: TColor.primaryText),
                    ),
                  ),
                  PopupMenuItem(
                    height: 32,
                    value: 6,
                    child: Text(
                      'Details',
                      style: TextStyle(fontSize: 12, color: TColor.primaryText),
                    ),
                  ),
                  PopupMenuItem(
                    height: 32,
                    value: 7,
                    child: Text(
                      'Sleep timer',
                      style: TextStyle(fontSize: 12, color: TColor.primaryText),
                    ),
                  ),
                  PopupMenuItem(
                    height: 32,
                    value: 8,
                    child: Text(
                      'Equalizer',
                      style: TextStyle(fontSize: 12, color: TColor.primaryText),
                    ),
                  ),
                  PopupMenuItem(
                    height: 32,
                    value: 9,
                    child: Text(
                      'Driver mode',
                      style: TextStyle(fontSize: 12, color: TColor.primaryText),
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: ValueListenableBuilder<MediaItem?>(
          valueListenable: pageManager.currentSongNotifier,
          builder: (context, mediaItem, child) {
            if (mediaItem == null) return const SizedBox();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ValueListenableBuilder<bool>(
                        valueListenable: pageManager.isFirstSongNotifier,
                        builder: (context, isFirst, child) {
                          return SizedBox(
                            width: 45,
                            height: 45,
                            child: IconButton(
                              onPressed:
                                  (isFirst) ? null : pageManager.previous,
                              icon: Image.asset(
                                "assets/img/previous_song.png",
                                color: (isFirst)
                                    ? TColor.primaryText35
                                    : TColor.primaryText,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Hero(
                              tag: "currentArtWork",
                              child: ValueListenableBuilder(
                                valueListenable:
                                    pageManager.currentSongNotifier,
                                builder: (context, value, child) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        mediaSize.width * 0.4),
                                    child: CachedNetworkImage(
                                      imageUrl: mediaItem.artUri.toString(),
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) {
                                        return Image.asset(
                                          "assets/img/cover.jpg",
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      placeholder: (context, url) {
                                        return Image.asset(
                                          "assets/img/cover.jpg",
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      width: mediaSize.width * 0.4,
                                      height: mediaSize.width * 0.4,
                                    ),
                                  );
                                },
                              )),
                          ValueListenableBuilder(
                            valueListenable: pageManager.progressNotifier,
                            builder: (context, valueState, child) {
                              double? dragValue;
                              bool dragging = false;

                              final value = min(
                                  valueState.current.inMilliseconds.toDouble(),
                                  valueState.total.inMilliseconds.toDouble());

                              if (dragValue != null && dragging) {
                                dragValue = null;
                              }

                              return SizedBox(
                                width: mediaSize.width * 0.41,
                                height: mediaSize.width * 0.41,
                                child: SleekCircularSlider(
                                  appearance: CircularSliderAppearance(
                                      customWidths: CustomSliderWidths(
                                          trackWidth: 2,
                                          progressBarWidth: 4,
                                          shadowWidth: 6),
                                      customColors: CustomSliderColors(
                                          dotColor: const Color(0xffFFB1B2),
                                          trackColor: const Color(0xffffffff)
                                              .withOpacity(0.3),
                                          progressBarColors: [
                                            const Color(0xffFB9967),
                                            const Color(0xffE9585A)
                                          ],
                                          shadowColor: const Color(0xffFFB1B2),
                                          shadowMaxOpacity: 0.05),
                                      infoProperties: InfoProperties(
                                        topLabelStyle: const TextStyle(
                                            color: Colors.transparent,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                        topLabelText: 'Elapsed',
                                        bottomLabelStyle: const TextStyle(
                                            color: Colors.transparent,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                        bottomLabelText: 'time',
                                        mainLabelStyle: const TextStyle(
                                            color: Colors.transparent,
                                            fontSize: 50.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      startAngle: 270,
                                      angleRange: 360,
                                      size: 350.0),
                                  min: 0,
                                  max: max(
                                      valueState.current.inMilliseconds
                                          .toDouble(),
                                      valueState.total.inMilliseconds
                                          .toDouble()),
                                  initialValue: value,
                                  onChange: (double value) {
                                    if (!dragging) {
                                      dragging = true;
                                    }
                                    setState(() {
                                      dragValue = value;
                                    });

                                    pageManager.seek(
                                      Duration(
                                        milliseconds: value.round(),
                                      ),
                                    );
                                  },
                                  onChangeStart: (double startValue) {},
                                  onChangeEnd: (double endValue) {
                                    pageManager.seek(
                                      Duration(
                                        milliseconds: endValue.round(),
                                      ),
                                    );
                                    dragging = false;
                                  },
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: pageManager.isLastSongNotifier,
                        builder: (context, isLast, child) {
                          return SizedBox(
                            width: 45,
                            height: 45,
                            child: IconButton(
                              onPressed: (isLast) ? null : pageManager.next,
                              icon: Image.asset(
                                "assets/img/next_song.png",
                                color: (isLast)
                                    ? TColor.primaryText35
                                    : TColor.primaryText,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ValueListenableBuilder(
                    valueListenable: pageManager.progressNotifier,
                    builder: (context, valueState, child) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                    .firstMatch('${valueState.current}')
                                    ?.group(1) ??
                                '${valueState.current}',
                            style: TextStyle(
                                color: TColor.secondaryText, fontSize: 12),
                          ),
                          Text(
                            " | ",
                            style: TextStyle(
                                color: TColor.secondaryText, fontSize: 12),
                          ),
                          Text(
                            RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                    .firstMatch('${valueState.total}')
                                    ?.group(1) ??
                                '${valueState.total}',
                            style: TextStyle(
                                color: TColor.secondaryText, fontSize: 12),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    mediaItem.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: TColor.primaryText.withOpacity(0.9),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${mediaItem.artist} • Album - ${mediaItem.album}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: TColor.primaryText80, fontSize: 12),
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: pageManager.playlistNotifier,
                      builder: (context, queue, __) {
                        final int queueStateIndex =
                            pageManager.currentSongNotifier.value == null
                                ? 0
                                : queue.indexOf(
                                    pageManager.currentSongNotifier.value!);

                        final num queuePosition =
                            queue.length - queueStateIndex;

                        return Theme(
                          data: Theme.of(context).copyWith(
                              canvasColor: Colors.transparent,
                              shadowColor: Colors.transparent),
                          child: ReorderableListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              itemCount: queue.length,
                              onReorder: (oldIndex, newIndex) {
                                if (oldIndex < newIndex) {
                                  newIndex--;
                                }
                                pageManager.moveMediaItem(
                                    currentIndex: oldIndex, newIndex: newIndex);
                              },
                              itemBuilder: (context, index) {
                                var sObj = queue[index];

                                return Dismissible(
                                  key: ValueKey(sObj.id),
                                  direction: index == queueStateIndex
                                      ? DismissDirection.none
                                      : DismissDirection.horizontal,
                                  onDismissed: (direction) {
                                    pageManager.removeQueueItemAt(index);
                                  },
                                  child: PlaylistSongRow(
                                    sObj: sObj,
                                    right: (index == queueStateIndex)
                                        ? Icon(
                                            Icons.bar_chart_rounded,
                                            color: TColor.primary,
                                          )
                                        : ReorderableDragStartListener(
                                            key: Key(sObj.id),
                                            enabled: index != queueStateIndex,
                                            index: index,
                                            child: Icon(
                                              Icons.drag_handle_rounded,
                                              color: TColor.primaryText,
                                            ),
                                          ),
                                    onPressed: () {
                                      pageManager.skipToQueueItem(index);
                                      if (pageManager
                                              .playButtonNotifier.value ==
                                          ButtonState.paused) {
                                        pageManager.play();
                                      }
                                    },
                                    onPressedPlay: () {},
                                  ),
                                );
                              }),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget colIconButton(
      {required String title,
      required String image,
      required VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Image.asset(
            image,
            width: 32,
            height: 32,
            color: TColor.primaryText,
          ),
          Text(
            title,
            style: TextStyle(
                color: TColor.secondaryText,
                fontSize: 8,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
