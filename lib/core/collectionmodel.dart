part of flutter_widget_model;

/// Create a data model that treats the data as a collection.
///
/// Please inherit and use it.
///
/// ```
/// class TestDocument extends DocumentModel {
///   FutureOr build(ModelContext context) {
///     return CollectionDocument(context.path);
///   }
/// }
/// ```
///
/// Collections have an ordered array of data structures, such as [List].
/// Basically, you can use [for] statements and various [Iterable] methods to retrieve data.
///
/// In the [build] method of a widget, you can use [map] or [expand] in combination with [ListView], [Column], [Row] and other widgets to create a more visible structure.
@immutable
abstract class CollectionModel<TCollection extends IDataCollection>
    extends Model<TCollection>
    with
        IterableMixin<IDataDocument>,
        PathModelMixin<TCollection>,
        ClonableModelMixin<TCollection>
    implements IDataCollection {
  final OrderBy orderBy;
  final OrderBy thenBy;
  final String orderByKey;
  final String thenByKey;

  /// Create a data model that treats the data as a collection.
  ///
  /// By specifying [path], you can get data from [PathMap] as well, and you can get the data even outside of the build timing.
  ///
  /// You can sort by specifying [orderBy], [orderByKey].
  /// You can also specify [thenBy] and [thenByKey] to further sort the elements in the same order in the first sort.
  CollectionModel(String path,
      {this.orderBy = OrderBy.none,
      this.orderByKey,
      this.thenBy = OrderBy.none,
      this.thenByKey})
      : super(path);

  /// Get the iterator of the collection.
  @override
  Iterator<IDataDocument> get iterator =>
      this.state?.iterator ?? <IDataDocument>[].iterator;

  /// Removes documents from the collection that are located at the specified [key].
  ///
  /// Include and delete documents that have data on the server.
  Future delete(Object key) async {
    TCollection state = this.state;
    if (state == null) return;
    if (state is IDataCollection) {
      await state[key]?.delete();
    } else if (state is CollectionModel) {
      await state.delete(key);
    }
  }

  /// Reload the collection data.
  Future<T> reload<T extends IDataCollection>() {
    TCollection state = this.state;
    if (state == null) return Future.delayed(Duration.zero);
    return state.reload<T>();
  }

  /// Load the following data.
  Future<T> next<T extends IDataCollection>() {
    TCollection state = this.state;
    if (state == null) return Future.delayed(Duration.zero);
    return state.next<T>();
  }

  /// True if the following data is available.
  bool canNext() {
    TCollection state = this.state;
    if (state == null) return false;
    if (state is IDataCollection) {
      return state.canNext();
    } else if (state is CollectionModel) {
      return state.canNext();
    }
    return false;
  }

  @override
  IDataCollection operator +(IDataDocument<IDataField> value) {
    TCollection state = this.state;
    if (state == null) return null;
    state.add(value);
    return state;
  }

  @override
  IDataCollection operator -(IDataDocument<IDataField> value) {
    TCollection state = this.state;
    if (state == null) return null;
    state.remove(value);
    return state;
  }

  @override
  IDataDocument operator [](Object key) {
    TCollection state = this.state;
    if (state == null) return null;
    return state[key];
  }

  @override
  void add(IDataDocument child) {
    TCollection state = this.state;
    if (state == null) return;
    state.add(child);
  }

  @override
  void addAll(Iterable<IDataDocument> children) {
    TCollection state = this.state;
    if (state == null) return;
    state.addAll(children);
  }

  @override
  void clear() {
    TCollection state = this.state;
    if (state == null) return;
    state.clear();
  }

  @override
  bool containsID(String id) {
    TCollection state = this.state;
    if (state == null) return false;
    return state.containsID(id);
  }

  @override
  bool containsPath(String path) {
    TCollection state = this.state;
    if (state == null) return false;
    return state.containsPath(path);
  }

  @override
  @protected
  SortedMap<String, IDataDocument> get data {
    TCollection state = this.state;
    if (state == null) return null;
    return state.data;
  }

  @override
  T debug<T extends IDebuggable>([Object value]) {
    TCollection state = this.state;
    if (state == null) return null;
    return state.debug(value);
  }

  @override
  bool get isLock {
    TCollection state = this.state;
    if (state == null) return null;
    return state.isLock;
  }

  @override
  void remove(IDataDocument child) {
    TCollection state = this.state;
    if (state == null) return;
    state.remove(child);
  }

  @override
  void removeAll(Iterable<IDataDocument<IDataField>> children) {
    TCollection state = this.state;
    if (state == null) return;
    state.removeAll(children);
  }

  @override
  void removeAt(int index) {
    TCollection state = this.state;
    if (state == null) return;
    state.removeAt(index);
  }

  @override
  void removeBy(String key) {
    TCollection state = this.state;
    if (state == null) return;
    state.removeBy(key);
  }

  @override
  void removeWhere(bool Function(IDataDocument child) predicate) {
    TCollection state = this.state;
    if (state == null) return;
    state.removeWhere(predicate);
  }

  @override
  @protected
  void set(Iterable<IDataDocument> children) {
    TCollection state = this.state;
    if (state == null) return;
    state.set(children);
  }

  @override
  @protected
  void setInternal(IDataDocument value) {
    TCollection state = this.state;
    if (state == null) return;
    state.setInternal(value);
  }

  @override
  void sort() {
    TCollection state = this.state;
    if (state == null) return;
    state.sort();
  }

  @override
  Map<String, dynamic> toJson() {
    TCollection state = this.state;
    if (state == null) return <String, dynamic>{};
    return state.toJson();
  }

  @override
  void unsetInternal(IDataDocument value) {
    TCollection state = this.state;
    if (state == null) return;
    state.unsetInternal(value);
  }
}
