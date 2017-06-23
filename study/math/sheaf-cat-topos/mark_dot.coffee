fs = require 'fs'
fn = process.argv[2]
{exec} = require 'child_process'

code = (fn.split '.')[... -1].join '.'

lines = fs.readFileSync(fn, 'utf8').split '\n'

jump_to = (lines, i) ->
  ++i while (lines[i] isnt '```')
  i

draw = do ->
  id = 0
  (dot) ->
    dot_path = "./img/#{code}.#{id}.dot"
    png_path = "./img/#{code}.#{id}.png"
    ++id
    content = dot.join('\n') + '\n'
    fs.writeFileSync dot_path, content
    exec "dot -Tpng #{dot_path} > #{png_path}"
    console.warn "dot -Tpng #{dot_path} > #{png_path}"
    "![](#{png_path})"

i = 0
while i < lines.length
  ln = lines[i]
  if ln is '```dot'
    j = jump_to lines, i
    dot = lines.slice(i + 1, j)
    img = draw dot
    i = j
    console.log img
  else
    console.log ln

  ++i
  
