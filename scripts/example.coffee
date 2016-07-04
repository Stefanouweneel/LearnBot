# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->

  robot.respond /have a drink/i, (msg) ->
    drinksHad = robot.brain.get('totalDrinks') * 1 or 0

    if drinksHad > 5
      msg.reply "Maybe I shouldn't..."
    else
      msg.reply "Bottom's up!"

      robot.brain.set 'totalDrinks', drinksHad+1

    robot.respond /sleep it off/i, (msg) ->
      robot.brain.set 'totalDrinks', 0
      robot.respond 'Zzzzzz'

  # robot.respond /reader me (.*)/i, (msg) ->
  #   searchQuery = msg.match[1]
  #
  #   articleSearch msg, searchQuery
  #
  # articleSearch = (msg, searchQuery) ->
  #   data = ""
  #   msg.http("https://read.codaisseur.com/search.json")
  #     .query
  #       search: encodeURIComponent(searchQuery)
  #       user_email: process.env.HUBOT_READER_EMAIL
  #       user_token: process.env.HUBOT_READER_TOKEN
  #     .get( (err, req)->
  #       req.addListener "response", (res)->
  #         output = res
  #
  #         output.on 'data', (d)->
  #           data += d.toString('utf-8')
  #
  #         output.on 'end', ()->
  #           parsedData = JSON.parse(data)
  #
  #           if parsedData.error
  #             msg.send "Error searching Reader: #{parsedData.error}"
  #             return
  #
  #           if parsedData.length > 0
  #             i = 0
  #             qs = for article in parsedData[0..3]
  #               "#{++i}. <https://read.codaisseur.com/topics/#{article.topics[0].slug}/articles/#{article.slug}|#{article.title}>"
  #             if parsedData.total-3 > 0
  #               qs.push "#{parsedData.total-3} more..."
  #             msg.send qs.join("\n")
  #           else
  #             msg.reply "No articles found matching that search."
  #     )()

  robot.respond /npm me (.*)/i, (msg) ->
    search = escape(msg.match[1])
    msg.http('https://www.npmjs.com/search?q=')
      .query(q: search)
      .get( (err, req, body) ->
        req.addListener "response", (res)->
          output = res

          output.on 'q', (d)->
            data += d.toString('utf-8')

          output.on 'end', ()->
            parsedData = JSON.parse(body).data

        if parsedData.length > 0
          result = msg.random(data)
          msg.send result.link
        else
          msg.send "NO!"
          )
  # robot.respond /have a soda/i, (msg) ->
  #   # Get number of sodas had (coerced to a number).
  #   sodasHad = robot.brain.get('totalSodas') * 1 or 0
  #
  #   if sodasHad > 4
  #     msg.reply "I'm too fizzy.."
  #
  #   else
  #     msg.reply 'Sure!'
  #
  #     robot.brain.set 'totalSodas', sodasHad+1
  #
  # robot.respond /sleep it off/i, (msg) ->
  #   robot.brain.set 'totalSodas', 0
  #   robot.respond 'zzzzz'

  # robot.hear /badger/i, (msg) ->
  #   msg.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"
  #
  # robot.respond /open the (.*) doors/i, (msg) ->
  #   doorType = msg.match[1]
  #   if doorType is "pod bay"
  #     msg.reply "I'm afraid I can't let you do that."
  #   else
  #     msg.reply "Opening #{doorType} doors"
  #
  # robot.hear /I like pie/i, (msg) ->
  #   msg.emote "makes a freshly baked pie"
  #
  # lulz = ['lol', 'rofl', 'lmao']
  #
  # robot.respond /lulz/i, (msg) ->
  #   msg.send msg.random lulz
  #
  # robot.topic (msg) ->
  #   msg.send "#{msg.message.text}? That's a Paddlin'"
  #
  #
  # enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
  # leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  #
  # robot.enter (msg) ->
  #   msg.send msg.random enterReplies
  # robot.leave (msg) ->
  #   msg.send msg.random leaveReplies
  #
  # answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING
  #
  # robot.respond /what is the answer to the ultimate question of life/, (msg) ->
  #   unless answer?
  #     msg.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
  #     return
  #   msg.send "#{answer}, but what is the question?"
  #
  # robot.respond /you are a little slow/, (msg) ->
  #   setTimeout () ->
  #     msg.send "Who you calling 'slow'?"
  #   , 60 * 1000
  #
  # annoyIntervalId = null
  #
  # robot.respond /annoy me/, (msg) ->
  #   if annoyIntervalId
  #     msg.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #     return
  #
  #   msg.send "Hey, want to hear the most annoying sound in the world?"
  #   annoyIntervalId = setInterval () ->
  #     msg.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #   , 1000
  #
  # robot.respond /unannoy me/, (msg) ->
  #   if annoyIntervalId
  #     msg.send "GUYS, GUYS, GUYS!"
  #     clearInterval(annoyIntervalId)
  #     annoyIntervalId = null
  #   else
  #     msg.send "Not annoying you right now, am I?"
  #
  #
  # robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
  #   room   = req.params.room
  #   data   = JSON.parse req.body.payload
  #   secret = data.secret
  #
  #   robot.messageRoom room, "I have a secret: #{secret}"
  #
  #   res.send 'OK'
  #
  # robot.error (err, msg) ->
  #   robot.logger.error "DOES NOT COMPUTE"
  #
  #   if msg?
  #     msg.reply "DOES NOT COMPUTE"
  #
  # robot.respond /have a soda/i, (msg) ->
  #   # Get number of sodas had (coerced to a number).
  #   sodasHad = robot.brain.get('totalSodas') * 1 or 0
  #
  #   if sodasHad > 4
  #     msg.reply "I'm too fizzy.."
  #
  #   else
  #     msg.reply 'Sure!'
  #
  #     robot.brain.set 'totalSodas', sodasHad+1
  #
  # robot.respond /sleep it off/i, (msg) ->
  #   robot.brain.set 'totalSodas', 0
  #   robot.respond 'zzzzz'
