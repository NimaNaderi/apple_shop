import 'package:dartz/dartz.dart';

import '../params/params.dart';

abstract class UseCase<T> {
  Future<Either<String,T>> call(Params? params);
}
