fs = require 'fs'
swig = require 'swig'
path = require 'path'
mkpath = require 'mkpath'
{exec} = require 'child_process'
async = require 'async'
sys = require 'sys'

today = ->
  d = new Date
  "#{d.getMonth() + 1}/#{d.getDate()}/#{d.getYear() % 100}"

templatesPath = "#{__dirname}/templates"

walk = (dir, done) ->
  results = []
  fs.readdir dir, (err, files) ->
    return done err if err
    pending = files.length
    return done null, results unless pending
    files.forEach (file) ->
      if file is '.DS_Store'
        done null, results unless --pending
        return
      file = dir + '/' + file
      fs.stat file, (err, stat) ->
        if stat and stat.isDirectory()
          walk file, (err, res) ->
            results = results.concat res
            done null, results unless --pending
        else
          results.push file
          done null, results unless --pending

exports.generate = (project) ->
  options =
    currentDate: today()
    author: 'Jason Huang'
    project: project[0].toLowerCase() + project[1..]
    Project: project[0].toUpperCase() + project[1..]
  
  projectName = "TP#{project}"
  pod = ->
    projDir = "#{projectName}/Project"
    console.log "pod install in #{projDir} ..."
    
    exec "pod", "install", cwd: projDir, (err, stdout, stderr) ->
      sys.print stdout
      sys.print stderr
      console.log 'done!'
  
  fs.mkdir projectName, (err) ->
    if err
      return console.error err.path + ' Already Exists'
    walk templatesPath, (err, files) ->
      async.forEachSeries files, (file, next) ->
        template = swig.compile file
        fileName = template options
        template = swig.compileFile file
        content = template options
        targetFileName = fileName.replace templatesPath, projectName
        
        console.log targetFileName
        mkpath path.dirname(targetFileName), (err) ->
          fs.writeFile targetFileName, content, (err) ->
            if err
              console.log path.dirname(targetFileName)
              console.log err
            next()
      , pod
   