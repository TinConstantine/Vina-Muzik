import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:vina_music_app/audio_helpers/audio_handler.dart';
import 'package:vina_music_app/audio_helpers/page_manager.dart';

GetIt getIt = GetIt.instance;
Future<void> setupServiceLocator()async{
  // khoi tao khi app khoi dong
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  // khoi tao vao lan goi dau tien
  getIt.registerLazySingleton<PageManager>(()=> PageManager());

}