require 'sinatra'
require './header_logger'
require './cookie-demo'

use HeaderLogger
run Sinatra::Application
