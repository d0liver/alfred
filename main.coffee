{CLIENT_EVENTS, RTM_EVENTS, RtmClient, MemoryDataStore}  = require '@slack/client'
token    = process.env.SLACK_BOT_TOKEN

foods = [
	"Einstein's"
	"Old School Bagel Cafe"
	"Panera"
	"Blue Moon"
	"Cafe Ole"
	"Mimi's Cafe"
	"Kilkenny's"
	"Tall Grass Prairie"
	"Yokozuna"
	"The Wild Fork"
	"The White Lion"
	"Andolini's"
	"Whole Foods"
	"Frozen Pizza"
	"The Melting Pot"
	"The French Hen"
	"Palace Cafe"
	"India Palace"
	"Helen of Troy"
	"Siegi's"
	"Cosmo"
	"Qdoba"
	"Naples Flatbread"
	"Chiptole"
]

if token is ''
	throw new Error '
		No bot token provided to communicate with the Slack API. Please provide
		a bot token on the process environment.
	'

rtm = new RtmClient token, dataStore: new MemoryDataStore
rtm.start()

rtm.on CLIENT_EVENTS.RTM.RTM_CONNECTION_OPENED, ->
	console.log "Active user id: ", rtm.activeUserId

rtm.on RTM_EVENTS.MESSAGE, (message) ->
	# Bail if the message wasn't intended for alfred
	return unless ///@#{rtm.activeUserId}///.test(message.text)

	if /What is your purpose\?/.test message.text
		# Could also be a channel, group, DM, or user ID (C1234), or a username (@don)
		rtm.sendMessage \
			"<@#{message.user}>, I tell you what foods to eat :slightly_smiling_face:",
			message.channel

	else if /What is your real purpose\?/.test message.text
		rtm.sendMessage \
			"<@#{message.user}>, My purpose is to destroy :slightly_smiling_face:",
			message.channel

	else if /Where should (I|we) eat\?/.test message.text
		rtm.sendMessage \
			"<@#{message.user}>, You should eat #{foods[Math.floor Math.random()*foods.length]}",
			message.channel

	else
		rtm.sendMessage \
			"<@#{message.user}>, Sorry, I'm still pretty dumb and I didn't understand that.",
			message.channel
