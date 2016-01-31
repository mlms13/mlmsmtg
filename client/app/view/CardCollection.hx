package app.view;

import app.state.Collection;
import app.Action;
import Doom.*;

class CardCollection extends Doom {
  @:state var collection : app.state.Collection;

  override function render() {
    return div([
      "class" => "mtg-card-container"
    ], [
      ul([
        "class" => "mtg-card-list"
      ], collection.cards.map(function (card) {
        return li(Card.with(card));
      }))
    ]);
  }
}
