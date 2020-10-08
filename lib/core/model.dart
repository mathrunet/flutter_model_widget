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

  /// The base class of the model.
  @mustCallSuper
  const Model(this.path) : assert(path != null, "You must specify the path.");

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
  T get state {
    try {
      BuildContext context = useContext();
      if (context == null) return PathMap.get<T>(this.path);
      use(_ModelHook(this));
    } on AssertionError {}
    return PathMap.get<T>(this.path);
  }
}
