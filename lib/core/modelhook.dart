part of flutter_widget_model;

class _ModelHook<T extends IPath> extends Hook<_ModelState<T>> {
  const _ModelHook(this.model);

  final Model model;

  @override
  _ModelHookState<T> createState() => _ModelHookState(this.model);
}

class _ModelHookState<T extends IPath>
    extends HookState<_ModelState<T>, _ModelHook<T>> {
  final _ModelState<T> _state;
  _ModelHookState(Model model) : this._state = _ModelState<T>();
  @override
  void initHook() {
    super.initHook();
    this._update();
  }

  @override
  void didUpdateHook(_ModelHook<T> oldHook) {
    super.didUpdateHook(oldHook);
    if (oldHook != hook && oldHook.model != hook.model) {
      this._update();
    }
  }

  void _update() {
    hook.model?.createTask()?.then((value) {
      if (value == null) {
        if (_state.state != null) {
          _state.state = null;
          setState(() {});
        }
        return null;
      }
      return _state.state = value..listen(this._listener);
    });
  }

  @override
  void dispose() {
    _state?.state?.unlisten(_listener);
    super.dispose();
  }

  @override
  _ModelState<T> build(BuildContext context) {
    return _state;
  }

  void _listener(T state) {
    _state.state = state;
    setState(() {});
  }

  @override
  Object get debugValue => _state;

  @override
  String get debugLabel => 'usePath<$T>';
}
