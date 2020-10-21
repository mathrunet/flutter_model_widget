part of flutter_widget_model;

class _ModelHook<T extends IPath> extends Hook<T> {
  const _ModelHook(this.model);

  final Model<T> model;

  @override
  _ModelHookState<T> createState() => _ModelHookState<T>();
}

class _ModelHookState<T extends IPath> extends HookState<T, _ModelHook<T>> {
  T _state;
  final ModelContext _context = ModelContext._();
  _ModelHookState();
  @override
  void initHook() {
    super.initHook();
    this._update();
  }

  @override
  void didUpdateHook(_ModelHook oldHook) {
    super.didUpdateHook(oldHook);
    if (oldHook.model.path != hook.model.path) {
      this._update();
    }
  }

  void _update() {
    FutureOr<T> future = hook.model.build(this._context);
    if (future is Future<T>) {
      future.then((value) {
        this._state = value;
        this._state?.listen(this._listener);
        this._listener(value);
      });
    } else if (future is T) {
      this._state = future;
      this._state?.listen(this._listener);
      this._listener(future);
    }
  }

  @override
  void dispose() {
    this._state?.unlisten(this._listener);
    super.dispose();
  }

  @override
  T build(BuildContext context) {
    return this._state;
  }

  void _listener(T value) {
    if (this._state == null) this._state = value;
    setState(() {});
  }

  @override
  Object get debugValue => _state;

  @override
  String get debugLabel => 'usePath';
}
