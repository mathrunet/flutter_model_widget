part of flutter_widget_model;

/// Model for storing data in Key-Value-Pair document format.
///
/// ```
/// Widget build(BuildContext context) {
///   return Scaffold(
///     appBar: AppBar(
///       title: Text("Title"),
///     ),
///     body: ListView(
///       children: [
///         ListTile(
///           title: Text("Name: ${DataDocumentModel("user")["name"]}")
///         ),
///         ListTile(
///           title: Text("Age: ${DataDocumentModel("user")["age"]}")
///         ),
///         ListTile(
///           title: Text("Country: ${DataDocumentModel("user")["country"]}")
///         )
///       ]
///     )
///     floatingActionButton: FloatingActionButton(
///       onPressed: () {
///         DataDocumentModel("user").save(
///           data: {
///             "name": "Username",
///             "age": 18,
///             "address": "Japan"
///           }
///         );
///       },
///       child: Icon(Icons.add),
///     ),
///   );
/// }
/// ```
class DataDocumentModel extends DocumentModel<DataDocument> {
  /// Value to be set in the data document.
  final Map<String, dynamic> data;

  /// Model for storing data in Key-Value-Pair document format.
  ///
  /// Defines the data document of the specified [path].
  ///
  /// If [data] is specified, [data] will be set to the specified [path].
  DataDocumentModel(String path, [this.data]) : super(path);
  @override
  FutureOr<DataDocument> build(ModelContext context) {
    if (this.data == null) return DataDocument(this.path);
    return DataDocument.fromMap(this.path, this.data);
  }
}
