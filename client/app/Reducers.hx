package app;

import lies.Reduced;

class Reducers {
  public static function mtgApp(state : State, action : Action) {
    return Reduced.fromState(state);
  }
}
