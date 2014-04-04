require 'erb'
require './lib/presenters/ttt_option_presenter'

class StartRackApp
  def call(env)
    view = ERB.new(File.read('./views/start.html.erb')).result
    [200, {"Content-Type" => "text/html"}, [view]]
  end
end
