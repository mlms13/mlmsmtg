package app;

import app.util.Storage;
import app.views.*;
import lies.Store;
import npm.lf.Schema;
using thx.promise.Promise;

class Main {
  public function new() {
    var initialState : State = {
      name : "",
      collection : []
    };

    var store : Store<State, Action> = Store.create(Reducers.mtgApp, initialState);
    Storage.createSetTable();
    Storage.createCardTable();
    Storage.connect({
      // onUpgrade : checkFirstLaunch
    });

    var app = new CardCollection({}, store.state);
    Doom.mount(app, js.Browser.document.body);
  }

  function checkFirstLaunch(rawDb : npm.lf.raw.BackStore) {
    if (rawDb.getVersion() == 0) {
      trace("This was the first run");
    }
  }

  public static function main() {
    new Main();
  }
}
