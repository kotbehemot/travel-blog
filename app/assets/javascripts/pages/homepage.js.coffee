$ ->
  setInterval ->
    that_moment = moment $('#homepage-timer').data('when')
    diff = that_moment.diff(moment())/1000
    days = Math.floor(diff/(60*60*24))
    hours = Math.floor(diff/(60*60) % (24))
    minutes = Math.floor(diff/60 % 60)
    seconds = Math.floor(diff % 60)
    $('#homepage-timer').html "#{days} : #{("0" + hours).slice (-2)} : #{("0" + minutes).slice (-2)} : #{("0" + seconds).slice (-2)}"
  , 1000
  