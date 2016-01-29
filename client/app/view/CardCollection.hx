package app.view;

import app.state.Collection;
import app.Action;
import Doom.*;

class CardCollection extends doom.Component<CardApi, Collection> {
  override function render() {
    trace("rendering browse card collection");
    return div([
      "class" => "mtg-card-container"
    ], [
      ul([
        "class" => "mtg-card-list"
      ], state.cards.map(function (card) {
        return li(new Card({}, card));
      }))
    ]);
  }
}

typedef CardApi = {};
