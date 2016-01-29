package app;

import app.state.*;
import app.util.Storage;
import app.view.*;
import lies.Store;
import npm.lf.Schema;

class Main {
  public function new() {
    Storage.init();

    Storage.hasCards()
      .success(function (hasCards) {
        var initialState = hasCards ? getInitialCollection() : State.NoCards;
        var store = Store.create(Reducers.mtgApp, initialState);

        var app = new App({
          loadCards: function () {
            store.dispatch(Action.RequestInitialData);
          }
        }, { appState : store.state });
        Doom.mount(app, js.Browser.document.body);
        store.subscribe(function (state, _, _) {
          app.update({ appState : state });
        });
      })
      .failure(function (e) {
        // TODO...
        trace(e);
      });
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
