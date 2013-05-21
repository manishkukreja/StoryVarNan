(function() {
  var WiceGridProcessor;

  WiceGridProcessor = (function() {
    function WiceGridProcessor(name, baseRequestForFilter, baseLinkForShowAllRecords, linkForExport, parameterNameForQueryLoading, parameterNameForFocus, environment) {
      this.name = name;
      this.baseRequestForFilter = baseRequestForFilter;
      this.baseLinkForShowAllRecords = baseLinkForShowAllRecords;
      this.linkForExport = linkForExport;
      this.parameterNameForQueryLoading = parameterNameForQueryLoading;
      this.parameterNameForFocus = parameterNameForFocus;
      this.environment = environment;
      this.filterDeclarations = new Array();
      this.checkIfJsFrameworkIsLoaded();
    }

    WiceGridProcessor.prototype.checkIfJsFrameworkIsLoaded = function() {
      if (!jQuery) {
        return alert("jQuery not loaded, WiceGrid cannot proceed!");
      }
    };

    WiceGridProcessor.prototype.toString = function() {
      return "<WiceGridProcessor instance for grid '" + this.name + "'>";
    };

    WiceGridProcessor.prototype.process = function(domIdToFocus) {
      return window.location = this.buildUrlWithParams(domIdToFocus);
    };

    WiceGridProcessor.prototype.setProcessTimer = function(domIdToFocus) {
      var processor;

      if (this.timer) {
        clearTimeout(this.timer);
        this.timer = null;
      }
      processor = this;
      return this.timer = setTimeout(function() {
        return processor.process(domIdToFocus);
      }, 1000);
    };

    WiceGridProcessor.prototype.reloadPageForGivenGridState = function(gridState) {
      var requestPath;

      requestPath = this.gridStateToRequest(gridState);
      return window.location = this.appendToUrl(this.baseLinkForShowAllRecords, requestPath);
    };

    WiceGridProcessor.prototype.gridStateToRequest = function(gridState) {
      return jQuery.map(gridState, function(pair) {
        return encodeURIComponent(pair[0]) + '=' + encodeURIComponent(pair[1]);
      }).join('&');
    };

    WiceGridProcessor.prototype.appendToUrl = function(url, str) {
      var sep;

      sep = url.indexOf('?') !== -1 ? /[&\?]$/.exec(url) ? '' : '&' : '?';
      return url + sep + str;
    };

    WiceGridProcessor.prototype.buildUrlWithParams = function(domIdToFocus) {
      var allFilterParams, res, results,
        _this = this;

      results = new Array();
      jQuery.each(this.filterDeclarations, function(i, filterDeclaration) {
        var param;

        param = _this.readValuesAndFormQueryString(filterDeclaration.filterName, filterDeclaration.detached, filterDeclaration.templates, filterDeclaration.ids);
        if (param && param !== '') {
          return results.push(param);
        }
      });
      res = this.baseRequestForFilter;
      if (results.length !== 0) {
        allFilterParams = results.join('&');
        res = this.appendToUrl(res, allFilterParams);
      }
      if (domIdToFocus) {
        res = this.appendToUrl(res, this.parameterNameForFocus + domIdToFocus);
      }
      return res;
    };

    WiceGridProcessor.prototype.reset = function() {
      return window.location = this.baseRequestForFilter;
    };

    WiceGridProcessor.prototype.exportToCsv = function() {
      return window.location = this.linkForExport;
    };

    WiceGridProcessor.prototype.register = function(func) {
      return this.filterDeclarations.push(func);
    };

    WiceGridProcessor.prototype.readValuesAndFormQueryString = function(filterName, detached, templates, ids) {
      var el, i, j, message, res, val, _i, _j, _ref, _ref1;

      res = new Array();
      for (i = _i = 0, _ref = templates.length - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
        if ($(ids[i]) === null) {
          if (this.environment === "development") {
            message = 'WiceGrid: Error reading state of filter "' + filterName + '". No DOM element with id "' + ids[i] + '" found.';
            if (detached) {
              message += 'You have declared "' + filterName + '" as a detached filter but have not output it anywhere in the template. Read documentation about detached filters.';
            }
            alert(message);
          }
          return '';
        }
        el = $('#' + ids[i]);
        if (el[0] && el[0].type === 'checkbox') {
          if (el[0].checked) {
            val = 1;
          }
        } else {
          val = el.val();
        }
        if (val instanceof Array) {
          for (j = _j = 0, _ref1 = val.length - 1; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; j = 0 <= _ref1 ? ++_j : --_j) {
            if (val[j] && val[j] !== "") {
              res.push(templates[i] + encodeURIComponent(val[j]));
            }
          }
        } else if (val && val !== '') {
          res.push(templates[i] + encodeURIComponent(val));
        }
      }
      return res.join('&');
    };

    WiceGridProcessor;

    return WiceGridProcessor;

  })();

  WiceGridProcessor._version = '3.2';

  window['WiceGridProcessor'] = WiceGridProcessor;

}).call(this);
