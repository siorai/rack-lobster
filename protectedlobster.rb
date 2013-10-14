require 'rack'
require './lobster'

lobster = Rack::Lobster.new

protected_lobster = Rack::Auth::Basic.new(lobster) do |username, password|
  'secreto' == password
end

protected_lobster.realm = 'Lobster 2.0'
pretty_protected_lobster = Rack::ShowStatus.new(Rack::ShowExceptions.new(protected_lobster))

Rack::Server.start :app => pretty_protected_lobster, :Port => 9292
