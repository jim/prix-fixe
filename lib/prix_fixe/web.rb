require 'sinatra/base'

require 'prix_fixe/namespacer'
require 'prix_fixe/form'

module PrixFixe
  class Web < Sinatra::Application

    set :root, File.expand_path('..', __FILE__)
    set :views, settings.root + '/views'

    configure :production do
      Raven.configure do |config|
        config.dsn = ENV['SENTRY_DSN']
      end
    end

    helpers do
      def h(text)
        Rack::Utils.escape_html(text)
      end

      def ga_ua
        ENV['GA_UA'] || ''
      end
    end

    get '/' do
      @form = Form.new
      erb :home
    end

    post '/process' do
      @form = Form.new(source: params['source'], prefix: params['prefix'])
      @form.validate

      if @form.errors?
        erb :home
      else
        begin
          namespacer = Namespacer.new(params['source'])
          namespacer.prefix = params['prefix']
          @css = namespacer.render(:scss)
          erb :result
        rescue Sass::SyntaxError => e
          @form.add_error :source, e.message
          erb :home
        end
      end
    end

  end
end
