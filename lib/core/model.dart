part of flutter_widget_model;

/// The base class of the model.
///
/// You need to specify a data model that extends [IPath].
///
/// [FieldModel], [DocumentModel] and [CollectionModel] are usually used depending on the data structure to be used.
///
/// If you want to use your newly created data structures, you may want to extend this class to create your own models.
@immutable
abstract class Model<T extends IPath> {
  final String path;
  final ModelContext _context;

  /// The base class of the model.
  @mustCallSuper
  Model(this.path)
      : this._context = ModelContext._(),
        assert(path != null, "You must specify the path.") {
    try {
      use(_ModelHook(this));
    } catch (e) {
      this.build(this._context);
    }
  }

  /// Build the model.
  ///
  /// The [context] section contains the context needed for the model.
  ///
  /// You can return [T] to reflect the data in it in the model.
  @protected
  FutureOr<T> build(ModelContext context);

  /// Retrieve the data obtained from the model.
  ///
  /// Normally, you will get the data from the [build] method.
  @protected
  T get state => PathMap.get<T>(this.path);
}
