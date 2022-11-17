require_relative './config/environment'

use Rack::Cors do
    allow do
      # origins '*' allows requests from ALL frontend origins
      # (if you deploy your application, change this to
      # ONLY allow requests from YOUR frontend origin, like:
      # origins 'my-react-app.netlify.app')
      origins '*'
      resource '*', headers: :any, methods: [:get, :post, :delete, :put, :patch, :options, :head, :destroy]
    end
end
# Parse JSON from the request body into the params hash
use Rack::JSONBodyParser

run ApplicationController