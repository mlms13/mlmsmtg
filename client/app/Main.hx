package app;

import app.util.Storage;
import app.views.*;
import lies.Store;
import npm.lf.Schema;
using thx.promise.Promise;

class Main {
  public function new() {
    Storage.init();

    // TODO: check storage to determine initial state
    var initialState : State = {
      name : "",
      collection : []
    };

    var store : Store<State, Action> = Store.create(Reducers.mtgApp, initialState);

    var app = new CardCollection({}, store.state);
    Doom.mount(app, js.Browser.document.body);
  }

  public static function main() {
    new Main();
  }
}
