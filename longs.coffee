update = (ev) ->
  $("#outtext").val translate $("#intext").val()

$ ->
  $("#intext").keyup update
  $("#intext").bind 'cut paste', update
