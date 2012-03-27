require 'nesta/app'
require 'sinatra/base'
require 'sinatra/assetpack'

require 'rack/codehighlighter'

module Nesta
  class App
    register Sinatra::AssetPack
    use Rack::Codehighlighter,
        :pygments_api,
        :element  => 'pre>code',
        :pattern  => /\A:::(\w+)\s*\n/,
        :markdown => true

    ############################################
    ### Static Assets (handled by AssetPack) ###
    ############################################
    asset_root = 'themes/sbb/app'
    assets do |a|
      a.serve '/sbb/js',   :from => "#{asset_root}/javascripts"
      a.serve '/sbb/css',  :from => "#{asset_root}/stylesheets"
      a.serve '/sbb/img',  :from => "#{asset_root}/images"

      a.js  :app_js,  [ '/sbb/js/*.js' ]
      a.css :app_css, [ '/sbb/css/*.css' ]
    end

    #########################
    ### Rack Static Files ###
    #########################
    use Rack::Static, :urls => [ '/sbb/font' ], :root => 'themes/sbb/public'
  end
end

