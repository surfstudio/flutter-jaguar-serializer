///@nodoc
library jaguar_serializer.generator.parser;

import 'package:analyzer/dart/element/element.dart';

import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';

import '../helpers/helpers.dart';

part 'field_to.dart';

part 'field_from.dart';

class WriterInfo {
  final String name;

  final String modelName;

  final List<FieldTo> to;

  final List<FieldFrom> from;

  final Map<String, FieldProcessorInfo> processors;

  final List<ParameterElement> ctorArguments;

  final List<ParameterElement> ctorNamedArguments;

  WriterInfo(this.name, this.modelName, this.to, this.from, this.processors,
      this.ctorArguments, this.ctorNamedArguments);

  factory WriterInfo.fromInfo(SerializerInfo info) {
    List<FieldTo> tos = <FieldTo>[];

    final getters = info.model.getters();
    for (Field field in getters) {
      String fieldName = field.name;
      String fieldKey = field.name;

      if (info.to[fieldName] != null) fieldKey = info.to[fieldName];

      tos.add(_parseFieldTo(info, field, fieldKey));
    }

    List<FieldFrom> froms = <FieldFrom>[];

    final List<Field> setters = info.model.setters();
    for (Field field in setters) {
      String fieldKey = field.name;
      if (info.from[fieldKey] != null) fieldKey = info.from[fieldKey];
      froms.add(_parseFieldFrom(info, field, fieldKey));
    }

    final String modelName = info.modelType.name;

    return new WriterInfo(info.name, modelName, tos, froms, info.processors,
        info.model.ctorArguments, info.model.ctorNamedArguments);
  }
}
