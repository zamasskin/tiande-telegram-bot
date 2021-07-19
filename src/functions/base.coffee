module.exports =
  time_out: (ms) ->
    new Promise (resolve) ->
      setTimeout resolve, ms
