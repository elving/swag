Dates = {}

Dates.padNumber = (num, count, padCharacter) ->
    padCharacter = '0'  if typeof padCharacter is 'undefined'
    lenDiff = count - String(num).length
    padding = ''
    padding += padCharacter while lenDiff-- if lenDiff > 0
    padding + num

Dates.dayOfYear = (date) ->
    oneJan = new Date(date.getFullYear(), 0, 1)
    Math.ceil (date - oneJan) / 86400000

Dates.weekOfYear = (date) ->
    oneJan = new Date(date.getFullYear(), 0, 1)
    Math.ceil (((date - oneJan) / 86400000) + oneJan.getDay() + 1) / 7

Dates.isoWeekOfYear = (date) ->
    target = new Date(date.valueOf())
    dayNr = (date.getDay() + 6) % 7
    target.setDate target.getDate() - dayNr + 3
    jan4 = new Date(target.getFullYear(), 0, 4)
    dayDiff = (target - jan4) / 86400000
    1 + Math.ceil(dayDiff / 7)

Dates.tweleveHour = (date) ->
    if date.getHours() > 12 then date.getHours() - 12 else date.getHours()

Dates.timeZoneOffset = (date) ->
    hoursDiff = (-date.getTimezoneOffset() / 60)
    result = Dates.padNumber Math.abs(hoursDiff), 4
    (if hoursDiff > 0 then '+' else '-') + result

Dates.format = (date, format) ->
    format.replace Dates.formats, (m, p) ->
        switch p
            when 'a' then Dates.abbreviatedWeekdays[date.getDay()]
            when 'A' then Dates.fullWeekdays[date.getDay()]
            when 'b' then Dates.abbreviatedMonths[date.getMonth()]
            when 'B' then Dates.fullMonths[date.getMonth()]
            when 'c' then date.toLocaleString()
            when 'C' then Math.round date.getFullYear() / 100
            when 'd' then Dates.padNumber date.getDate(), 2
            when 'D' then Dates.format date, '%m/%d/%y'
            when 'e' then Dates.padNumber date.getDate(), 2, ' '
            when 'F' then Dates.format date, '%Y-%m-%d'
            when 'h' then Dates.format date, '%b'
            when 'H' then Dates.padNumber date.getHours(), 2
            when 'I' then Dates.padNumber Dates.tweleveHour(date), 2
            when 'j' then Dates.padNumber Dates.dayOfYear(date), 3
            when 'k' then Dates.padNumber date.getHours(), 2, ' '
            when 'l' then Dates.padNumber Dates.tweleveHour(date), 2, ' '
            when 'L' then Dates.padNumber date.getMilliseconds(), 3
            when 'm' then Dates.padNumber date.getMonth() + 1, 2
            when 'M' then Dates.padNumber date.getMinutes(), 2
            when 'n' then '\n'
            when 'p' then (if date.getHours() > 11 then 'PM' else 'AM')
            when 'P' then Dates.format(date, '%p').toLowerCase()
            when 'r' then Dates.format date, '%I:%M:%S %p'
            when 'R' then Dates.format date, '%H:%M'
            when 's' then date.getTime() / 1000
            when 'S' then Dates.padNumber date.getSeconds(), 2
            when 't' then '\t'
            when 'T' then Dates.format date, '%H:%M:%S'
            when 'u' then (if date.getDay() is 0 then 7 else date.getDay())
            when 'U' then Dates.padNumber Dates.weekOfYear(date), 2
            when 'v' then Dates.format date, '%e-%b-%Y'
            when 'V' then Dates.padNumber Dates.isoWeekOfYear(date), 2
            when 'W' then Dates.padNumber Dates.weekOfYear(date), 2
            when 'w' then Dates.padNumber date.getDay(), 2
            when 'x' then date.toLocaleDateString()
            when 'X' then date.toLocaleTimeString()
            when 'y' then String(date.getFullYear()).substring 2
            when 'Y' then date.getFullYear()
            when 'z' then Dates.timeZoneOffset date
            else match

Dates.formats = /%(a|A|b|B|c|C|d|D|e|F|h|H|I|j|k|l|L|m|M|n|p|P|r|R|s|S|t|T|u|U|v|V|W|w|x|X|y|Y|z)/g
Dates.abbreviatedWeekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat']
Dates.fullWeekdays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
Dates.abbreviatedMonths = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
Dates.fullMonths = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

# Port of formatDate-js library - https://github.com/michaelbaldry/formatDate-js
Handlebars.registerHelper 'formatDate', (date, format) ->
    date = new Date date
    Dates.format date, format

Handlebars.registerHelper 'now', (format) ->
    date = new Date()
    if Utils.isUndefined(format) then date else Dates.format(date, format)

# Modified version of - http://stackoverflow.com/a/3177838
Handlebars.registerHelper 'timeago', (date) ->
    date = new Date date
    seconds = Math.floor((new Date() - date) / 1000)
    
    interval = Math.floor(seconds / 31536000)
    return "#{interval} years ago" if interval > 1
    interval = Math.floor(seconds / 2592000)
    return if interval ==1 then "about a month ago"
    return if interval > 1 then "#{interval} months ago"
    interval = Math.floor(seconds / 86400)
    return if interval ==1 then "about a day ago"
    return if interval > 1 then "#{interval} days ago"
    interval = Math.floor(seconds / 3600)
    return if interval ==1 then "about an hour ago"
    return if interval > 1 then "#{interval} hours ago"
    interval = Math.floor(seconds / 60)
    return if interval ==1 then "about a minute ago"
    return if interval > 1 then "#{interval} minutes ago"
    if Math.floor(seconds) is 0 then 'just now' else Math.floor(seconds) + ' seconds ago'
    
# Converts date strings into human readable formats like "Yesterday at 1:26 PM"
Handlebars.registerHelper 'friendlydate', (dateString) ->
    # parse dateString or fail gracefully
    date = new Date(dateString)
    if date.toString() is 'Invalid Date'
      date = new Date(parseInt(dateString, 10)) # timestamp
    if date.toString() is 'Invalid Date'
      console.error "Handlebars helper friendlydate couldn't parse date '#{dateString}'"
      return dateString
    
    today = new Date()
    month = ['January','February','March', 'April', 'May', 'June', 'July', 'August', 'September', 'October ', 'November', 'December'][date.getMonth()]
    dayName = [ 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][date.getDay()]
    hours = date.getHours()
    hours = hours - 12 if hours > 12 # 0:17 AM seems clearer than 12:17 AM for midnight
    mins = ('0'+date.getMinutes()).substr(-2,2)
    ampm = if date.getHours() >= 12 then 'PM' else 'AM'
    
    # Today at XX:XX PM
    if date.getDate() is today.getDate() 
      return "Today at #{hours}:#{mins} #{ampm}" # TODO: capitalization solution. Does user want "today" or "Today"?
    
    # Yesterday at XX:XX PM
    yesterday = new Date()
    yesterday.setDate(today.getDate()-1)
    if date.getDate() is yesterday.getDate()
      return "Yesterday at #{hours}:#{mins} #{ampm}"
    
    # Thursday at XX:XX AM
    sixDaysAgo = new Date()
    sixDaysAgo.setDate(today.getDate()-6)
    sixDaysAgo.setHours(0)
    sixDaysAgo.setMinutes(0)
    sixDaysAgo.setSeconds(0)
    if date > sixDaysAgo
      return "#{dayName} at #{hours}:#{mins} #{ampm}"
    
    year = date.getFullYear()
    day = date.getDate()
    # July 19 at XX:XX AM
    if year is today.getFullYear()
      return "#{month} #{day} at #{hours}:#{mins} #{ampm}"
    
    # June 10, 2012 at XX:XX PM
    return "#{month} #{day}, #{year} at #{hours}:#{mins} #{ampm}"
