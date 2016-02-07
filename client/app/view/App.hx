package app.view;

import app.State;
import Doom.*;
import doom.Node;

class App extends Doom {
  @:api var loadCards : Void -> Void;
  @:state var appState : State;

  override function render() : Node return switch appState {
    case Loading(message): Loader.with(message);
    case NoCards: EmptyCollection.with(loadCards);
    case BrowseCollection(collection): CardCollection.with(collection);
    case Error(err): div(err.message);
  }
}
