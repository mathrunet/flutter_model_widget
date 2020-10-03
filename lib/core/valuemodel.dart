part of flutter_widget_model;

@immutable
abstract class ValueModel<T extends Object> extends Model<T> {
  final T initialValue;
  const ValueModel([T initialValue])
      : this.initialValue = initialValue,
        super();

  /// Retrieve the data obtained from the model.
  ///
  /// Normally, you will get the data from the [build] method.
  @protected
  T get state {
    try {
      return this.build(
            use(
              _ModelHook(this),
            ),
          ) ??
          this.initialValue;
    } on AssertionError {
      return this.build(
            ModelContext._(),
          ) ??
          this.initialValue;
    }
  }
}
