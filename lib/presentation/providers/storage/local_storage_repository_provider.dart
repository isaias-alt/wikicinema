import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikicinema/infrastructure/datasources/isar_datasource.dart';
import 'package:wikicinema/infrastructure/repositories/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider<LocalStorageRepositoryImpl>(
  (ref) {
    return LocalStorageRepositoryImpl(
      datasource: IsarDatasource(),
    );
  },
);
