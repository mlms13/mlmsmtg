package app;

import app.state.*;

enum State {
  Loading(message : String);
  Error(err : thx.Error);
  NoCards;
  BrowseCollection(collection : Collection);
  // BuildDeck
  // others?
}
