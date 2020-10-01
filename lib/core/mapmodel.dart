part of flutter_widget_model;

@immutable
abstract class MapModel<K extends Object, V extends Object>
    extends Model<Map<K, V>> with MapMixin<K, V> implements Map<K, V> {
  final Map<K, V> initialValue;
  const MapModel([Map<K, V> initialValue = const {}])
      : this.initialValue = initialValue,
        super();

  /// Retrieve the data obtained from the model.
  ///
  /// Normally, you will get the data from the [build] method.
  @protected
  Map<K, V> get state {
    try {
      use(_ModelHook(this));
    } on AssertionError {
      this.createTask();
    }
    return this.build() ?? this.initialValue;
  }

  /// Get the value corresponding to [key] from the document.
  @override
  V operator [](Object key) {
    Map<K, V> state = this.state;
    if (state == null) return null;
    return state[key];
  }

  /// Pass [value] to [key] in the document.
  @override
  void operator []=(key, value) {
    Map<K, V> state = this.state;
    if (state == null) return;
    state[key] = value;
  }

  /// Clear the document.
  @override
  void clear() {
    Map<K, V> state = this.state;
    if (state == null) return;
    state.clear();
  }

  /// Get a list of keys for the document.
  @override
  Iterable<K> get keys {
    Map<K, V> state = this.state;
    if (state == null) return [];
    return state.keys;
  }

  /// Removes the value corresponding to [key] from the document.
  @override
  V remove(Object key) {
    Map<K, V> state = this.state;
    if (state == null || !state.containsKey(key)) return null;
    V field = state[key];
    state.remove(key);
    return field;
  }
}
