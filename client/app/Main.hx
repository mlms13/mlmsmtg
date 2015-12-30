package app;

import app.state.*;
import app.util.Storage;
import app.views.*;
import lies.Store;
import npm.lf.Schema;
using thx.promise.Promise;

class Main {
  public function new() {
    Storage.init();

    var initialState : State = {
      selectedCollection : Storage.hasCards() ? {
        name : "All Cards",
        cards : Storage.getAllCards()
      } : {
        name : "",
        cards : []
      }
    };

    var store : Store<State, Action> = Store.create(Reducers.mtgApp, initialState);

    var app = new CardCollection({}, store.state);
    Doom.mount(app, js.Browser.document.body);
  }

  public static function main() {
    new Main();
  }
}
