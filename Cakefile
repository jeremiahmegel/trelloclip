{ spawnSync } = require 'child_process'
coffee = require 'coffeescript'
cson = require 'cson'
fs = require 'fs-extra'

find_files = (pattern) ->
	spawnSync(
		'find',
		['build/', '-name', pattern]
	).stdout.toString().split("\n").filter (file) -> /\S/.test(file)

task 'build', ->
	fs.removeSync('build')
	fs.copySync('src', 'build')

	find_files('*.coffee').forEach (file) ->
		fs.writeFileSync(
			file.replace(/\.coffee$/, '.js'),
			coffee._compileFile(file)
		)
		fs.removeSync(file)

	find_files('*.cson').forEach (file) ->
		fs.writeFileSync(
			file.replace(/\.cson$/, '.json'),
			cson.createJSONString(
				cson.parseCSONFile(file)
			)
		)
		fs.removeSync(file)

task 'clean', ->
	fs.removeSync('build')
