part of flutter_widget_model;

/// You can use the Collection only within HookWidget.
///
/// It is possible to specify an initial value by specifying [initialData].
///
/// You can sort by specifying [orderBy], [orderByKey].
/// You can also specify [thenBy] and [thenByKey] to further sort the elements in the same order in the first sort.
IDataCollection useCollection(
    {List<Map<String, dynamic>> initialData,
    OrderBy orderBy = OrderBy.none,
    OrderBy thenBy = OrderBy.none,
    String orderByKey,
    String thenByKey}) {
  return use(_CollectionHook(
      initialData: initialData,
      orderBy: orderBy,
      orderByKey: orderByKey,
      thenBy: thenBy,
      thenByKey: thenByKey));
}

class _CollectionHook extends Hook<TemporaryCollection> {
  final List<Map<String, dynamic>> initialData;
  final OrderBy orderBy;
  final OrderBy thenBy;
  final String orderByKey;
  final String thenByKey;
  _CollectionHook(
      {this.initialData,
      this.orderBy = OrderBy.none,
      this.orderByKey,
      this.thenBy = OrderBy.none,
      this.thenByKey});
  @override
  _CollectionHookState createState() => _CollectionHookState();
}

class _CollectionHookState
    extends HookState<TemporaryCollection, _CollectionHook> {
  TemporaryCollection _collection;
  @override
  void initHook() {
    super.initHook();
    if (this.hook.initialData != null) {
      this._collection = TemporaryCollection.fromList(this.hook.initialData,
          orderBy: this.hook.orderBy,
          orderByKey: this.hook.orderByKey,
          thenBy: this.hook.thenBy,
          thenByKey: this.hook.thenByKey);
    } else {
      this._collection = TemporaryCollection(
          orderBy: this.hook.orderBy,
          orderByKey: this.hook.orderByKey,
          thenBy: this.hook.thenBy,
          thenByKey: this.hook.thenByKey);
    }
    this._collection?.listen(this._listener);
  }

  void _listener(TemporaryCollection state) {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    this._collection?.unlisten(this._listener);
    this._collection?.dispose();
  }

  @override
  TemporaryCollection build(BuildContext context) {
    return this._collection;
  }
}
