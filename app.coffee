express = require 'express'
mongoose = require 'mongoose'

app = module.exports = express.createServer();

# Mongo connection
mongoose.connect 'mongodb://localhost/my_database'
mongoose.connection.on "open", ->
  console.log "mongodb is connected!!"

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

#models
Post = mongoose.model 'Post', new mongoose.Schema({
  title: String,
  body: String,
  slug: String
}, { collection : 'posts' })

# Routes
app.get '/api/posts', (req, res) ->
  return Post.find( (err, posts) ->
    	return res.json(posts)
  )

app.get '/api/posts/:id', (req, res) ->
  return Post.findById(req.params.id, (err, post) ->
    if (!err)
      return res.json(post)
  )

app.post '/api/posts', (req, res) ->
		console.log req.body
  post = new Post({
    title: req.body.title,
    body: req.body.body,
    slug: req.body.title.replace(/\s+/g,'-').replace(/[^a-zA-Z0-9\-]/g,'').toLowerCase()
  })
  post.save((err) ->
    if (!err)
      console.log "Post created"
  )
  return res.json(post)

app.put '/api/posts/:id', (req, res) ->
	Post.findById(req.params.id, (err, post) ->
	  post.title = req.body.title
	  post.body = req.body.body
	  post.slug = req.body.title.replace(/\s+/g,'-').replace(/[^a-zA-Z0-9\-]/g,'').toLowerCase()	
		post.save((err) ->
			if (!err)
				console.log " Post updated"
			return res.json(post)
		)
	)
	

app.listen 3000
console.log "Express server listening on port #{app.address().port}"