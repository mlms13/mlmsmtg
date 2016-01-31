package app.view;

import Doom.*;

class Card extends Doom {
  @:state var card : app.state.Card;

  override function render() {
    return div(card.name);
  }
}
