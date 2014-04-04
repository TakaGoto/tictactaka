class TTTOptionPresenter
  def self.generate_options(options)
    html_options = '<form class="start-button" action="/game" method="post">'

    options.each do |key, value|
      html_options += "<small> #{key} </small>"
      html_options += "<select name=#{key} size='1'>"
      value.each do |option|
        html_options += "<option value =#{option}>#{option}</option>"
      end
      html_options += "</select>"
    end

    html_options += "<div><input id='start_game' type='submit' value='Start Game'></div>"
    html_options += '</form>'
  end
end
