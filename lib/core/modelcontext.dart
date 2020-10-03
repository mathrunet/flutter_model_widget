part of flutter_widget_model;

/// Context for building a model.
///
/// Basically, you get the path you entered and so on.
class ModelContext {
  IPath _path;
  // ignore: cancel_subscriptions
  StreamSubscription _subscription;
  ModelContext._();
}
