import 'package:budget_app/reflector.dart';
import 'package:budget_app/widgets/default_widget.dart';
import 'package:reflectable/mirrors.dart';
import 'package:reflectable/reflectable.dart';
import 'package:budget_app/db.dart';
import 'package:budget_app/models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:budget_app/app_const.dart';

class AddTemplate<T extends Model> extends StatefulWidget {
  AddTemplate({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddTemplateState<T>();
  }
}

@reflector
class AddTemplateState<T extends Model> extends State<AddTemplate> {
  final titleController = TextEditingController();
  List<T> items = [];
  bool _submitted = false;
  ClassMirror classMirror = reflector.reflectType(T) as ClassMirror;
  ClassMirror classWidgetMirror = reflector
      .reflectType(AppConst.add_page_dict[T] ?? DefaultWidget) as ClassMirror;

  void _submit() {
    setState(() => _submitted = true);
  }

  @override
  initState() {
    initDb();
    getAll();
    super.initState();
  }

  void initDb() async {
    await DatabaseRepository.instance.database;
  }

  void getAll() async {
    await DatabaseRepository.instance.getAllOfType<T>().then((value) {
      setState(() {
        items = value as List<T>;
      });
    });
  }

  void addCategory() async {
    T item = classMirror.newInstance("", [titleController.text]) as T;
    if (titleController.text.isEmpty) {}
    FocusScope.of(context).requestFocus(new FocusNode());
    await DatabaseRepository.instance.insert(o: item);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Adding ${AppConst.type_to_name[T]} "${titleController.text}"')));
    titleController.text = "";
    getAll();
  }

  String? get _errorText {
    final text = titleController.text;
    if (text.isEmpty) {
      return 'Title can\'t be empty';
    }
    return null;
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);
    _icon = Icon(icon);
    setState(() {});
    debugPrint("icon selected");
  }

  final double _paddingWidth = 16;

  Icon? _icon = Icon(IconData(0xe25a, fontFamily: 'MaterialIcons'));

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: titleController,
      builder: (context, TextEditingValue value, __) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        label: Text('${AppConst.type_to_name[T]} Title'),
                        hintText: 'Think of some descriptive title',
                        errorText: _submitted ? _errorText : null,
                        suffixIcon: IconButton(
                          icon: _icon ?? Container(),
                          onPressed: _pickIcon,
                        ),
                      ),
                    ),
                    MaterialButton(
                      color: Colors.black,
                      height: 50,
                      minWidth: double.infinity,
                      onPressed: _errorText == null ? addCategory : null,
                      child: Text(
                        'Add ${AppConst.type_to_name[T]}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: _paddingWidth),
                        child: Text(
                          (AppConst.table_name_dict[T] ?? "Default")
                              .toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                    padding: EdgeInsets.all(_paddingWidth),
                    itemBuilder: (context, index) {
                      return classWidgetMirror.newInstance(
                          '', [], {Symbol("item"): items[index]}) as Widget;
                    },
                    itemCount: items.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
