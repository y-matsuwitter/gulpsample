React = require 'react'
$     = require 'jquery'

Timer = React.createClass
  getInitialState: ->
    secondsElapsed: 0

  tick: ->
    @setState secondsElapsed: @state.secondsElapsed + 1

  componentDidMount: ->
    setInterval @tick, 1000

  render: ->
    (React.DOM.div {}, [
      'Seconds Elapsed: ' + @state.secondsElapsed
    ])

React.renderComponent (Timer {}), document.getElementById("timer")



# todo
{ul, li, div, h3, form, input, button} = React.DOM

TodoList = React.createClass
  render: ->
    createItem = (itemText) ->
      (li {}, [itemText])
    (ul {}, [@props.items.map createItem]);

TodoApp = React.createClass
  getInitialState: ->
    items: []
    text: ''

  handleOnChange: (e) ->
    @setState items: @state.items, text: e.target.value

  handleSubmit: (e) ->
    e.preventDefault()
    nextItems = @state.items.concat [this.state.text]
    nextText = ''
    @setState items: nextItems, text: nextText

  render: ->
    (div {}, [
      (h3 {}, ['TODO']),
      (TodoList {items: @state.items})
      (form {onSubmit: @handleSubmit, className: "form-inline"}, [
        (input {className: "form-control", ref: "text", onChange: @handleOnChange, value: @state.text, placeholder: "Input your task."}),
        (button {className: "btn btn-primary"}, ['Add #' + (@state.items.length + 1)])
      ])
    ])

React.renderComponent (TodoApp {}), document.getElementById("todo")
