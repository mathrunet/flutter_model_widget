part of flutter_widget_model;

/// Data model for storing single-shot data such as String, int, and double.
///
/// Please inherit and use it.
///
/// ```
/// class TestField extends FieldModel {
///   FutureOr build(ModelContext context) {
///     return DataField(context.path);
///   }
/// }
/// ```
///
/// You can rewrite the value with [set], [increment], [decrement], etc., and get a value of the type with [getString], etc.
/// You can also get the value by [dynamic] by specifying [value].
@immutable
abstract class FieldModel<TField extends IDataField> extends Model<TField>
    with PathModelMixin<TField>, ClonableModelMixin<TField>
    implements IDataField {
  /// Data model for storing single-shot data such as String, int, and double.
  ///
  /// By specifying [path], you can get data from [PathMap] as well, and you can get the data even outside of the build timing.
  @mustCallSuper
  const FieldModel(String path) : super(path);

  /// You can set and rewrite the data.
  ///
  /// You can pass any value you want to set to [value].
  ///
  /// It is possible to set a new value by specifying a separate [builder] to use the initial value, or if it already exists, to use that value.
  void set(dynamic value, [dynamic builder(dynamic value)]) {
    TField state = this.state;
    if (builder == null) {
      if (state == null) {
        DataField(this.path, value);
      } else {
        state.data = value;
      }
    } else {
      if (state == null) {
        DataField(this.path, builder(value));
      } else {
        state.data = builder(state.data ?? value);
      }
    }
  }

  /// If the value of a field is numeric, you can increase its value by [value].
  void increment([num value = 1]) {
    if (value == null) return;
    TField state = this.state;
    if (state == null) {
      DataField(this.path, value);
    } else {
      if (value is int) state.data = state.getInt() + value;
      if (value is double) state.data = state.getDouble() + value;
    }
  }

  /// If the value of a field is numeric, you can decrease its value by [value].
  void decrement([num value = 1]) {
    if (value == null) return;
    TField state = this.state;
    if (state == null) {
      DataField(this.path, -value);
    } else {
      if (value is int) state.data = state.getInt() - value;
      if (value is double) state.data = state.getDouble() - value;
    }
  }

  /// Get the data set in the field.
  dynamic get value {
    TField state = this.state;
    if (state == null) return null;
    return state.data;
  }

  /// Set the specified [value] in the field.
  set value(dynamic value) {
    TField state = this.state;
    if (state == null) return;
    state.data = value;
  }

  /// Get the data set in the field as [bool].
  ///
  /// You can pass an initial value to [defaultValue] if the data does not exist.
  bool getBool([bool defaultValue = false]) {
    TField state = this.state;
    if (state == null) return defaultValue;
    return state.getBool(defaultValue);
  }

  /// Get the data set in the field as [int].
  ///
  /// You can pass an initial value to [defaultValue] if the data does not exist.
  int getInt([int defaultValue = 0]) {
    TField state = this.state;
    if (state == null) return defaultValue;
    return state.getInt(defaultValue);
  }

  /// Get the data set in the field as [double].
  ///
  /// You can pass an initial value to [defaultValue] if the data does not exist.
  double getDouble([double defaultValue = 0]) {
    TField state = this.state;
    if (state == null) return defaultValue;
    return state.getDouble(defaultValue);
  }

  /// Get the data set in the field as [String].
  ///
  /// You can pass an initial value to [defaultValue] if the data does not exist.
  String getString([String defaultValue = ""]) {
    TField state = this.state;
    if (state == null) return defaultValue;
    return state.getString(defaultValue);
  }

  /// Get the data set in the field as [List].
  ///
  /// You can pass an initial value to [defaultValue] if the data does not exist.
  List<V> getList<V extends Object>([List defaultValue = const []]) {
    TField state = this.state;
    if (state == null) return defaultValue;
    return state.getList<V>(defaultValue);
  }

  /// Get the data set in the field as [Map].
  ///
  /// You can pass an initial value to [defaultValue] if the data does not exist.
  Map<K, V> getMap<K extends Object, V extends Object>(
      [Map defaultValue = const {}]) {
    TField state = this.state;
    if (state == null) return defaultValue;
    return state.getMap<K, V>(defaultValue);
  }

  @override
  Object get data {
    TField state = this.state;
    if (state == null) return null;
    return state.data;
  }

  @override
  set data(Object data) {
    TField state = this.state;
    if (state == null) return;
    state.data = data;
  }

  @override
  operator [](String path) {
    TField state = this.state;
    if (state == null) return null;
    return state[path];
  }

  @override
  T debug<T extends IDebuggable>([Object value]) {
    TField state = this.state;
    if (state == null) return null;
    return state.debug(value);
  }

  @override
  @protected
  void setInternal(Object value) {
    TField state = this.state;
    if (state == null) return;
    state.setInternal(value);
  }

  @override
  void unsetInternal() {
    TField state = this.state;
    if (state == null) return;
    state.unsetInternal();
  }

  @override
  bool get isLock {
    TField state = this.state;
    if (state == null) return null;
    return state.isLock;
  }

  @override
  @protected
  Object get rawData {
    TField state = this.state;
    if (state == null) return null;
    return state.rawData;
  }
}
