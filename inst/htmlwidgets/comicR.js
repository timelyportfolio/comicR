HTMLWidgets.widget({

  name: 'comicR',

  type: 'output',

  initialize: function(el, width, height) {

    return { }

  },

  renderValue: function(el, x, instance) {

    if (x.selector ===  null) {
      [].forEach.call(document.getElementsByTagName('svg'),function(el){COMIC.magic(el)})
    } else {
      [].forEach.call(document.querySelectorAll(x.selector),function(el){COMIC.magic(el)})
    }

  },

  resize: function(el, width, height, instance) {

  }

});
