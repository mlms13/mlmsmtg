package app;

import app.state.*;
import app.view.*;
import lies.Store;
import npm.lf.Schema;

class Main {
  public static function main() {
    app.util.Config.init(new app.storage.Memory());
    var initialState = State.Loading("Checking for cards"),
        store = Store.create(Reducers.mtgApp, initialState);

    var app = new App({
      loadCards: function () {
        store.dispatch(Action.RequestInitialData);
      }
    }, { appState : store.state });

    Doom.mount(app, js.Browser.document.body);
    store.subscribe(function (state, _, _) {
      app.update({ appState : state });
    });

    store.dispatch(Action.CheckForData);
  }

}
