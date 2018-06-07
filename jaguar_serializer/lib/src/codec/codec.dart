import '../serializer/repo.dart';

/// Repository that serialize/deserialize using provided Codec.
///
/// Same usage as [SerializerRepo]
abstract class CodecRepo<S> extends SerializerRepo {
  ///@nodoc
  /// use [serialize]
  S encode(dynamic object);

  ///@nodoc
  /// use [deserialize]
  dynamic decode<T>(S object);

  ///@nodoc
  /// use [deserialize]
  T decodeOne<T>(S object);

  ///@nodoc
  /// use [deserialize]
  List<T> decodeList<T>(S object);
}
