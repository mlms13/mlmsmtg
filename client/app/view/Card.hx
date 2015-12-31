package app.view;

import Doom.*;

class Card extends doom.Component<{}, app.state.Card> {
  override function render() {
    return div(state.name);
  }
}
