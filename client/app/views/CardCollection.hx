package app.views;

import app.State;
import app.Action;
import Doom.*;

class CardCollection extends doom.Component<CardApi, State> {
  override function render() {
    return div([
      "class" => "mtg-card-container"
    ], [
      ul([
        "class" => "mtg-card-list"
      ], state.selectedCollection.cards.map(function (card) {
        return li(new Card({}, card));
      }))
    ]);
  }
}

typedef CardApi = {};
