import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/model_generator.dart';

Builder generateModel(BuilderOptions options) =>
    SharedPartBuilder([ModelGenerator()], 'model_generator');
