package app.view;

import app.State;
import Doom.*;
import doom.Node;

class App extends Doom {
  @:api var loadCards : Void -> Void;
  @:state var appState : State;

  override function render() : Node return switch appState {
    case NoCards: EmptyCollection.with(loadCards);
    case BrowseCards(collection): new CardCollection({}, collection);
    case _: div(); // TODO
  }
}
