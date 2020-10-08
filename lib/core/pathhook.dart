part of flutter_widget_model;

/// You can use the Collection only within HookWidget.
///
/// It is possible to specify an initial value by specifying [initialData].
///
/// You can sort by specifying [orderBy], [orderByKey].
/// You can also specify [thenBy] and [thenByKey] to further sort the elements in the same order in the first sort.
T usePath<T extends Object>(String path, [T defaultValue]) {
  return use(_PathHook(path, defaultValue));
}

class _PathHook<T extends Object> extends Hook<T> {
  final String path;
  final T defaultValue;
  _PathHook(this.path, [this.defaultValue]);
  @override
  _PathHookState<T> createState() => _PathHookState<T>();
}

class _PathHookState<T extends Object> extends HookState<T, _PathHook<T>> {
  T _state;
  @override
  void initHook() {
    super.initHook();
    this._state = PathMap.get<T>(hook.path);
    PathListener.listen(hook.path, this._listener);
  }

  void _listener(IPath state) {
    if (state is IUnit && state.data is T) {
      this._state = state.data;
    } else if (state is T) {
      this._state = state as T;
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    PathListener.unlisten(hook.path, this._listener);
  }

  @override
  T build(BuildContext context) {
    return this._state;
  }
}
