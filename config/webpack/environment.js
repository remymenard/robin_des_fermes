const { environment } = require('@rails/webpacker')
const jquery = require('./plugins/jquery')
const erb = require('./loaders/erb')

const webpack = require('webpack');
// Preventing Babel from transpiling NodeModules packages
environment.loaders.delete('nodeModules');
// Bootstrap 4 has a dependency over jQuery & Popper.js:
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
);
environment.loaders.prepend('erb', erb)
environment.plugins.prepend('jquery', jquery)
module.exports = environment
