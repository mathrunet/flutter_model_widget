part of flutter_widget_model;

/// Context for building a model.
///
/// Basically, you get the path you entered and so on.
///
/// It is possible to get the path passed from [path] when creating the model.
///
/// [joinedPath] can retrieve the path to the composite data created by [JoinedDataCollection].
class ModelContext {
  final String path;
  String get joinedPath => "joined/$path";
  const ModelContext._(this.path);
}
