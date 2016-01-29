package app;

import app.state.*;

enum State {
  NoCards;
  BrowseCards(collection : Collection);
  ErrorView(err : thx.Error);
  // BuildDeck
  // others?
}
