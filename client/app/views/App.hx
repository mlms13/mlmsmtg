package app.views;

import app.data.AppState;
import app.data.MtgAction;
import Doom.*;
import doom.ApiStatelessComponent;
import lies.Store;

class App extends ApiStatelessComponent<Store<AppState, MtgAction>> {
  override function render() {
    return DIV([
      "class" => "mtg-card-container"
    ], [
      UL([
        "class" => "mtg-card-list"
      ])
    ]);
  }
}
