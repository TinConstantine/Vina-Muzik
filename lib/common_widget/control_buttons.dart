import 'package:flutter/material.dart';
import 'package:vina_music_app/audio_helpers/page_manager.dart';
import 'package:vina_music_app/common/image.dart';

import '../audio_helpers/service_locator.dart';
import '../common/color_extension.dart';

class ControlButtons extends StatelessWidget {
  final bool shuffle;
  final bool miniPlayer;
  final List buttons;

  const ControlButtons(
      {super.key,
      this.shuffle = false,
      this.miniPlayer = false,
      this.buttons = const ['Previous', 'Play/Pause', 'Next']});

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: buttons.map((e) {
        switch (e) {
          case 'Previous':
            return ValueListenableBuilder<bool>(
              valueListenable: pageManager.isFirstSongNotifier,
              builder: (context, isFirst, child) {
                return IconButton(
                  onPressed: isFirst ? null : pageManager.previous,
                  icon: Image.asset(
                    TImage.imgPreviousSong,
                    fit: BoxFit.cover,
                    width: miniPlayer ? 20 : 50,
                    height: miniPlayer ? 20 : 50,
                  ),
                );
              },
            );
          case 'Next':
            return ValueListenableBuilder<bool>(
              valueListenable: pageManager.isLastSongNotifier,
              builder: (context, isLast, child) {
                return IconButton(
                  onPressed: isLast
                      ? null
                      : pageManager.next,
                  icon: Image.asset(
                    TImage.imgNextSong,
                    fit: BoxFit.cover,
                    width: miniPlayer ? 20 : 50,
                    height: miniPlayer ? 20 : 50,
                  ),
                );
              },
            );
          case 'Play/Pause':
            return SizedBox(
              width: miniPlayer ? 40 : 70,
              height: miniPlayer ? 40 : 70,
              child: ValueListenableBuilder<ButtonState>(
                valueListenable: pageManager.playButtonNotifier,
                builder: (context, buttonState, child) {
                  return Stack(
                    children: [
                      if (buttonState == ButtonState.loading)
                        Center(
                          child: SizedBox(
                            width: miniPlayer ? 40 : 70,
                            height: miniPlayer ? 40 : 70,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  TColor.primaryText),
                            ),
                          ),
                        ),
                      if (miniPlayer)
                        Center(
                          child: buttonState == ButtonState.playing
                              ? IconButton(
                                  onPressed: pageManager.pause,
                                  icon:  Icon(
                                    Icons.pause_rounded,
                                    size: 20,
                                    color: TColor.primaryText,
                                  ),
                                )
                              : IconButton(
                                  onPressed: pageManager.play,
                                  icon: Image.asset(
                                    TImage.imgPlay,
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        )
                      else
                        Center(
                          child: buttonState == ButtonState.playing
                              ? IconButton(
                                  onPressed: pageManager.pause,
                                  icon:  Icon(
                                    Icons.pause_rounded,
                                    size: 50,
                                    color: TColor.primaryText,
                                  ),
                                )
                              : IconButton(
                                  onPressed: pageManager.play,
                                  icon: Image.asset(
                                    TImage.imgPlay,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                    ],
                  );
                },
              ),
            );
          default:
            return Container();
        }
      }).toList(),
    );
  }
}
