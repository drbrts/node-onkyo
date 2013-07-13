express = require('express')
spawn = require('child_process').spawn
app = express()

app.get '/:command/:arg/:zone?', (req, res) ->

  params = req.params
  zone = params.zone || 'main.'
  command = zone + params.command + '=' + params.arg

  # Allow the zone to be optional by checking for a arg.
  onkyo = spawn '/usr/local/bin/onkyo', ['--all', command]
  # onkyo = spawn 'ls', ['-Alf', '~/']

  onkyo.stdout.on 'data', (data) -> res.send 'stdout: '+data
  onkyo.stderr.on 'data', (data) -> res.send 'stderr: '+data

app.get '/', (req, res) -> res.send 'hello onkyo'

app.listen 3000
