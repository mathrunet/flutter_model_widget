part of flutter_widget_model;

class _ModelHook<T extends IPath> extends Hook<_ModelState<T>> {
  const _ModelHook(this.model, this.result);

  final Model model;

  final FutureOr result;

  String get path => this.model.path;

  @override
  _ModelHookState<T> createState() => _ModelHookState(this.model);
}

class _ModelHookState<T extends IPath>
    extends HookState<_ModelState<T>, _ModelHook<T>> {
  final _ModelState<T> _state;
  final ModelContext _context;
  _ModelHookState(Model model)
      : this._state = _ModelState<T>(),
        this._context = ModelContext._(model._path);
  @override
  void initHook() {
    super.initHook();
    this._update();
  }

  @override
  void didUpdateHook(_ModelHook<T> oldHook) {
    super.didUpdateHook(oldHook);
    if (oldHook != hook && oldHook.result != hook.result) {
      this._update();
    }
  }

  void _update() {
    FutureOr futureOr = hook.result ?? hook.model.build(_context);
    if (futureOr is Future) {
      futureOr.then(this._didUpdate);
    } else {
      this._didUpdate(futureOr);
    }
  }

  FutureOr _didUpdate(dynamic value) {
    if (value is IPath) {
      if (value == null) {
        if (_state.state != null) {
          _state.state = null;
          setState(() {});
        }
        return null;
      }
      return _state.state = value..listen(this._listener);
    } else if (value is Model) {
      if (value == null || value.state == null) {
        if (_state.state != null) {
          _state.state = null;
          setState(() {});
        }
        return null;
      }
      return _state.state = value.state..listen(this._listener);
    }
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
