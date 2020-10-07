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
abstract class CollectionModel<T extends IDynamicCollection> extends Model<T>
    with IterableMixin<IDynamicDocument>
    implements
        Iterable<IDynamicDocument>,
        IDynamicCollection<IDynamicDocument> {
  final String path;
  final OrderBy orderBy;
  final OrderBy thenBy;
  final String orderByKey;
  final String thenByKey;

  @override
  void addListener(T value, Function(dynamic value) listen) {
    if (value is IDataCollection) value.listen(listen);
  }

  @override
  void removeListener(T value, Function(dynamic value) listen) {
    if (value is IDataCollection) value.unlisten(listen);
  }

  /// Create a data model that treats the data as a collection.
  ///
  /// By specifying [path], you can get data from [PathMap] as well, and you can get the data even outside of the build timing.
  ///
  /// You can sort by specifying [orderBy], [orderByKey].
  /// You can also specify [thenBy] and [thenByKey] to further sort the elements in the same order in the first sort.
  CollectionModel(
      {this.path,
      this.orderBy = OrderBy.none,
      this.orderByKey,
      this.thenBy = OrderBy.none,
      this.thenByKey})
      : super();

  /// Get the iterator of the collection.
  @override
  Iterator<IDataDocument> get iterator =>
      this.state?.iterator ?? <IDataDocument>[].iterator;

  /// Removes documents from the collection that are located at the specified [key].
  ///
  /// Include and delete documents that have data on the server.
  Future delete(Object key) async {
    T state = this.state;
    if (state == null) return;
    if (state is IDataCollection) {
      await state[key]?.delete();
    } else if (state is CollectionModel) {
      await state.delete(key);
    }
  }

  /// Reload the collection data.
  Future reload() async {
    T state = this.state;
    if (state == null) return;
    if (state is IDataCollection) {
      await state.reload();
    } else if (state is CollectionModel) {
      await state.reload();
    }
  }

  /// Load the following data.
  Future next() async {
    T state = this.state;
    if (state == null) return;
    if (state is IDataCollection) {
      await state.next();
    } else if (state is CollectionModel) {
      await state.next();
    }
  }

  /// True if the following data is available.
  bool canNext() {
    T state = this.state;
    if (state == null) return false;
    if (state is IDataCollection) {
      return state.canNext();
    } else if (state is CollectionModel) {
      return state.canNext();
    }
    return false;
  }
}
