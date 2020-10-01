part of flutter_widget_model;

/// Data model for storing one-off data such as [String], [int], [double] and [bool].
///
/// ```
/// Widget build(BuildContext context) {
///   return Scaffold(
///     appBar: AppBar(
///       title: Text("Title"),
///     ),
///     body: Center(
///       child: Text(
///         DataFieldModel("count").getInt(0).toString()
///       )
///     )
///     floatingActionButton: FloatingActionButton(
///       onPressed: () {
///         DataFieldModel("count").increment();
///       },
///       child: Icon(Icons.add),
///     ),
///   );
/// }
/// ```
@immutable
class DataFieldModel extends FieldModel<DataField> {
  /// Value to be set in the data field.
  final dynamic value;

  /// Data model for storing one-off data such as [String], [int], [double] and [bool].
  ///
  /// Defines the data field of the specified [path].
  ///
  /// If [value] is specified, [value] will be set to the specified [path].
  const DataFieldModel(String path, [this.value]) : super(path);
  @override
  DataField build() {
    if (this.value == null) return DataField(this.path);
    return DataField(this.path, this.value);
  }
}
