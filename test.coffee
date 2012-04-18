# https://github.com/caolan/nodeunit
# http://caolanmcmahon.com/posts/unit_testing_in_node_js

vintage = require './vintage.js'

exports.testEndsWith = (test) ->
  test.ok 'lolcat'.endsWith 'cat'
  test.ok 'lolcat'.endsWith ['fun', 'cat']
  test.ok not 'lolcat'.endsWith 'blah'
  test.ok not 'lolcat'.endsWith 'catlol'
  test.ok not 'lolcat'.endsWith ['fun', 'snap', 'lol']
  test.done()

exports.testDsplit = (test) ->
  test.deepEqual vintage.dsplit('old english'), ['old', ' ', 'english']
  test.deepEqual vintage.dsplit('...'), ['.', '.', '.']
  test.done()

exports.testStartsWith = (test) ->
  test.ok 'catlol'.startsWith 'cat'
  test.ok 'catlol'.startsWith ['fun', 'cat']
  test.ok not 'catlol'.startsWith 'blah'
  test.ok not 'catlol'.startsWith 'lolcat'
  test.ok not 'catlol'.startsWith ['fun', 'snap', 'lol']
  test.done()

exports.testLigatures = (test) ->
  test.equal vintage.ligatures('Aether'), 'Æther'
  test.equal vintage.ligatures('aether'), 'æther'
  test.equal vintage.ligatures('aeaeae'), 'æææ'
  test.equal vintage.ligatures('Oestrogen'), 'Œﬆrogen'
  test.equal vintage.ligatures('oestrogen'), 'œﬆrogen'
  test.equal vintage.ligatures('oeſtrogen'), 'œﬅrogen'
  test.equal vintage.ligatures('insufflate'), 'insuﬄate'
  test.done()

exports.testLongS = (test) ->
  test.equal vintage.long_s('diet'), 'diet'
  test.equal vintage.long_s('sloth'), 'ſloth'
  test.equal vintage.long_s('success'), 'ſucceſs'
  test.done()

exports.testSpellings = (test) ->
  test.equal vintage.spellings('blobio'), 'blobio'
  test.equal vintage.spellings('old'), 'olde'
  test.equal vintage.spellings('Old'), 'Olde'
  test.equal vintage.spellings('OLD'), 'OLDE'
  test.equal vintage.spellings('OLD'), 'OLDE'
  test.equal vintage.spellings('dieted'), 'dyeted'
  test.equal vintage.spellings('Dieted'), 'Dyeted'
  test.equal vintage.spellings('DIETED'), 'DYETED'
  test.equal vintage.spellings('dieting'), 'dyeting'
  test.equal vintage.spellings('Dieting'), 'Dyeting'
  test.equal vintage.spellings('DIETING'), 'DYETING'
  test.done()

exports.testUnamerican = (test) ->
  test.equal vintage.unamerican('color'), 'colour'
  test.equal vintage.unamerican('colour'), 'colour'
  test.equal vintage.unamerican('kilometer'), 'kilometre'
  test.equal vintage.unamerican('kilometers'), 'kilometres'
  test.equal vintage.unamerican('estrogen'), 'oestrogen'
  test.equal vintage.unamerican('normalize'), 'normalise'
  test.equal vintage.unamerican('normalized'), 'normalised'
  # test.equal vintage.unamerican('normalizing'), 'normalising'  # todo
  test.done()

exports.testTranslate = (test) ->
  transforms = [
    vintage.unamerican, vintage.long_s, vintage.ligatures
    vintage.punctuation, vintage.spellings
  ]
  tr = (text) -> vintage.translate(text, transforms)
  test.equal tr('blobio!'), 'blobio!'
  test.equal tr('old english'), 'olde engliſh'
  test.equal tr('...'), "…"
  test.equal tr('hello...'), "hello…"
  test.equal tr('i want---candy'), "i want—candy"
  test.equal tr('i want -- candy'), "i want – candy"
  test.done()

exports.testMiddleEnglish = (test) ->
  me = (text) -> vintage.translate text, [vintage.middle_english]
  test.equal me("oh my goth"), "oh my goth"
  test.equal me("what, do you have?"), "what, do thou hast?"
  test.equal me('have you cried?'), "hast thou cried?"
  test.equal me('what have you cried?'), "what hast thou cried?"
  test.equal me("what do you have?"), "what hast thou?"
  test.equal me("what    do  you have?"), "what hast thou?"
  test.equal me("what, do you have?"), "what, do thou hast?"
  test.equal me("i began it today"), "i began’t today"
  test.equal me("between"), "’tween"
  test.equal me("you will not pass!"), "thou shan't pass!"
  test.equal me("you"), "thou"
  test.done()
