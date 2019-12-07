{ spawn } = require 'child_process'
fs = require 'fs-extra'

task 'build', ->
	fs.removeSync 'build'
	fs.copySync 'src', 'build'
	spawn 'coffee', ['--compile', 'build/'], { stdio: 'inherit' }
	spawn(
		'find',
		[
			'build/',
			'-name', '*.coffee',
			'-exec', 'coffee', '--compile', '{}', ';',
			'-exec', 'rm', '{}', ';'
		],
		{ stdio: 'inherit' }
	)

task 'clean', ->
	fs.removeSync 'build'
