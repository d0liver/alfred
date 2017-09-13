{RtmClient}  = require '@slack/client'
{RTM_EVENTS} = require '@slack/client'
token    = process.env.SLACK_BOT_TOKEN

if token is ''
	throw new Error '
		No bot token provided to communicate with the Slack API. Please provide
		a bot token on the process environment.
	'

rtm = new RtmClient token
rtm.start()

rtm.on RTM_EVENTS.MESSAGE, (message) ->
	console.log "Received message: ", message
	if message.text is 'What is your purpose?'
		# Could also be a channel, group, DM, or user ID (C1234), or a username (@don)
		rtm.sendMessage "<@#{message.user}>, my purpose is to destroy.", message.channel
