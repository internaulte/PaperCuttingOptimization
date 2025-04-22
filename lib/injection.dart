import 'package:get_it/get_it.dart';

import 'data/repositories_impl/calculate_optimal_cutting_impl.dart';
import 'domain/usecases/calculate_optimal_cutting.dart';

final GetIt di = GetIt.instance;

void setupDependencies() {
  // Register the implementation for the domain use case
  di.registerLazySingleton<CalculateOptimalCutting>(
    () => CalculateOptimalCuttingImpl(),
  );
}
