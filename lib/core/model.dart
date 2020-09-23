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
  final String __path;

  /// The base class of the model.
  ///
  /// You can set the path to the model by specifying [path].
  ///
  /// You can use [ModelContext] to get the path specified here.
  @mustCallSuper
  const Model([String path]) : this.__path = path;

  /// Build the model.
  ///
  /// The [context] section contains the context needed for the model.
  ///
  /// You can return [FutureOr<T>] or [FutureOr<Model>] to reflect the data in it in the model.
  FutureOr build(ModelContext context);

  /// You can retrieve the path passed to you at model creation.
  String get path => this.__path;
  String get _path {
    if (isEmpty(this.__path)) {
      return this.runtimeType.hashCode.toString();
    } else {
      return "${this.runtimeType.hashCode.toString()}/${this.__path}";
    }
  }

  /// Retrieve the data obtained from the model.
  ///
  /// Normally, you will get the data from the [build] method.
  ///
  /// If it is not the timing of [HookWidget], data is retrieved from [PathMap].
  T get state {
    FutureOr result = this.build(ModelContext._(this._path));
    try {
      IPath state = use(_ModelHook(this, result))?.state;
      if (state is T) return state;
    } on AssertionError {}
    if (!(result is Future)) {
      T val = this._getStateInternal(result);
      if (val != null) return val;
    }
    return PathMap.get<T>(this.path);
  }

  T _getStateInternal(dynamic value) {
    if (value is IPath) {
      return value as T;
    } else if (value is Model) {
      return value.state as T;
    }
    return null;
  }
}
