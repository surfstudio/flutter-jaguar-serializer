import 'package:collection/collection.dart';
import 'package:jaguar_serializer/jaguar_serializer.dart';

part 'simple.jser.dart';

@GenSerializer(
    fields: const {'boolF': const Field<bool>(isNullable: false)})
class SimpleSerializer extends Serializer<Simple> with _$SimpleSerializer {}

@GenSerializer(ignore: const ['boolF'])
class SimpleSerializerIgnore extends Serializer<Simple>
    with _$SimpleSerializerIgnore {}

@GenSerializer(ignore: const ['boolF', 'intF', 'listF'])
class SimpleSerializerIgnores extends Serializer<Simple>
    with _$SimpleSerializerIgnores {}

@GenSerializer(fields: const {
  'stringF': const EnDecode<String>(alias: 'S'),
  'doubleF': const EncodeOnly<int>(alias: 'D'),
  'boolF': const EnDecode<bool>(alias: 'B'),
})
class SimpleSerializerRename extends Serializer<Simple>
    with _$SimpleSerializerRename {}

@GenSerializer(fields: const {
  'stringF': const EnDecode<String>(),
  'intF': const EncodeOnly<int>(),
}, includeByDefault: false)
class SimpleSerializerExcludeDef extends Serializer<Simple>
    with _$SimpleSerializerExcludeDef {}

@GenSerializer(fields: const {
  'stringF': const Field<String>(defaultsTo: 'Lejard'),
  'intF': const Field<int>(defaultsTo: 25),
  'doubleF': const Field<double>(defaultsTo: 100.0),
  'boolF': const Field<bool>(defaultsTo: true),
  'listF': const Field<List<String>>(valueFromConstructor: true),
  'mapF': const Field<Map<String, int>>(valueFromConstructor: true)
})
class SimpleSerializerWithDefaults extends Serializer<Simple>
    with _$SimpleSerializerWithDefaults {}

/// A simple model with various built-in typed fields
class Simple {
  String stringF;

  int intF;

  double doubleF;

  bool boolF;

  List<String> listF;

  Map<String, int> mapF;

  Simple({this.listF: const [], this.mapF: const {}});

  Simple.make(
      {this.stringF,
      this.intF,
      this.doubleF,
      this.boolF,
      this.listF: const [],
      this.mapF: const {}});

  bool operator ==(final other) {
    if (other is Simple)
      return stringF == other.stringF &&
          intF == other.intF &&
          doubleF == other.doubleF &&
          boolF == other.boolF &&
          new IterableEquality().equals(listF, other.listF) &&
          new MapEquality().equals(mapF, other.mapF);
    return false;
  }

  String toString() => new SimpleSerializer().toMap(this).toString();
}
