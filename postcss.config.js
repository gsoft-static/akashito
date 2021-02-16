/* global process */

const BUNDLE_FOR_PROD = process.env.BUNDLE === 'production' || process.env.BUNDLE === 'prod'

module.exports = {
  plugins: [
    require('autoprefixer'),
    BUNDLE_FOR_PROD ? require('cssnano') : null,
  ]
}
