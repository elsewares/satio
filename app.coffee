express = require 'express'

app = module.exports = express.createServer();

# Configuration

app.configure () ->
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser()
    app.use express.session({ secret: 'satio'})
    app.use app.router
    app.use express.static "#{__dirname}/public"
    app.use express.logger({ format: ':method :url'})

app.configure 'development', () ->
  app.use express.errorHandler dumpExceptions: true, showStack: true

app.configure 'production', () ->
  app.use express.errorHandler()

# Routes

# Only listen on $ node app.js

app.listen 3000
console.log "Express server listening on port #{app.address().port}"