class StickyNav
  constructor: ->
    $(document).on 'DOMMouseScroll', (e) =>
      if e.originalEvent.detail > 0
        @hideNav()
      else
        @showNav()
      true
    #IE, Opera, Safari
    $(document).on 'mousewheel', (e) =>
      if e.originalEvent.wheelDelta < 0
        @hideNav()
      else
        @showNav()
      true

  showNav: ->
    $('navigation').removeClass('hidden') if $('navigation').hasClass('hidden')

  hideNav: ->
    $('navigation').addClass('hidden') if !$('navigation').hasClass('hidden')

class HiddenEmail
  constructor: ->
    voagyjm = [
      '>'
      'o'
      'f'
      '='
      's'
      's'
      'p'
      't'
      'p'
      't'
      'l'
      '"'
      '='
      '>'
      'e'
      'a'
      'c'
      'h'
      '"'
      'm'
      'k'
      'r'
      'h'
      'n'
      't'
      'm'
      'a'
      'a'
      '.'
      'y'
      'l'
      'a'
      '<'
      'm'
      'c'
      't'
      'u'
      'a'
      '@'
      'h'
      'a'
      'w'
      'l'
      'm'
      't'
      '.'
      'y'
      's'
      'r'
      'h'
      'a'
      ' '
      'h'
      '"'
      'c'
      'h'
      '"'
      'c'
      'z'
      'o'
      '/'
      ' '
      'e'
      ':'
      'i'
      'p'
      'a'
      'o'
      'y'
      'l'
      '@'
      'i'
      '<'
      'p'
      'l'
      'w'
      'k'
      'y'
      'c'
      'h'
      'u'
      's'
      'k'
      'a'
      'c'
      'n'
      'c'
      'k'
      'z'
      'r'
    ]
    ebndtjp = [
      58
      60
      6
      50
      30
      48
      41
      22
      75
      13
      46
      8
      7
      89
      5
      1
      78
      70
      51
      53
      16
      33
      3
      18
      19
      9
      20
      88
      83
      77
      12
      63
      0
      24
      35
      62
      25
      10
      66
      82
      54
      72
      42
      67
      65
      40
      71
      73
      4
      27
      37
      44
      39
      43
      45
      79
      57
      38
      31
      14
      87
      2
      52
      15
      11
      84
      47
      17
      28
      85
      23
      55
      86
      32
      56
      29
      64
      34
      69
      36
      68
      49
      21
      80
      81
      61
      26
      59
      74
      76
    ]
    mqrmanm = new Array
    i=0
    while i < ebndtjp.length
      mqrmanm[ebndtjp[i]] = voagyjm[i]
      i++
    j=0
    result = ''
    while j < mqrmanm.length
      result = result.concat(mqrmanm[j])
      $('#contact-email').html result
      j++

$ ->
  new StickyNav if $('navigation').length > 0
  new HiddenEmail