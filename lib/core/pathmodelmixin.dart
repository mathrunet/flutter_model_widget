part of flutter_widget_model;

mixin PathModelMixin<TPath extends IPath> on Model<TPath> implements IPath {
  @override
  @protected
  void dispose() {
    TPath state = this.state;
    if (state == null) return;
    return state.dispose();
  }

  @override
  String get extension {
    TPath state = this.state;
    if (state == null) return Paths.extension(this.path);
    return state.extension;
  }

  @override
  int get group {
    TPath state = this.state;
    if (state == null) return 0;
    return state.group;
  }

  @override
  String get id {
    TPath state = this.state;
    if (state == null) return Paths.last(this.path);
    return state.id;
  }

  @override
  bool get isDisposable {
    TPath state = this.state;
    if (state == null) return null;
    return state.isDisposable;
  }

  @override
  bool get isDisposed {
    TPath state = this.state;
    if (state == null) return null;
    return state.isDisposed;
  }

  @override
  bool get isObservable {
    TPath state = this.state;
    if (state == null) return null;
    return state.isObservable;
  }

  @override
  bool get isTemporary {
    TPath state = this.state;
    if (state == null) return null;
    return state.isTemporary;
  }

  @override
  void linkTo(String path) {
    TPath state = this.state;
    if (state == null) return;
    state.linkTo(path);
  }

  @override
  @protected
  void notifyUpdate([int updatedTime = -1]) {
    TPath state = this.state;
    if (state == null) return;
    state.notifyUpdate(updatedTime);
  }

  @override
  @protected
  void onApplicationPause(bool pause) {
    TPath state = this.state;
    if (state == null) return;
    state.onApplicationPause(pause);
  }

  @override
  @protected
  void onApplicationQuit() {
    TPath state = this.state;
    if (state == null) return;
    state.onApplicationQuit();
  }

  @override
  T onDispose<T extends IDisposable>(void Function(T disposable) callback) {
    TPath state = this.state;
    if (state == null) return null;
    return state.onDispose(callback);
  }

  @override
  @protected
  int get order {
    TPath state = this.state;
    if (state == null) return 0;
    return state.order;
  }

  @override
  @protected
  String get protocol {
    TPath state = this.state;
    if (state == null) return Protocol.tmp;
    return state.protocol;
  }

  @override
  @protected
  Path get rawPath {
    TPath state = this.state;
    if (state == null) return Path(this.path);
    return state.rawPath;
  }

  @override
  @protected
  void registerUntemporary() {
    TPath state = this.state;
    if (state == null) return;
    state.registerUntemporary();
  }

  @override
  int get updatedTime {
    TPath state = this.state;
    if (state == null) return 0;
    return state.updatedTime;
  }
}

mixin ClonableModelMixin<TClonable extends IClonable> on Model<TClonable>
    implements IClonable {
  @override
  @protected
  bool get isCloned {
    TClonable state = this.state;
    if (state == null) return false;
    return state.isCloned;
  }

  @override
  @protected
  set isCloned(bool isCloned) {
    TClonable state = this.state;
    if (state == null) return;
    state.isCloned = isCloned;
  }

  @override
  @protected
  T clone<T extends IClonable>({String path, bool isTemporary = false}) {
    TClonable state = this.state;
    if (state == null) return null;
    return state.clone(path: path, isTemporary: isTemporary);
  }

  @override
  @protected
  T copyTo<T extends IClonable>(T dist, {bool isTemporary = false}) {
    TClonable state = this.state;
    if (state == null) return null;
    return state.copyTo(dist, isTemporary: isTemporary);
  }

  @override
  @protected
  T createInstance<T extends IClonable>(String path, bool isTemporary) {
    TClonable state = this.state;
    if (state == null) return null;
    return state.createInstance(path, isTemporary);
  }

  @override
  @protected
  void setCloneInternal(IClonable clone, String path, bool isTemporary) {
    TClonable state = this.state;
    if (state == null) return;
    state.setCloneInternal(clone, path, isTemporary);
  }
}
