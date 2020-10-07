part of flutter_widget_model;

abstract class ListModel<T extends Object> extends Model<Iterable<T>>
    with IterableMixin<T>
    implements Iterable<T> {
  final Iterable<T> initialValue;
  ListModel([Iterable<T> initialValue = const []])
      : this.initialValue = initialValue,
        super();

  /// Retrieve the data obtained from the model.
  ///
  /// Normally, you will get the data from the [build] method.
  @protected
  @override
  Iterable<T> get state => this._state ?? this.initialValue;

  /// Get the iterator of the collection.
  @override
  Iterator<T> get iterator => this.state?.iterator ?? <T>[].iterator;
}
