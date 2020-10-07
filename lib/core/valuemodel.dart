part of flutter_widget_model;

abstract class ValueModel<T extends Object> extends Model<T> {
  final T initialValue;
  ValueModel([T initialValue])
      : this.initialValue = initialValue,
        super();

  /// Retrieve the data obtained from the model.
  ///
  /// Normally, you will get the data from the [build] method.
  @protected
  @override
  T get state => this._state ?? this.initialValue;
}
