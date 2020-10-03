part of flutter_widget_model;

/// Data model with a data structure for collections on runtime.
///
/// The contents of the collection store data documents and so on, including data that sequentially reads the stored data list as it is stored.
///
/// ```
///
/// Widget build(BuildContext context) {
///   return Scaffold(
///     appBar: AppBar(
///       title: Text("Title"),
///     ),
///     body: ListView(
///       children: DataCollectionModel("user").map(
///         (item) => ListTile(
///           title: Text(
///             item.getString("uid")
///           ),
///         ),
///       ),
///     ),
///     floatingActionButton: FloatingActionButton(
///       onPressed: () {
///         DataCollectionModel("user").append(
///           builder: (doc) {
///             doc["uid"] = Texts.uuid;
///           },
///         );
///       },
///       child: Icon(Icons.add),
///     ),
///   );
/// }
/// ```
@immutable
class RuntimeCollectionModel extends CollectionModel<RuntimeCollection> {
  final List<Map<String, dynamic>> data;

  /// Data model with a data structure for collections on runtime.
  ///
  /// The contents of the collection store data documents and so on, including data that sequentially reads the stored data list as it is stored.
  ///
  /// Defines the data document of the specified [path].
  ///
  /// If [data] is specified, [data] will be set to the specified [path].
  const RuntimeCollectionModel(String path,
      {this.data,
      OrderBy orderBy = OrderBy.none,
      String orderByKey,
      OrderBy thenBy = OrderBy.none,
      String thenByKey})
      : super(
            path: path,
            orderBy: orderBy,
            orderByKey: orderByKey,
            thenBy: thenBy,
            thenByKey: thenByKey);
  @override
  RuntimeCollection build(ModelContext context) {
    if (this.data == null) return RuntimeCollection(this.path);
    return RuntimeCollection.fromList(
      this.path,
      this.data,
      orderBy: this.orderBy,
      thenBy: this.thenBy,
      orderByKey: this.orderByKey,
      thenByKey: this.thenByKey,
    );
  }

  /// Add a new document to the collection.
  ///
  /// Documents added to the collection are stored in the path specified by [id] (or UUID).
  ///
  /// You can define the initial values of a document by specifying [data] and edit the internal data with the [builder].
  Future append(
      {String id,
      Map<String, dynamic> data,
      FutureOr builder(RuntimeDocument document)}) async {
    String path = Paths.child(this.path, id ?? Texts.uuid);
    RuntimeDocument state = RuntimeDocument(path);
    if (data != null) {
      for (MapEntry<String, dynamic> tmp in data.entries) {
        if (isEmpty(tmp.key) || tmp.value == null) continue;
        state[tmp.key] = tmp.value;
      }
    }
    if (builder != null) await builder(state);
    await state.save();
  }
}
