part of flutter_widget_model;

/// The base class of the model.
///
/// You need to specify a data model that extends [IPath].
///
/// [FieldModel], [DocumentModel] and [CollectionModel] are usually used depending on the data structure to be used.
///
/// If you want to use your newly created data structures, you may want to extend this class to create your own models.
abstract class Model<Created extends Object> {
  final ModelContext context = ModelContext._();
  Created _state;

  /// The base class of the model.
  Model() {
    final state = this.build(context);
    try {
      this._state = use(
        _ModelHook<Created>(
          this,
          state,
        ),
      );
    } on AssertionError {
      this._state = state;
    }
  }

  /// Build the model.
  ///
  /// The [context] section contains the context needed for the model.
  ///
  /// You can return [T] to reflect the data in it in the model.
  @protected
  Created build(ModelContext context);

  /// If you have asynchronous tasks, define them here.
  ///
  /// Return a type of [Future].
  ///
  /// For ease of retrieval,
  /// you may want to store the values retrieved by the task in a separate location while creating this task.
  @protected
  Future<Created> createTask(ModelContext context) => null;

  @protected
  void addListener(Created value, Function(dynamic value) listen) {}

  @protected
  void removeListener(Created value, Function(dynamic value) listen) {}

  /// Retrieve the data obtained from the model.
  ///
  /// Normally, you will get the data from the [build] method.
  @protected
  Created get state => this._state;
}
