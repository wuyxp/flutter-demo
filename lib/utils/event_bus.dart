/// event_bus 总线
///
///

typedef EventCallback = void Function();

class EventBus {

  // 单例
  static EventBus _eventBus;
  EventBus._internal();
  factory EventBus () {
    if (_eventBus == null) {
      _eventBus = EventBus._internal();
    }
    return _eventBus;
  }

  // 本地事件存储
  Map<String, List<EventCallback>> _eventMap = Map();

  // 监听事件
  void on(String name, EventCallback callback) {
    _eventMap[name] ??= List<EventCallback>();
    _eventMap[name].add(callback);
  }

  // 取消事件
  void off(String name, [EventCallback callback]) {
    if (callback == null) {
      _eventMap.remove(name);
    } else {
      if (_eventMap[name] != null) {
        _eventMap[name].remove(callback);
      }
    }
  }

  // 触发事件
  void emit(String name) {
    List<EventCallback> _list = _eventMap[name];
    if (_list != null) {
      for (int i = 0; i< _list.length; i++) {
        _list[i].call();
      }
    }
  }
}

