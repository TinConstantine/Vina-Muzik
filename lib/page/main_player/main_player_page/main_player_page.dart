import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:vina_music_app/audio_helpers/page_manager.dart';
import 'package:vina_music_app/common/state_helper.dart';
import 'package:vina_music_app/page/main_player/driver_mode_page/driver_mode_page.dart';
import 'package:vina_music_app/page/main_player/play_playlist_page/play_playlist_page.dart';
import 'package:vina_music_app/page/songs/playlists_page/playlists_page.dart';

import '../../../audio_helpers/service_locator.dart';
import '../../../common/color_extension.dart';
import '../../../common/image.dart';

class MainPlayerPage extends StatefulWidget {
  const MainPlayerPage({super.key});

  @override
  State<MainPlayerPage> createState() => _MainPlayerPageState();
}

class _MainPlayerPageState extends State<MainPlayerPage> {
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Dismissible(
      direction: DismissDirection.down,
      background: const ColoredBox(
        color: Colors.transparent,
      ),
      key: const Key('playScreen'),
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
            "Now Playing",
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
              onSelected: (value) {
                switch (value) {
                  case 0:
                    break;
                  case 1:
                    break;
                  case 2:
                    Get.to(()=> const PlaylistsPage());
                    break;
                  case 3:
                    break;
                  case 4:
                    break;
                  case 5:
                    break;
                  case 6:
                    break;
                  case 7:
                    break;
                  case 8:
                    break;
                  case 9:
                    Get.to(() => const DriverModePage());
                    break;
                }
              },
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
            if(mediaItem == null) return space0;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    space20,
                    // Stack(
                    //   alignment: Alignment.center,
                    //   children: [
                    //     Hero(
                    //       tag: 'currentArtWidget',
                    //       child: ValueListenableBuilder<ProgressBarState>(
                    //         valueListenable: pageManager.progressNotifier,
                    //         builder: (BuildContext context, progressBarState, Widget? child) {
                    //           return ClipRRect(
                    //             borderRadius: BorderRadius.circular(200),
                    //             child: CachedNetworkImage(
                    //               imageUrl: mediaItem.artUri.toString(),
                    //               width: mediaSize.width * 0.6,
                    //               height: mediaSize.width * 0.6,
                    //               fit: BoxFit.cover,
                    //               // errorWidget: (context, url, error) {
                    //               //   return Image.asset(TImage.imgCover, fit: BoxFit.cover,);
                    //               // },
                    //               // placeholder: (context, url) {
                    //               //   return Image.asset(TImage.imgCover, fit: BoxFit.cover,);
                    //               // },
                    //             ),
                    //           );
                    //         }
                    //       ),
                    //     ),
                    //     ValueListenableBuilder<ProgressBarState>(
                    //       valueListenable: pageManager.progressNotifier,
                    //       builder: (BuildContext context,  progressBarState, Widget? child) {
                    //         double? dragValue;
                    //         bool dragging = false;
                    //         final value = min(progressBarState.current.inMilliseconds.toDouble(), progressBarState.total.inMilliseconds.toDouble());
                    //         if(dragValue != null && dragging){dragValue = null;
                    //         }
                    //       return SizedBox(
                    //         width: mediaSize.width * 0.61,
                    //         height: mediaSize.width * 0.61,
                    //         child: SleekCircularSlider(
                    //           min: 0,
                    //           max: progressBarState.total.inMilliseconds.toDouble(),
                    //           initialValue: progressBarState.current.inMilliseconds.toDouble(),
                    //           appearance: CircularSliderAppearance(
                    //             customWidths: CustomSliderWidths(
                    //                 trackWidth: 4,
                    //                 progressBarWidth: 6,
                    //                 shadowWidth: 8),
                    //             customColors: CustomSliderColors(
                    //                 dotColor: TColor.dotColor,
                    //                 trackColor: TColor.primaryText.withOpacity(0.3),
                    //                 progressBarColors: [
                    //                   TColor.progressBarColor,
                    //                   TColor.trackColor
                    //                 ],
                    //                 shadowColor: TColor.dotColor,
                    //                 shadowMaxOpacity: 0.05),
                    //             infoProperties: InfoProperties(
                    //                 topLabelStyle: const TextStyle(
                    //                     color: Colors.transparent,
                    //                     fontSize: 16,
                    //                     fontWeight: FontWeight.w400),
                    //                 topLabelText: 'Elapsed',
                    //                 bottomLabelStyle: const TextStyle(
                    //                     color: Colors.transparent,
                    //                     fontSize: 16,
                    //                     fontWeight: FontWeight.w400),
                    //                 bottomLabelText: 'time',
                    //                 mainLabelStyle: const TextStyle(
                    //                     color: Colors.transparent,
                    //                     fontSize: 50,
                    //                     fontWeight: FontWeight.w600)),
                    //             startAngle: 270,
                    //             angleRange: 360,
                    //             size: 350,
                    //           ),
                    //           onChange: (value) {
                    //                 if(!dragging){
                    //                   dragging = true;
                    //                 }
                    //                 setState(() {
                    //                   dragValue = value;
                    //                 });
                    //                 pageManager.seek(Duration(milliseconds: value.round(),),);
                    //           },
                    //           onChangeEnd: (value) {
                    //             pageManager.seek(Duration(milliseconds: value.round(),),);
                    //             dragging = false;
                    //           },
                    //           onChangeStart: (value) {
                    //             // pageManager.seek(Duration(milliseconds: value.round(),),);
                    //           },
                    //         ),
                    //       );
                    //       }
                    //     ),
                    //   ],
                    // ),
                    space12,
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

                    space24,
                    Text(
                      mediaItem.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: TColor.primaryText.withOpacity(0.9),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    space8,
                    Text(
                      mediaItem.artist.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: TColor.secondaryText,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                    space20,
                    Image.asset(
                      TImage.imgEqDisplay,
                      height: 60,
                      fit: BoxFit.fitHeight,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Divider(
                        color: Colors.white12,
                        height: 1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      ValueListenableBuilder(valueListenable: pageManager.isFirstSongNotifier, builder: (context, isFirstSong, child) {
                        return IconButton(
                          onPressed: isFirstSong ? null : pageManager.previous,
                          icon: Image.asset(
                            TImage.imgPreviousSong,
                            width: 44,
                            height: 44,
                            color: isFirstSong ? TColor.primaryText35 : TColor.primaryText,
                          ),
                        );
                      },),
                        space16,
                       ValueListenableBuilder<ButtonState>(valueListenable: pageManager.playButtonNotifier, builder: (context, value, child) {
                         return  SizedBox(
                           width: 75,
                           height: 75,
                           child: Stack(
                             alignment: Alignment.center,
                             children: [
                               if (value == ButtonState.loading)
                                 SizedBox(
                                   width: 75,
                                   height: 75,
                                   child: CircularProgressIndicator(
                                     valueColor:
                                     AlwaysStoppedAnimation<Color>(
                                         TColor.primaryText),
                                   ),
                                 ),
                               SizedBox(
                                 width: 60,
                                 height: 60,
                                 child: value == ButtonState.playing
                                     ? InkWell(
                                   onTap: pageManager.pause,
                                   child: Image.asset(
                                     "assets/img/pause.png",
                                     width: 60,
                                     height: 60,
                                   ),
                                 )
                                     : InkWell(
                                   onTap: pageManager.play,
                                   child: Image.asset(
                                     "assets/img/play.png",
                                     width: 60,
                                     height: 60,
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         );
                       },),
                        space16,
                       ValueListenableBuilder(valueListenable: pageManager.isLastSongNotifier, builder: (context, isLastSong, child) {
                         return  IconButton(
                           onPressed: isLastSong ? null : pageManager.next,
                           icon: Image.asset(
                             TImage.imgNextSong,
                             width: 44,
                             height: 44,
                           ),
                           color: isLastSong ? TColor.primaryText35 : TColor.primaryText,
                         );
                       },)
                      ],
                    ),
                    space24,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        colIconButton(
                            title: "Playlist",
                            image: TImage.imgPlaylist,
                            onPressed: () {
                              Get.to(() => const PlayPlaylistPage());
                            }),
                        space32,
                        colIconButton(
                            title: "Shuffle",
                            image: TImage.imgShuffle,
                            onPressed: () {}),
                        space32,
                        colIconButton(
                            title: "Repeat",
                            image: TImage.imgRepeat,
                            onPressed: () {}),
                        space32,
                        colIconButton(
                            title: "EQ", image: TImage.imgEq, onPressed: () {}),
                        space32,
                        colIconButton(
                            title: "Favourites",
                            image: TImage.imgFav,
                            onPressed: () {}),
                      ],
                    ),
                  ],
                ),
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
