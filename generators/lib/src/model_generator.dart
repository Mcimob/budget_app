import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

import 'package:annotations/annotations.dart';

import 'model_visitor.dart';

class ModelGenerator extends GeneratorForAnnotation<ModelAnnotation> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    final className = '${visitor.className}Gen';
    final classBuffer = StringBuffer();

    classBuffer.writeln('class $className implements Model{');

    classBuffer.write('$className({');
    for (final field in visitor.fields.keys) {
      final variable =
          field.startsWith('_') ? field.replaceFirst('_', '') : field;
      if (!visitor.fields[field].endsWith('?')) {
        classBuffer.write('required ');
      }
      classBuffer.write('this.$variable, ');
    }
    classBuffer.writeln('});');
    for (final field in visitor.fields.keys) {
      classBuffer.writeln('${visitor.fields[field]} $field;');
    }

    classBuffer
        .writeln('factory $className.fromJson(Map<String, dynamic> map) {');
    classBuffer.writeln('return $className (');
    for (final field in visitor.fields.keys) {
      classBuffer.writeln('$field: map["$field"],');
    }
    classBuffer.writeln(');');
    classBuffer.writeln('}');

    classBuffer.writeln('@override');
    classBuffer.writeln('Map<String, dynamic> toMap() {');
    classBuffer.writeln('return {');
    for (final field in visitor.fields.keys) {
      classBuffer.writeln('"$field": $field,');
    }
    classBuffer.writeln('};}');

    classBuffer.writeln('}');
    return classBuffer.toString();
  }
}
