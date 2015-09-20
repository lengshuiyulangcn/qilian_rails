# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@HelloMessage = React.createClass
  getInitialState: ->
    records: @props.data
  render: ->
    React.DOM.div
      className: 'records'
      React.DOM.h2
        className: 'title'
        @props.name
