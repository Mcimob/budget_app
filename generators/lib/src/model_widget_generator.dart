import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

import 'package:annotations/annotations.dart';

import 'model_visitor.dart';

class ModelWidgetGenerator
    extends GeneratorForAnnotation<ModelWidgetAnnotation> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    final classString = '''

class ${visitor.className}GenWidget extends StatefulWidget {
  final ${visitor.className}Gen item;
  final ValueChanged<Model> delete;
  ${visitor.className}GenWidget({Key? key, required this.item, required this.delete})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ${visitor.className}GenWidgetState();
  }
}

class ${visitor.className}GenWidgetState extends State<${visitor.className}GenWidget> {
  final titleController = TextEditingController();
  bool inEditMode = false;
  Icon? _icon;

  @override
  initState() {
    _icon = Icon(
        IconData(widget.item.iconId, fontFamily: widget.item.iconFontFamily));
    titleController.value = TextEditingValue(text: widget.item.title);
    inEditMode = widget.item.lastState == 1 ? true : false;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  _edit${visitor.className}() {
    setState(() {
      inEditMode = !inEditMode;
    });
  }

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);
    _icon = Icon(icon);
    debugPrint("icon selected");
    _save();
  }

  _delete() async {
    widget.delete(widget.item);
  }

  _cancel() {}

  _save() async {
    widget.item.title = titleController.text;
    widget.item.iconId = _icon!.icon!.codePoint;
    widget.item.iconFontFamily = _icon!.icon!.fontFamily!;
    widget.item.lastState = inEditMode ? 1 : 0;
    await DatabaseRepository.instance.update(o: widget.item);
  }

  _save_and_close() async {
    _edit${visitor.className}();
    await _save();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.1)),
      child: inEditMode ? getEditMode() : getViewMode(),
    );
  }

  Row getViewMode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.item.title),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(IconData(widget.item.iconId,
                fontFamily: widget.item.iconFontFamily)),
            IconButton(onPressed: _edit${visitor.className}, icon: Icon(Icons.edit)),
          ],
        )
      ],
    );
  }

  Widget getEditMode() {
    return ValueListenableBuilder(
        valueListenable: titleController,
        builder: (context, TextEditingValue value, __) {
          return Row(children: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _save_and_close,
            ),
            Flexible(
              child: TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  label: Text('${visitor.className} Title'),
                  hintText: 'Think of some descriptive title',
                  errorText: TextInputMethods.errorText(titleController),
                ),
              ),
            ),
            IconButton(
              icon: _icon!,
              onPressed: _pickIcon,
            ),
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: _edit${visitor.className},
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _delete,
            ),
          ]);
        });
  }
}

    ''';

    return classString;
  }
}
