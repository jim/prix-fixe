require 'test_helper'

require 'prix_fixe/web'

ENV['RACK_ENV'] = 'test'

module PrixFixe
  describe Web do

    include Rack::Test::Methods

    def app
      Web
    end

    it 'renders the homepage' do
      get '/'
      assert last_response.ok?
    end

    it 'processes valid CSS' do
      post '/process', 'source' => '.class-name { font-weight: bold; }', 'prefix' => 'p'

      assert last_response.ok?

      expected = <<-VAL
.p-class-name {
  font-weight: bold;
}
VAL

      assert_textarea_value last_response.body, 'textarea', expected
    end

    it 'handles invalid CSS gracefully' do
      post '/process', 'source' => "blahrgugh }}..\n", 'prefix' => 'pre'

      assert last_response.ok?
      assert_match /Unfortunately/, last_response.body
      assert_match /Invalid CSS/, last_response.body

      assert_input_value last_response.body, 'input[name="prefix"]', 'pre'

      expected = <<-VAL
blahrgugh }}..
VAL
      assert_textarea_value last_response.body, 'textarea[name="source"]', expected
    end

    it 'handles not providing params' do
      post '/process', 'source' => '', 'prefix' => ''

      assert last_response.ok?
      assert_match /Unfortunately/, last_response.body
      assert_match /You must provide CSS/, last_response.body
      assert_match /You must provide a prefix/, last_response.body
    end
  end

end
