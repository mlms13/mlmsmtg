package app;

import app.state.*;
import app.util.Storage;
import app.view.*;
import lies.Store;
import npm.lf.Schema;
using thx.promise.Promise;

class Main {
  public function new() {
    Storage.init();

    var initialState = Storage.hasCards() ? getInitialCollection() : State.NoCards;
    var store = Store.create(Reducers.mtgApp, initialState);

    var app = new App({}, store.state);
    Doom.mount(app, js.Browser.document.body);
  }

  function getInitialCollection() {
    return State.BrowseCards({
      name : "All Cards",
      cards : Storage.getAllCards()
    });
  }

  public static function main() {
    new Main();
  }
}
