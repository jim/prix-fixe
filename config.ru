require 'rubygems'
require 'bundler'

Bundler.require

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

use Raven::Rack

require 'prix_fixe/web'
run PrixFixe::Web
