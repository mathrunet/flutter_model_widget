part of flutter_widget_model;

/// You can use the Document only within HookWidget.
///
/// It is possible to specify an initial value by specifying [initialData].
IDataDocument useDocument({Map<String, dynamic> initialData}) {
  return use(_DocumentHook(initialData: initialData));
}

class _DocumentHook extends Hook<TemporaryDocument> {
  final Map<String, dynamic> initialData;
  _DocumentHook({this.initialData});
  @override
  _DocumentHookState createState() => _DocumentHookState();
}

class _DocumentHookState extends HookState<TemporaryDocument, _DocumentHook> {
  TemporaryDocument _document;
  @override
  void initHook() {
    super.initHook();
    if (this.hook.initialData != null) {
      this._document = TemporaryDocument.fromMap(this.hook.initialData);
    } else {
      this._document = TemporaryDocument();
    }
    this._document?.listen(this._listener);
  }

  void _listener(TemporaryDocument state) {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    this._document?.unlisten(this._listener);
    this._document?.dispose();
  }

  @override
  TemporaryDocument build(BuildContext context) {
    return this._document;
  }
}
