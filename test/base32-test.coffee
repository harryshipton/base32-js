vows = require 'vows'
assert = require 'assert'
base32 = require '../lib/base32.js'
crypto = require 'crypto'

suite = vows.describe 'Base32 Encoding'

teststring = 'lowercase UPPERCASE 1234567 !@#$%^&*'

suite = suite.addBatch
  'When encoding a test string':
    topic: ->
      base32.encode teststring

    'it has the right value': (topic) ->
      assert.equal topic, 'NRXXOZLSMNQXGZJAKVIFARKSINAVGRJAGEZDGNBVGY3SAIKAEMSCKXRGFI'

    'it decodes to the right value': (topic) ->
      assert.equal base32.decode(topic), teststring

  'When streaming a string to encode':
    topic: ->
      enc = new base32.Encoder
      output = enc.update teststring.substr(0,10)
      output+= enc.update teststring.substr(10)
      output+= enc.finish()
      output

    'it should produce the correct value': (topic) ->
      assert.equal topic, 'NRXXOZLSMNQXGZJAKVIFARKSINAVGRJAGEZDGNBVGY3SAIKAEMSCKXRGFI'

  'When decoding a string with common errors':
    topic: ->
      base32.decode 'NRXXOZLSMNQXGZJAKVIFARKSINAVGRJAGEZDGNBVGY3SAIKAEMSCKXRGFI'

    'it should be the same as the original': (topic) ->
      assert.equal topic, teststring

suite.run()
