package app;

import lies.Reduced;
import thx.http.Request;
import thx.http.RequestInfo;

class Reducers {
  public static function mtgApp(state : State, action : Action) return switch action {
    case RequestInitialData: getCards(state);
    case _: Reduced.fromState(state);
  }

  static function getCards(state) {
    var info = new RequestInfo(Get, thx.Url.fromString("/api/cards"));

    // TODO: async state magic
    Request.make(info);
    return Reduced.fromState(state);
  }
}
