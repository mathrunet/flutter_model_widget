part of flutter_widget_model;

/// Create a data model that treats the data as a document.
///
/// Please inherit and use it.
///
/// ```
/// class TestDocument extends DocumentModel {
///   FutureOr build(ModelContext context) {
///     return DataDocument(context.path);
///   }
/// }
/// ```
///
/// Document is a data structure that works like a Key-Value-Pair [Map].
/// You can specify [IDataField] for Value, and the content of the data is a value such as [String] or [int], but you can get it with the specified type by methods such as [getString].
///
/// You can use the [save] method to save the data you have stored in the document.
abstract class DocumentModel<T extends IDynamicDocument> extends Model<T>
    implements IDynamicDocument {
  final String path;

  @override
  void addListener(T value, Function(dynamic value) listen) {
    if (value is IDataDocument) value.listen(listen);
  }

  @override
  void removeListener(T value, Function(dynamic value) listen) {
    if (value is IDataDocument) value.unlisten(listen);
  }

  /// Get the UID of the document.
  ///
  /// If there is no value in the field, id will be output.
  String get uid => this.getString(Const.uid);

  /// Get time.
  ///
  /// UpdatedTime is output if the field has no value.
  int get time =>
      this.getInt(Const.time, DateTime.now().millisecondsSinceEpoch);

  /// Create a data model that treats the data as a document.
  ///
  /// By specifying [path], you can get data from [PathMap] as well, and you can get the data even outside of the build timing.
  DocumentModel({this.path}) : super();

  /// Get the value corresponding to [key] from the document.
  @override
  dynamic operator [](Object key) {
    T state = this.state;
    if (state == null) return null;
    return state[key];
  }

  /// Pass [value] to [key] in the document.
  @override
  void operator []=(key, value) {
    T state = this.state;
    if (state == null) return;
    state[key] = value;
  }

  /// Save the document data.
  ///
  /// The [data] is the value to be saved in the document. If the data exists in the current document, it will be overwritten.
  ///
  /// The [builder] can handle the document as it is after the data is saved.
  Future save({Map<String, dynamic> data, FutureOr builder(T document)}) async {
    T state = this.state;
    if (state == null) return;
    if (data != null) {
      for (MapEntry<String, dynamic> tmp in data.entries) {
        if (isEmpty(tmp.key) || tmp.value == null) continue;
        state[tmp.key] = tmp.value;
      }
    }
    if (builder != null) await builder(state);
    if (state is IDataDocument) {
      await state.save();
    } else if (state is DocumentModel) {
      await state.save();
    }
  }

  /// Deletes the document data.
  ///
  /// Include and delete documents that have data on the server.
  Future delete() async {
    T state = this.state;
    if (state == null) return;
    if (state is IDataDocument) {
      await state.delete();
    } else if (state is DocumentModel) {
      await state.delete();
    }
  }

  /// Reload the document data.
  Future reload() async {
    T state = this.state;
    if (state == null) return;
    if (state is IDataDocument) {
      await state.reload();
    } else if (state is DocumentModel) {
      await state.reload();
    }
  }

  /// Get the value stored in the document by [key] as [bool].
  ///
  /// You can pass an initial value to [defaultValue] if the data does not exist.
  bool getBool(String key, [bool defaultValue = false]) {
    T state = this.state;
    if (state == null) return defaultValue;
    return state.getBool(key, defaultValue);
  }

  /// Get the value stored in the document by [key] as [int].
  ///
  /// You can pass an initial value to [defaultValue] if the data does not exist.
  int getInt(String key, [int defaultValue = 0]) {
    T state = this.state;
    if (state == null) return defaultValue;
    return state.getInt(key, defaultValue);
  }

  /// Get the value stored in the document by [key] as [double].
  ///
  /// You can pass an initial value to [defaultValue] if the data does not exist.
  double getDouble(String key, [double defaultValue = 0]) {
    T state = this.state;
    if (state == null) return defaultValue;
    return state.getDouble(key, defaultValue);
  }

  /// Get the value stored in the document by [key] as [String].
  ///
  /// You can pass an initial value to [defaultValue] if the data does not exist.
  String getString(String key, [String defaultValue = ""]) {
    T state = this.state;
    if (state == null) return defaultValue;
    return state.getString(key, defaultValue);
  }

  /// Get the value stored in the document by [key] as [List].
  ///
  /// You can pass an initial value to [defaultValue] if the data does not exist.
  List<V> getList<V extends Object>(String key,
      [List<V> defaultValue = const []]) {
    T state = this.state;
    if (state == null) return defaultValue;
    return state.getList<V>(key, defaultValue);
  }

  /// Get the value stored in the document by [key] as [Map].
  ///
  /// You can pass an initial value to [defaultValue] if the data does not exist.
  Map<K, V> getMap<K extends Object, V extends Object>(String key,
      [Map<K, V> defaultValue = const {}]) {
    T state = this.state;
    if (state == null) return defaultValue;
    return state.getMap<K, V>(key, defaultValue);
  }

  /// Remove all data from the document.
  @override
  void clear() {
    T state = this.state;
    if (state == null) return;
    state.clear();
  }

  /// Check if the document contains a key.
  ///
  /// True if key is included.
  ///
  /// [key]: Key to check.
  @override
  bool containsKey(String key) {
    T state = this.state;
    if (state == null) return false;
    return state.containsKey(key);
  }

  /// Get the document key list.
  @override
  Iterable<String> get keys {
    T state = this.state;
    if (state == null) return const <String>[];
    return state.keys;
  }

  /// Get number of documents.
  @override
  int get length {
    T state = this.state;
    if (state == null) return 0;
    return state.length;
  }

  /// Remove data from document.
  ///
  /// [key]: Key to delete.
  @override
  void remove(String key) {
    T state = this.state;
    if (state == null) return;
    state.remove(key);
  }

  /// Remove data from document.
  ///
  /// [keys]: Keys to delete.
  @override
  void removeAll(Iterable<String> keys) {
    T state = this.state;
    if (state == null) return;
    state.removeAll(keys);
  }
}
