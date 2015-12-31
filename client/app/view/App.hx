package app.view;

import Doom.*;
import doom.Node;

class App extends doom.Component<{}, State> {
  override function render() : Node return switch state {
    case BrowseCards(collection): new CardCollection({}, collection);
    case _: div(); // TODO
  }
}
