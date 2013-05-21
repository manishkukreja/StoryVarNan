(function() {
  var deleteQuery, loadQuery, onChangeToQueryList, saveQuery, savedQueriesInit;

  jQuery(function() {
    return savedQueriesInit();
  });

  savedQueriesInit = function() {
    $('.wice-grid-save-query-field').keydown(function(event) {
      if (event.keyCode === 13) {
        return saveQuery($(this).next(), event);
      }
    });
    $(".wice-grid-save-query-button").click(function(event) {
      return saveQuery(this, event);
    });
    $(".wice-grid-delete-query").click(function(event) {
      return deleteQuery(this, event);
    });
    return $(".wice-grid-query-load-link").click(function(event) {
      return loadQuery(this, event);
    });
  };

  loadQuery = function(loadLink, event) {
    var gridProcessor, queryId, request;

    if (gridProcessor = window.getGridProcessorForElement(loadLink)) {
      queryId = $(loadLink).data('query-id');
      request = gridProcessor.appendToUrl(gridProcessor.buildUrlWithParams(), gridProcessor.parameterNameForQueryLoading + encodeURIComponent(queryId));
      window.location = request;
    }
    event.preventDefault();
    event.stopPropagation();
    return false;
  };

  deleteQuery = function(deleteQueryButton, event) {
    var confirmation, gridProcessor, invokeConfirmation;

    confirmation = $(deleteQueryButton).data('wg-confirm');
    invokeConfirmation = confirmation ? function() {
      return confirm(confirmation);
    } : function() {
      return true;
    };
    if (invokeConfirmation() && (gridProcessor = window.getGridProcessorForElement(deleteQueryButton))) {
      jQuery.ajax({
        url: $(deleteQueryButton).attr('href'),
        async: true,
        dataType: 'json',
        success: function(data, textStatus, jqXHR) {
          return onChangeToQueryList(data, gridProcessor.name);
        },
        type: 'POST'
      });
    }
    event.preventDefault();
    event.stopPropagation();
    return false;
  };

  saveQuery = function(saveQueryButton, event) {
    var basePathToQueryController, gridProcessor, gridState, inputField, inputIds, queryName, requestPath, _saveQueryButton;

    if (gridProcessor = window.getGridProcessorForElement(saveQueryButton)) {
      _saveQueryButton = $(saveQueryButton);
      basePathToQueryController = _saveQueryButton.data('base-path-to-query-controller');
      gridState = _saveQueryButton.data('parameters');
      inputIds = _saveQueryButton.data('ids');
      inputField = _saveQueryButton.prev();
      if (inputIds instanceof Array) {
        inputIds.each(function(domId) {
          return gridState.push(['extra[' + domId + ']', $('#' + domId).val()]);
        });
      }
      queryName = inputField.val();
      requestPath = gridProcessor.gridStateToRequest(gridState);
      jQuery.ajax({
        url: basePathToQueryController,
        async: true,
        data: requestPath + '&query_name=' + encodeURIComponent(queryName),
        dataType: 'json',
        success: function(data, textStatus, jqXHR) {
          return onChangeToQueryList(data, gridProcessor.name, queryName, inputField);
        },
        type: 'POST'
      });
      event.preventDefault();
      return false;
    }
  };

  onChangeToQueryList = function(data, gridName, queryName, inputField) {
    var errorMessages, gridTitleId, notificationMessages, notificationMessagesDomId, queryListId;

    notificationMessagesDomId = "#" + gridName + "_notification_messages";
    gridTitleId = "#" + gridName + "_title";
    queryListId = "#" + gridName + "_query_list";
    if (queryName) {
      inputField.val('');
    }
    if (errorMessages = data['error_messages']) {
      return $(notificationMessagesDomId).text(errorExplanation);
    } else {
      if (notificationMessages = data['notification_messages']) {
        $(notificationMessagesDomId).text(notificationMessages);
      }
      if (queryName) {
        $(gridTitleId).html("<h3>" + queryName + "</h3>");
      }
      $(queryListId).replaceWith(data['query_list']);
      $(queryListId).effect('highlight');
      $(".wice-grid-delete-query", $(queryListId)).click(function(event) {
        return deleteQuery(this, event);
      });
      return $(".wice-grid-query-load-link", $(queryListId)).click(function(event) {
        return loadQuery(this, event);
      });
    }
  };

}).call(this);
