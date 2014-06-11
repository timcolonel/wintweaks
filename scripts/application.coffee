jade = require('jade')
fs = require('fs')
stylus = require('stylus')

#Render a jade template
render = (filename, params = {}) ->
  template = fs.readFileSync(filename, 'utf-8')
  fn = jade.compile(template)
  fn(params)

#Compile stylus file and return output
compile_stylus = (filename, output = null) ->
  unless output
    section = filename.split('.')
    if section[-2] == 'css'
      output_filename = section[0..-1].join('.')
    else
      output_filename = "#{section[0..-1].join('.')}.css"

    output = "stylesheet/css/#{output_filename}"
  template = fs.readFileSync(filename, 'utf-8')
  stylus.render(template).set('filename', output)
  output

stylesheet_tag = (filename) ->
  extension = filename.split('.').pop()
  file_output = switch extension
    when 'jade'
      compile_stylus(filename)
    when 'css'
      filename
    else
      filename
  """
    <link href="#{file_output}" rel="stylesheet/css" type="text/css"/>
  """


window.render = render