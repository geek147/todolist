import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:todolist/injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
    initializerName: 'build', asExtension: true, preferRelativeImports: false)
Future<void> configureDependencies() => getIt.build();
