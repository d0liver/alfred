gulp    = require 'gulp'
nodemon = require 'gulp-nodemon'
coffee  = require 'gulp-coffee'

gulp.task 'default', ['server']

gulp.task 'prod-build', ['compile-server']

gulp.task 'compile-server', ->
	gulp.src './server/*.coffee'
	.pipe coffee bare: true
	.pipe gulp.dest './server'

gulp.task 'server', ->
	stream = nodemon
		script: 'main.coffee'
		watch: ['**/*.coffee']
		ext: 'coffee'
		env: NODE_ENV: 'development', SLACK_BOT_TOKEN: process.env.SLACK_BOT_TOKEN
