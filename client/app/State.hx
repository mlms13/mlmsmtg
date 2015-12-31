package app;

import app.state.*;

enum State {
  NoCards;
  BrowseCards(collection : Collection);
  // BuildDeck
  // others?
}
