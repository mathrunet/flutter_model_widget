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
@immutable
abstract class DocumentModel<TDocument extends IDataDocument>
    extends Model<TDocument>
    with PathModelMixin<TDocument>, ClonableModelMixin<TDocument>
    implements IDataDocument {
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
  const DocumentModel(String path) : super(path);

  /// Get the value corresponding to [key] from the document.
  dynamic operator [](Object key) {
    TDocument state = this.state;
    if (state == null) return null;
    return state[key];
  }

  /// Pass [value] to [key] in the document.
  void operator []=(key, value) {
    TDocument state = this.state;
    if (state == null) return;
    state[key] = value;
  }

  /// Save the document data.
  ///
  /// The [data] is the value to be saved in the document. If the data exists in the current document, it will be overwritten.
  ///
  /// The [builder] can handle the document as it is after the data is saved.
  Future<T> save<T extends IDataDocument>() {
    TDocument state = this.state;
    if (state == null) return Future.delayed(Duration.zero);
    return state.save<T>();
  }

  /// Deletes the document data.
  ///
  /// Include and delete documents that have data on the server.
  Future delete() async {
    TDocument state = this.state;
    if (state == null) return;
    if (state is IDataDocument) {
      await state.delete();
    } else if (state is DocumentModel) {
      await state.delete();
    }
  }

  /// Reload the document data.
  Future<T> reload<T extends IDataDocument>() {
    TDocument state = this.state;
    if (state == null) return Future.delayed(Duration.zero);
    return state.reload<T>();
  }

  /// Get the value stored in the document by [key] as [bool].
  ///
  /// You can pass an initial value to [defaultValue] if the data does not exist.
  bool getBool(String key, [bool defaultValue = false]) {
    TDocument state = this.state;
    if (state == null) return defaultValue;
    return state.getBool(key, defaultValue);
  }

  /// Get the value stored in the document by [key] as [int].
  ///
  /// You can pass an initial value to [defaultValue] if the data does not exist.
  int getInt(String key, [int defaultValue = 0]) {
    TDocument state = this.state;
    if (state == null) return defaultValue;
    return state.getInt(key, defaultValue);
  }

  /// Get the value stored in the document by [key] as [double].
  ///
  /// You can pass an initial value to [defaultValue] if the data does not exist.
  double getDouble(String key, [double defaultValue = 0]) {
    TDocument state = this.state;
    if (state == null) return defaultValue;
    return state.getDouble(key, defaultValue);
  }

  /// Get the value stored in the document by [key] as [String].
  ///
  /// You can pass an initial value to [defaultValue] if the data does not exist.
  String getString(String key, [String defaultValue = ""]) {
    TDocument state = this.state;
    if (state == null) return defaultValue;
    return state.getString(key, defaultValue);
  }

  /// Get the value stored in the document by [key] as [List].
  ///
  /// You can pass an initial value to [defaultValue] if the data does not exist.
  List<V> getList<V extends Object>(String key,
      [List<V> defaultValue = const []]) {
    TDocument state = this.state;
    if (state == null) return defaultValue;
    return state.getList<V>(key, defaultValue);
  }

  /// Get the value stored in the document by [key] as [Map].
  ///
  /// You can pass an initial value to [defaultValue] if the data does not exist.
  Map<K, V> getMap<K extends Object, V extends Object>(String key,
      [Map<K, V> defaultValue = const {}]) {
    TDocument state = this.state;
    if (state == null) return defaultValue;
    return state.getMap<K, V>(key, defaultValue);
  }

  /// Remove all data from the document.
  void clear() {
    TDocument state = this.state;
    if (state == null) return;
    state.clear();
  }

  /// Check if the document contains a key.
  ///
  /// True if key is included.
  ///
  /// [key]: Key to check.
  bool containsKey(String key) {
    TDocument state = this.state;
    if (state == null) return false;
    return state.containsKey(key);
  }

  /// Get the document key list.
  @override
  Iterable<String> get keys {
    TDocument state = this.state;
    if (state == null) return const <String>[];
    return state.keys;
  }

  @override
  Iterable<IDataField> get values {
    TDocument state = this.state;
    if (state == null) return <IDataField>[];
    return state.values;
  }

  /// Get number of documents.
  int get length {
    TDocument state = this.state;
    if (state == null) return 0;
    return state.length;
  }

  /// Remove data from document.
  ///
  /// [key]: Key to delete.
  void remove(String key) {
    TDocument state = this.state;
    if (state == null) return;
    state.remove(key);
  }

  /// Remove data from document.
  ///
  /// [keys]: Keys to delete.
  void removeAll(Iterable<String> keys) {
    TDocument state = this.state;
    if (state == null) return;
    state.removeAll(keys);
  }

  @override
  void add(IDataField child) {
    TDocument state = this.state;
    if (state == null) return;
    state.add(child);
  }

  @override
  void addAll(Iterable<IDataField> children) {
    TDocument state = this.state;
    if (state == null) return;
    state.addAll(children);
  }

  @override
  @protected
  SortedMap<String, IDataField> get data {
    TDocument state = this.state;
    if (state == null) return null;
    return state.data;
  }

  @override
  T debug<T extends IDebuggable>([Object value]) {
    TDocument state = this.state;
    if (state == null) return null;
    return state.debug(value);
  }

  @override
  Iterable<MapEntry<String, IDataField>> get entries {
    TDocument state = this.state;
    if (state == null) return <MapEntry<String, IDataField>>[];
    return state.entries;
  }

  @override
  void forEach(void Function(String key, IDataField value) function) {
    TDocument state = this.state;
    if (state == null) return;
    return state.forEach(function);
  }

  @override
  bool get isLock {
    TDocument state = this.state;
    if (state == null) return null;
    return state.isLock;
  }

  @override
  void removeWhere(bool Function(String key, IDataField child) predicate) {
    TDocument state = this.state;
    if (state == null) return;
    state.removeWhere(predicate);
  }

  @override
  @protected
  void set(Iterable<IDataField> children) {
    TDocument state = this.state;
    if (state == null) return;
    state.set(children);
  }

  @override
  @protected
  void setInternal(IDataField value) {
    TDocument state = this.state;
    if (state == null) return;
    state.setInternal(value);
  }

  @override
  Map<String, dynamic> toJson() {
    TDocument state = this.state;
    if (state == null) return <String, dynamic>{};
    return state.toJson();
  }

  @override
  void unsetInternal(IDataField value) {
    TDocument state = this.state;
    if (state == null) return;
    state.unsetInternal(value);
  }
}
