{ spawnSync } = require 'child_process'
coffee = require 'coffeescript'
coffeelint = require 'coffeelint'
cson = require 'cson'
fs = require 'fs-extra'

find_files = (pattern) ->
	spawnSync(
		'find',
		['build/', '-name', pattern]
	).stdout.toString().split('\n').filter (file) -> /\S/.test(file)

task 'lint', ->
	fs.writeFileSync(
		'coffeelint.json',
		cson.createJSONString(
			cson.parseCSONFile('coffeelint.cson')
		)
	)

	linters =
		coffeelint:
			spawnSync(
				'coffeelint',
				[
					'-f', 'coffeelint.json',
					'Cakefile',
					'src/'
				],
				stdio: 'inherit'
			).status == 0

	fs.removeSync('coffeelint.json')

	process.exit(
		if (success for _key, success of linters).every((x) -> x) then 0 else 1
	)

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
