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
abstract class CollectionModel<T extends IDataCollection> extends Model<T>
    with CollectionModelMixin<T>, IterableMixin<IDataDocument> {
  /// Create a data model that treats the data as a collection.
  ///
  /// By specifying [path], you can get data from [PathMap] as well, and you can get the data even outside of the build timing.
  CollectionModel([String path]) : super(path);

  /// Get the iterator of the collection.
  @override
  Iterator<IDataDocument> get iterator =>
      this.state?.iterator ?? <IDataDocument>[].iterator;
}

/// Mix-in for handling collection data.
///
/// You can [delete] a new document to the collection.
abstract class CollectionModelMixin<T extends IDataCollection>
    implements Model<T> {
  /// Removes documents from the collection that are located at the specified [key].
  ///
  /// Include and delete documents that have data on the server.
  Future delete(Object key) async {
    T state = this.state;
    if (state == null) return;
    await state[key]?.delete();
  }
}
