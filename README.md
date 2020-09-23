# Flutter Widget Model

Package that allows you to treat your models like widgets.
Used with [flutter_hooks].

[![Version](https://img.shields.io/badge/version-0.4.0-blue.svg)](https://mathru.net)
[![Language](https://img.shields.io/badge/language-dart-blue.svg)](https://dart.dev/)
[![License: BSD](https://img.shields.io/badge/license-BSD-purple.svg)](https://opensource.org/licenses/BSD-3-Clause)

## Getting Started

Add this to your package's pubspec.yaml file:
```yaml
dependencies:
  flutter_widget_model: ^0.4.0
```
You should then run `flutter packages upgrade`.

## Usage

```yaml
import 'package:flutter_widget_model/flutter_widget_model.dart';
```

## Feature

### Three data structures

This package treats the data as restricted to three structures
- Field
  - It deals with a single piece of data, such as a string or a number.
- Document
  - This is a hash map that can hold multiple units by pairing them with a key.
- Collection
  - Saves multiple Documents (or Units) in order.

You can also save them in a tree structure and retrieve them by specifying the path.

For example, if your user's name is in the following path, you can retrieve the data by specifying the path "user/user_id/name" to get the Unit with the user's name in it.

You could also specify "user/user_id" to get a document with the user's data.

You can also retrieve a collection containing multiple users by specifying 'user'.

```
user/user_id/name
```

This data structure is very similar to NoSQL, especially to Firestore's data structure, so you can handle the data as if you were working with those databases.

### Model Widgets

You can treat your data model like a widget.
You can use it just like any other widget inside the build method.

```dart
void build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text("Title"),
    ),
    body: ListView(
      children: DataCollectionModel("user").map(
        (item) => ListTile(
          title: Text(item.getString("uid")),
        ),
      ).toList(),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        DataCollectionModel("user").append(
          Texts.uuid,
          builder: (doc) {
            doc["uid"] = Texts.uuid;
          },
        );
      },
      child: Icon(Icons.add),
    ),
  );
}
```

It also allows you to combine multiple model widgets into a single model widget, like a widget.

```dart
class TestModel extends CollectionModel<IDataCollection> {
  @override
  FutureOr build(ModelContext context) async {
    final path =
        FirestoreDocumentModel("app/setting").getString("userPath");
    if (isEmpty(path)) return null;
    return FirestoreCollectionModel(path);
  }
}
```

### Using flutter_hooks

Because we are using flutter_hooks on the back side, we are using
You can still use the flutter_hooks features such as useState.

Also, if you create a widget, you need to extend HookWidget.

## Example

```dart
class HookTest extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: ListView(
        children: DataCollectionModel("user").map(
          (item) => ListTile(
            title: Text(item.getString("uid")),
          ),
        ).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DataCollectionModel("user").append(
            Texts.uuid,
            builder: (doc) {
              doc["uid"] = Texts.uuid;
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

## License

[BSD](LICENSE)