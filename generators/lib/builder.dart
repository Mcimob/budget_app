import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/model_generator.dart';
import 'src/model_widget_generator.dart';

Builder generateModel(BuilderOptions options) =>
    SharedPartBuilder([ModelGenerator()], 'model_generator');

Builder generateModelWidget(BuilderOptions options) =>
    SharedPartBuilder([ModelWidgetGenerator()], 'model_widget_generator');
