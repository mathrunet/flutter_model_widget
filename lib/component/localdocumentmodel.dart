part of flutter_widget_model;


/// Model for storing data in Key-Value-Pair document format.
/// 
/// Executing the [save] method saves the data in the device.
/// Even if the application is terminated, the data will be restored and available.
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
///           title: Text("Name: ${LocalDocumentModel("user")["name"]}")
///         ),
///         ListTile(
///           title: Text("Age: ${LocalDocumentModel("user")["age"]}")
///         ),
///         ListTile(
///           title: Text("Country: ${LocalDocumentModel("user")["country"]}")
///         )
///       ]
///     )
///     floatingActionButton: FloatingActionButton(
///       onPressed: () {
///         LocalDocumentModel("user").save(
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
class LocalDocumentModel extends DocumentModel<LocalDocument> {
  /// Model for storing data in Key-Value-Pair document format.
  /// 
  /// Executing the [save] method saves the data in the device.
  /// Even if the application is terminated, the data will be restored and available.
  /// 
  /// Defines the data document of the specified [path].
  LocalDocumentModel(String path) : super(path);
  @override
  FutureOr<LocalDocument> build(ModelContext context) {
    return LocalDocument.load(this.path);
  }
}