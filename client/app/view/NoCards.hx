package app.view;

import Doom.*;

class NoCards extends doom.Component<NoCardsApi, {}> {
  override function render() {
    return button("Download Cards");
  }
}

typedef NoCardsApi = {};
