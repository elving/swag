/*
    Swag v0.6.1 <http://elving.github.com/swag/>
    Copyright 2012 Elving Rodriguez <http://elving.me/>
    Available under MIT license <https://raw.github.com/elving/swag/master/LICENSE>
*/


(function() {
  var Dates, HTML, Swag, Utils,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  if (typeof window !== "undefined" && window !== null) {
    window.Swag = Swag = {};
  } else if (typeof module !== "undefined" && module !== null) {
    module.exports = Swag = {};
  }

  Swag.helpers = {};

  Swag.addHelper = function(name, helper, argTypes) {
    if (argTypes == null) {
      argTypes = [];
    }
    if (!(argTypes instanceof Array)) {
      argTypes = [argTypes];
    }
    return Swag.helpers[name] = function() {
      var arg, args, resultArgs, _i, _len;
      Utils.verify(name, arguments, argTypes);
      args = Array.prototype.slice.apply(arguments);
      resultArgs = [];
      for (_i = 0, _len = args.length; _i < _len; _i++) {
        arg = args[_i];
        if (!Utils.isHandlebarsSpecific(arg)) {
          arg = Utils.result(arg);
        }
        resultArgs.push(arg);
      }
      return helper.apply(this, resultArgs);
    };
  };

  Swag.registerHelpers = function(localHandlebars) {
    var helper, name, _ref, _results;
    if (localHandlebars) {
      Swag.Handlebars = localHandlebars;
    } else {
      if (typeof window !== "undefined" && window !== null) {
        if (window.Ember != null) {
          Swag.Handlebars = Ember.Handlebars;
        } else {
          Swag.Handlebars = window.Handlebars;
        }
      } else if (typeof module !== "undefined" && module !== null) {
        Swag.Handlebars = require('handlebars');
      }
    }
    Swag.registerHelper = function(name, helper) {
      if ((typeof window !== "undefined" && window !== null) && window.Ember) {
        return Swag.Handlebars.helper(name, helper);
      } else {
        return Swag.Handlebars.registerHelper(name, helper);
      }
    };
    _ref = Swag.helpers;
    _results = [];
    for (name in _ref) {
      helper = _ref[name];
      _results.push(Swag.registerHelper(name, helper));
    }
    return _results;
  };

  Swag.Config = {
    partialsPath: '',
    precompiledTemplates: true
  };

  Utils = {};

  Utils.isHandlebarsSpecific = function(value) {
    return (value && (value.fn != null)) || (value && (value.hash != null));
  };

  Utils.isUndefined = function(value) {
    return (value === void 0 || value === null) || Utils.isHandlebarsSpecific(value);
  };

  Utils.safeString = function(str) {
    return new Swag.Handlebars.SafeString(str);
  };

  Utils.trim = function(str) {
    var trim;
    trim = /\S/.test("\xA0") ? /^[\s\xA0]+|[\s\xA0]+$/g : /^\s+|\s+$/g;
    return str.toString().replace(trim, '');
  };

  Utils.isFunc = function(value) {
    return typeof value === 'function';
  };

  Utils.isString = function(value) {
    return typeof value === 'string';
  };

  Utils.result = function(value) {
    if (Utils.isFunc(value)) {
      return value();
    } else {
      return value;
    }
  };

  Utils.err = function(msg) {
    throw new Error(msg);
  };

  Utils.verify = function(name, fnArg, argTypes) {
    var arg, i, msg, _i, _len, _results;
    if (argTypes == null) {
      argTypes = [];
    }
    fnArg = Array.prototype.slice.apply(fnArg).slice(0, argTypes.length);
    _results = [];
    for (i = _i = 0, _len = fnArg.length; _i < _len; i = ++_i) {
      arg = fnArg[i];
      msg = '{{' + name + '}} requires ' + argTypes.length + ' arguments ' + argTypes.join(', ') + '.';
      if (argTypes[i].indexOf('safe:') > -1) {
        if (Utils.isHandlebarsSpecific(arg)) {
          _results.push(Utils.err(msg));
        } else {
          _results.push(void 0);
        }
      } else {
        if (Utils.isUndefined(arg)) {
          _results.push(Utils.err(msg));
        } else {
          _results.push(void 0);
        }
      }
    }
    return _results;
  };

  Swag.addHelper('lowercase', function(str) {
    return str.toLowerCase();
  }, 'string');

  Swag.addHelper('uppercase', function(str) {
    return str.toUpperCase();
  }, 'string');

  Swag.addHelper('capitalizeFirst', function(str) {
    return str.charAt(0).toUpperCase() + str.slice(1);
  }, 'string');

  Swag.addHelper('capitalizeEach', function(str) {
    return str.replace(/\w\S*/g, function(txt) {
      return txt.charAt(0).toUpperCase() + txt.substr(1);
    });
  }, 'string');

  Swag.addHelper('titleize', function(str) {
    var capitalize, title, word, words;
    title = str.replace(/[ \-_]+/g, ' ');
    words = title.match(/\w+/g) || [];
    capitalize = function(word) {
      return word.charAt(0).toUpperCase() + word.slice(1);
    };
    return ((function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = words.length; _i < _len; _i++) {
        word = words[_i];
        _results.push(capitalize(word));
      }
      return _results;
    })()).join(' ');
  }, 'string');

  Swag.addHelper('sentence', function(str) {
    return str.replace(/((?:\S[^\.\?\!]*)[\.\?\!]*)/g, function(txt) {
      return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
    });
  }, 'string');

  Swag.addHelper('reverse', function(str) {
    return str.split('').reverse().join('');
  }, 'string');

  Swag.addHelper('truncate', function(str, length, omission) {
    if (Utils.isUndefined(omission)) {
      omission = '';
    }
    if (str.length > length) {
      return str.substring(0, length - omission.length) + omission;
    } else {
      return str;
    }
  }, ['string', 'number']);

  Swag.addHelper('center', function(str, spaces) {
    var i, space;
    spaces = Utils.result(spaces);
    space = '';
    i = 0;
    while (i < spaces) {
      space += '&nbsp;';
      i++;
    }
    return "" + space + str + space;
  }, 'string');

  Swag.addHelper('newLineToBr', function(str) {
    return str.replace(/\r?\n|\r/g, '<br>');
  }, 'string');

  Swag.addHelper('sanitize', function(str, replaceWith) {
    if (Utils.isUndefined(replaceWith)) {
      replaceWith = '-';
    }
    return str.replace(/[^a-z0-9]/gi, replaceWith);
  }, 'string');

  Swag.addHelper('first', function(array, count) {
    if (!Utils.isUndefined(count)) {
      count = parseFloat(count);
    }
    if (Utils.isUndefined(count)) {
      return array[0];
    } else {
      return array.slice(0, count);
    }
  }, 'array');

  Swag.addHelper('withFirst', function(array, count, options) {
    var item, result;
    if (!Utils.isUndefined(count)) {
      count = parseFloat(count);
    }
    if (Utils.isUndefined(count)) {
      options = count;
      return options.fn(array[0]);
    } else {
      array = array.slice(0, count);
      result = '';
      for (item in array) {
        result += options.fn(array[item]);
      }
      return result;
    }
  }, 'array');

  Swag.addHelper('last', function(array, count) {
    if (!Utils.isUndefined(count)) {
      count = parseFloat(count);
    }
    if (Utils.isUndefined(count)) {
      return array[array.length - 1];
    } else {
      return array.slice(-count);
    }
  }, 'array');

  Swag.addHelper('withLast', function(array, count, options) {
    var item, result;
    if (!Utils.isUndefined(count)) {
      count = parseFloat(count);
    }
    if (Utils.isUndefined(count)) {
      options = count;
      return options.fn(array[array.length - 1]);
    } else {
      array = array.slice(-count);
      result = '';
      for (item in array) {
        result += options.fn(array[item]);
      }
      return result;
    }
  }, 'array');

  Swag.addHelper('after', function(array, count) {
    if (!Utils.isUndefined(count)) {
      count = parseFloat(count);
    }
    return array.slice(count);
  }, ['array', 'number']);

  Swag.addHelper('withAfter', function(array, count, options) {
    var item, result;
    if (!Utils.isUndefined(count)) {
      count = parseFloat(count);
    }
    array = array.slice(count);
    result = '';
    for (item in array) {
      result += options.fn(array[item]);
    }
    return result;
  }, ['array', 'number']);

  Swag.addHelper('before', function(array, count) {
    if (!Utils.isUndefined(count)) {
      count = parseFloat(count);
    }
    return array.slice(0, -count);
  }, ['array', 'number']);

  Swag.addHelper('withBefore', function(array, count, options) {
    var item, result;
    if (!Utils.isUndefined(count)) {
      count = parseFloat(count);
    }
    array = array.slice(0, -count);
    result = '';
    for (item in array) {
      result += options.fn(array[item]);
    }
    return result;
  }, ['array', 'number']);

  Swag.addHelper('join', function(array, separator) {
    return array.join(Utils.isUndefined(separator) ? ' ' : separator);
  }, 'array');

  Swag.addHelper('sort', function(array, field) {
    if (Utils.isUndefined(field)) {
      return array.sort();
    } else {
      return array.sort(function(a, b) {
        return a[field] > b[field];
      });
    }
  }, 'array');

  Swag.addHelper('withSort', function(array, field, options) {
    var item, result, _i, _len;
    result = '';
    if (Utils.isUndefined(field)) {
      options = field;
      array = array.sort();
      for (_i = 0, _len = array.length; _i < _len; _i++) {
        item = array[_i];
        result += options.fn(item);
      }
    } else {
      array = array.sort(function(a, b) {
        return a[field] > b[field];
      });
      for (item in array) {
        result += options.fn(array[item]);
      }
    }
    return result;
  }, 'array');

  Swag.addHelper('length', function(array) {
    return array.length;
  }, 'array');

  Swag.addHelper('lengthEqual', function(array, length, options) {
    if (!Utils.isUndefined(length)) {
      length = parseFloat(length);
    }
    if (array.length === length) {
      return options.fn(this);
    } else {
      return options.inverse(this);
    }
  }, ['array', 'number']);

  Swag.addHelper('empty', function(array, options) {
    if (!array || array.length <= 0) {
      return options.fn(this);
    } else {
      return options.inverse(this);
    }
  }, 'safe:array');

  Swag.addHelper('any', function(array, options) {
    if (array && array.length > 0) {
      return options.fn(this);
    } else {
      return options.inverse(this);
    }
  }, 'safe:array');

  Swag.addHelper('inArray', function(array, value, options) {
    if (__indexOf.call(array, value) >= 0) {
      return options.fn(this);
    } else {
      return options.inverse(this);
    }
  }, ['array', 'string|number']);

  Swag.addHelper('eachIndex', function(array, options) {
    var index, result, value, _i, _len;
    result = '';
    for (index = _i = 0, _len = array.length; _i < _len; index = ++_i) {
      value = array[index];
      result += options.fn({
        item: value,
        index: index
      });
    }
    return result;
  }, 'array');

  Swag.addHelper('eachProperty', function(obj, options) {
    var key, result, value;
    result = '';
    for (key in obj) {
      value = obj[key];
      result += options.fn({
        key: key,
        value: value
      });
    }
    return result;
  }, 'object');

  Swag.addHelper('add', function(value, addition) {
    value = parseFloat(value);
    addition = parseFloat(addition);
    return value + addition;
  }, ['number', 'number']);

  Swag.addHelper('subtract', function(value, substraction) {
    value = parseFloat(value);
    substraction = parseFloat(substraction);
    return value - substraction;
  }, ['number', 'number']);

  Swag.addHelper('divide', function(value, divisor) {
    value = parseFloat(value);
    divisor = parseFloat(divisor);
    return value / divisor;
  }, ['number', 'number']);

  Swag.addHelper('multiply', function(value, multiplier) {
    value = parseFloat(value);
    multiplier = parseFloat(multiplier);
    return value * multiplier;
  }, ['number', 'number']);

  Swag.addHelper('floor', function(value) {
    value = parseFloat(value);
    return Math.floor(value);
  }, 'number');

  Swag.addHelper('ceil', function(value) {
    value = parseFloat(value);
    return Math.ceil(value);
  }, 'number');

  Swag.addHelper('round', function(value) {
    value = parseFloat(value);
    return Math.round(value);
  }, 'number');

  Swag.addHelper('toFixed', function(number, digits) {
    number = parseFloat(number);
    digits = Utils.isUndefined(digits) ? 0 : digits;
    return number.toFixed(digits);
  }, 'number');

  Swag.addHelper('toPrecision', function(number, precision) {
    number = parseFloat(number);
    precision = Utils.isUndefined(precision) ? 1 : precision;
    return number.toPrecision(precision);
  }, 'number');

  Swag.addHelper('toExponential', function(number, fractions) {
    number = parseFloat(number);
    fractions = Utils.isUndefined(fractions) ? 0 : fractions;
    return number.toExponential(fractions);
  }, 'number');

  Swag.addHelper('toInt', function(number) {
    return parseInt(number, 10);
  }, 'number');

  Swag.addHelper('toFloat', function(number) {
    return parseFloat(number);
  }, 'number');

  Swag.addHelper('digitGrouping', function(number, separator) {
    number = parseFloat(number);
    separator = Utils.isUndefined(separator) ? ',' : separator;
    return number.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1" + separator);
  }, 'number');

  Swag.addHelper('is', function(value, test, options) {
    if (value && value === test) {
      return options.fn(this);
    } else {
      return options.inverse(this);
    }
  }, ['safe:string|number', 'safe:string|number']);

  Swag.addHelper('isnt', function(value, test, options) {
    if (!value || value !== test) {
      return options.fn(this);
    } else {
      return options.inverse(this);
    }
  }, ['safe:string|number', 'safe:string|number']);

  Swag.addHelper('gt', function(value, test, options) {
    if (value > test) {
      return options.fn(this);
    } else {
      return options.inverse(this);
    }
  }, ['safe:string|number', 'safe:string|number']);

  Swag.addHelper('gte', function(value, test, options) {
    if (value >= test) {
      return options.fn(this);
    } else {
      return options.inverse(this);
    }
  }, ['safe:string|number', 'safe:string|number']);

  Swag.addHelper('lt', function(value, test, options) {
    if (value < test) {
      return options.fn(this);
    } else {
      return options.inverse(this);
    }
  }, ['safe:string|number', 'safe:string|number']);

  Swag.addHelper('lte', function(value, test, options) {
    if (value <= test) {
      return options.fn(this);
    } else {
      return options.inverse(this);
    }
  }, ['safe:string|number', 'safe:string|number']);

  Swag.addHelper('or', function(testA, testB, options) {
    if (testA || testB) {
      return options.fn(this);
    } else {
      return options.inverse(this);
    }
  }, ['safe:string|number', 'safe:string|number']);

  Swag.addHelper('and', function(testA, testB, options) {
    if (testA && testB) {
      return options.fn(this);
    } else {
      return options.inverse(this);
    }
  }, ['safe:string|number', 'safe:string|number']);

  Dates = {};

  Dates.padNumber = function(num, count, padCharacter) {
    var lenDiff, padding;
    if (typeof padCharacter === 'undefined') {
      padCharacter = '0';
    }
    lenDiff = count - String(num).length;
    padding = '';
    if (lenDiff > 0) {
      while (lenDiff--) {
        padding += padCharacter;
      }
    }
    return padding + num;
  };

  Dates.dayOfYear = function(date) {
    var oneJan;
    oneJan = new Date(date.getFullYear(), 0, 1);
    return Math.ceil((date - oneJan) / 86400000);
  };

  Dates.weekOfYear = function(date) {
    var oneJan;
    oneJan = new Date(date.getFullYear(), 0, 1);
    return Math.ceil((((date - oneJan) / 86400000) + oneJan.getDay() + 1) / 7);
  };

  Dates.isoWeekOfYear = function(date) {
    var dayDiff, dayNr, jan4, target;
    target = new Date(date.valueOf());
    dayNr = (date.getDay() + 6) % 7;
    target.setDate(target.getDate() - dayNr + 3);
    jan4 = new Date(target.getFullYear(), 0, 4);
    dayDiff = (target - jan4) / 86400000;
    return 1 + Math.ceil(dayDiff / 7);
  };

  Dates.tweleveHour = function(date) {
    if (date.getHours() > 12) {
      return date.getHours() - 12;
    } else {
      return date.getHours();
    }
  };

  Dates.timeZoneOffset = function(date) {
    var hoursDiff, result;
    hoursDiff = -date.getTimezoneOffset() / 60;
    result = Dates.padNumber(Math.abs(hoursDiff), 4);
    return (hoursDiff > 0 ? '+' : '-') + result;
  };

  Dates.format = function(date, format) {
    return format.replace(Dates.formats, function(m, p) {
      switch (p) {
        case 'a':
          return Dates.abbreviatedWeekdays[date.getDay()];
        case 'A':
          return Dates.fullWeekdays[date.getDay()];
        case 'b':
          return Dates.abbreviatedMonths[date.getMonth()];
        case 'B':
          return Dates.fullMonths[date.getMonth()];
        case 'c':
          return date.toLocaleString();
        case 'C':
          return Math.round(date.getFullYear() / 100);
        case 'd':
          return Dates.padNumber(date.getDate(), 2);
        case 'D':
          return Dates.format(date, '%m/%d/%y');
        case 'e':
          return Dates.padNumber(date.getDate(), 2, ' ');
        case 'F':
          return Dates.format(date, '%Y-%m-%d');
        case 'h':
          return Dates.format(date, '%b');
        case 'H':
          return Dates.padNumber(date.getHours(), 2);
        case 'I':
          return Dates.padNumber(Dates.tweleveHour(date), 2);
        case 'j':
          return Dates.padNumber(Dates.dayOfYear(date), 3);
        case 'k':
          return Dates.padNumber(date.getHours(), 2, ' ');
        case 'l':
          return Dates.padNumber(Dates.tweleveHour(date), 2, ' ');
        case 'L':
          return Dates.padNumber(date.getMilliseconds(), 3);
        case 'm':
          return Dates.padNumber(date.getMonth() + 1, 2);
        case 'M':
          return Dates.padNumber(date.getMinutes(), 2);
        case 'n':
          return '\n';
        case 'p':
          if (date.getHours() > 11) {
            return 'PM';
          } else {
            return 'AM';
          }
        case 'P':
          return Dates.format(date, '%p').toLowerCase();
        case 'r':
          return Dates.format(date, '%I:%M:%S %p');
        case 'R':
          return Dates.format(date, '%H:%M');
        case 's':
          return date.getTime() / 1000;
        case 'S':
          return Dates.padNumber(date.getSeconds(), 2);
        case 't':
          return '\t';
        case 'T':
          return Dates.format(date, '%H:%M:%S');
        case 'u':
          if (date.getDay() === 0) {
            return 7;
          } else {
            return date.getDay();
          }
        case 'U':
          return Dates.padNumber(Dates.weekOfYear(date), 2);
        case 'v':
          return Dates.format(date, '%e-%b-%Y');
        case 'V':
          return Dates.padNumber(Dates.isoWeekOfYear(date), 2);
        case 'W':
          return Dates.padNumber(Dates.weekOfYear(date), 2);
        case 'w':
          return Dates.padNumber(date.getDay(), 2);
        case 'x':
          return date.toLocaleDateString();
        case 'X':
          return date.toLocaleTimeString();
        case 'y':
          return String(date.getFullYear()).substring(2);
        case 'Y':
          return date.getFullYear();
        case 'z':
          return Dates.timeZoneOffset(date);
        default:
          return match;
      }
    });
  };

  Dates.formats = /%(a|A|b|B|c|C|d|D|e|F|h|H|I|j|k|l|L|m|M|n|p|P|r|R|s|S|t|T|u|U|v|V|W|w|x|X|y|Y|z)/g;

  Dates.abbreviatedWeekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'];

  Dates.fullWeekdays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

  Dates.abbreviatedMonths = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  Dates.fullMonths = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  Swag.addHelper('formatDate', function(date, format) {
    date = new Date(date);
    return Dates.format(date, format);
  }, ['string|number|date', 'string']);

  Swag.addHelper('now', function(format) {
    var date;
    date = new Date();
    if (Utils.isUndefined(format)) {
      return date;
    } else {
      return Dates.format(date, format);
    }
  });

  Swag.addHelper('timeago', function(date) {
    var interval, seconds;
    date = new Date(date);
    seconds = Math.floor((new Date() - date) / 1000);
    interval = Math.floor(seconds / 31536000);
    if (interval > 1) {
      return "" + interval + " years ago";
    }
    interval = Math.floor(seconds / 2592000);
    if (interval > 1) {
      return "" + interval + " months ago";
    }
    interval = Math.floor(seconds / 86400);
    if (interval > 1) {
      return "" + interval + " days ago";
    }
    interval = Math.floor(seconds / 3600);
    if (interval > 1) {
      return "" + interval + " hours ago";
    }
    interval = Math.floor(seconds / 60);
    if (interval > 1) {
      return "" + interval + " minutes ago";
    }
    if (Math.floor(seconds) === 0) {
      return 'Just now';
    } else {
      return Math.floor(seconds) + ' seconds ago';
    }
  }, 'string|number|date');

  Swag.addHelper('inflect', function(count, singular, plural, include) {
    var word;
    count = parseFloat(count);
    word = count > 1 || count === 0 ? plural : singular;
    if (Utils.isUndefined(include) || include === false) {
      return word;
    } else {
      return "" + count + " " + word;
    }
  }, ['number', 'string', 'string']);

  Swag.addHelper('ordinalize', function(value) {
    var normal, _ref;
    value = parseFloat(value);
    normal = Math.abs(Math.round(value));
    if (_ref = normal % 100, __indexOf.call([11, 12, 13], _ref) >= 0) {
      return "" + value + "th";
    } else {
      switch (normal % 10) {
        case 1:
          return "" + value + "st";
        case 2:
          return "" + value + "nd";
        case 3:
          return "" + value + "rd";
        default:
          return "" + value + "th";
      }
    }
  }, 'number');

  HTML = {};

  HTML.parseAttributes = function(hash) {
    return Object.keys(hash).map(function(key) {
      return "" + key + "=\"" + hash[key] + "\"";
    }).join(' ');
  };

  Swag.addHelper('ul', function(context, options) {
    return ("<ul " + (HTML.parseAttributes(options.hash)) + ">") + context.map(function(item) {
      return "<li>" + (options.fn(Utils.result(item))) + "</li>";
    }).join('\n') + "</ul>";
  });

  Swag.addHelper('ol', function(context, options) {
    return ("<ol " + (HTML.parseAttributes(options.hash)) + ">") + context.map(function(item) {
      return "<li>" + (options.fn(Utils.result(item))) + "</li>";
    }).join('\n') + "</ol>";
  });

  Swag.addHelper('br', function(count, options) {
    var br, i;
    br = '<br>';
    if (!Utils.isUndefined(count)) {
      i = 0;
      while (i < (parseFloat(count)) - 1) {
        br += '<br>';
        i++;
      }
    }
    return Utils.safeString(br);
  });

  Swag.addHelper('log', function(value) {
    return console.log(value);
  }, 'string|number|boolean|array|object');

  Swag.addHelper('debug', function(value) {
    console.log('Context: ', this);
    if (!Utils.isUndefined(value)) {
      console.log('Value: ', value);
    }
    return console.log('-----------------------------------------------');
  });

  Swag.addHelper('default', function(value, defaultValue) {
    return value || defaultValue;
  }, 'safe:string|number', 'string|number');

  if (typeof Ember === "undefined" || Ember === null) {
    Swag.addHelper('partial', function(name, data, template) {
      var path;
      path = Swag.Config.partialsPath + name;
      if (Swag.Handlebars.partials[name] == null) {
        if (!Utils.isUndefined(template)) {
          if (Utils.isString(template)) {
            template = Swag.Handlebars.compile(template);
          }
          Swag.Handlebars.registerPartial(name, template);
        } else if ((typeof define !== "undefined" && define !== null) && (Utils.isFunc(define)) && define.amd) {
          if (!Swag.Config.precompiledTemplates) {
            path = "!text" + path;
          }
          require([path], function(template) {
            if (Utils.isString(template)) {
              template = Swag.Handlebars.compile(template);
            }
            return Swag.Handlebars.registerPartial(name, template);
          });
        } else if (typeof require !== "undefined" && require !== null) {
          template = require(path);
          if (Utils.isString(template)) {
            template = Swag.Handlebars.compile(template);
          }
          Swag.Handlebars.registerPartial(name, template);
        } else {
          Utils.err('{{partial}} no amd or commonjs module support found.');
        }
      }
      return Utils.safeString(Swag.Handlebars.partials[name](data));
    }, 'string');
  }

}).call(this);
