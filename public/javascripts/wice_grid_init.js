(function() {
  var focusElementIfNeeded, getGridProcessorForElement, initWiceGrid, setupAutoreloadsForExternalFilters, setupAutoreloadsForInternalFilters, setupBulkToggleForActionColumn, setupCsvExport, setupDatepicker, setupExternalCsvExport, setupExternalSubmitReset, setupHidingShowingOfFilterRow, setupMultiSelectToggle, setupShowingAllRecords, setupSubmitReset;

  jQuery(function() {
    return initWiceGrid();
  });

  initWiceGrid = function() {
    $(".wice-grid-container").each(function(index, wiceGridContainer) {
      var dataDiv, filterDeclaration, filterDeclarations, gridName, gridProcessor, processorInitializerArguments, _fn, _i, _len;

      gridName = wiceGridContainer.id;
      dataDiv = $(".wg-data", wiceGridContainer);
      processorInitializerArguments = dataDiv.data("processor-initializer-arguments");
      filterDeclarations = dataDiv.data("filter-declarations");
      focusElementIfNeeded(dataDiv.data("foc"));
      gridProcessor = new WiceGridProcessor(gridName, processorInitializerArguments[0], processorInitializerArguments[1], processorInitializerArguments[2], processorInitializerArguments[3], processorInitializerArguments[4], processorInitializerArguments[5]);
      _fn = function(filterDeclaration) {
        return gridProcessor.register({
          filterName: filterDeclaration.filterName,
          detached: filterDeclaration.detached,
          templates: filterDeclaration.declaration.templates,
          ids: filterDeclaration.declaration.ids
        });
      };
      for (_i = 0, _len = filterDeclarations.length; _i < _len; _i++) {
        filterDeclaration = filterDeclarations[_i];
        _fn(filterDeclaration);
      }
      window[gridName] = gridProcessor;
      setupDatepicker();
      setupSubmitReset(wiceGridContainer, gridProcessor);
      setupCsvExport(wiceGridContainer, gridProcessor);
      setupHidingShowingOfFilterRow(wiceGridContainer);
      setupShowingAllRecords(wiceGridContainer, gridProcessor);
      setupMultiSelectToggle(wiceGridContainer);
      setupAutoreloadsForInternalFilters(wiceGridContainer, gridProcessor);
      return setupBulkToggleForActionColumn(wiceGridContainer);
    });
    setupAutoreloadsForExternalFilters();
    setupExternalSubmitReset();
    return setupExternalCsvExport();
  };

  setupDatepicker = function() {
    var locale;

    if ($('.wice-grid-container input.check-for-datepicker[type=hidden], .wg-detached-filter input.check-for-datepicker[type=hidden]').length !== 0) {
      if (!$.datepicker) {
        alert("Seems like you do not have jQuery datepicker (http://jqueryui.com/demos/datepicker/)\ninstalled. Either install it or set Wice::Defaults::HELPER_STYLE to :standard in\nwice_grid_config.rb in order to use standard Rails date helpers");
      }
    }
    if (locale = $('.wice-grid-container input[type=hidden], .wg-detached-filter input[type=hidden]').data('locale')) {
      $.datepicker.setDefaults($.datepicker.regional[locale]);
    }
    return $('.wice-grid-container .date-label, .wg-detached-filter .date-label').each(function(index, removeLink) {
      var datepickerHiddenField, eventToTriggerOnChange, that;

      datepickerHiddenField = $('#' + $(removeLink).data('dom-id'));
      eventToTriggerOnChange = datepickerHiddenField.data('close-calendar-event-name');
      $(removeLink).click(function(event) {
        $(this).html('');
        datepickerHiddenField.val('');
        if (eventToTriggerOnChange) {
          datepickerHiddenField.trigger(eventToTriggerOnChange);
        }
        event.preventDefault();
        return false;
      });
      that = this;
      return datepickerHiddenField.datepicker({
        firstDay: 1,
        showOn: "button",
        dateFormat: datepickerHiddenField.data('date-format'),
        buttonImage: datepickerHiddenField.data('button-image'),
        buttonImageOnly: true,
        buttonText: datepickerHiddenField.data('button-text'),
        changeMonth: true,
        changeYear: true,
        onSelect: function(dateText, inst) {
          $(that).html(dateText);
          if (eventToTriggerOnChange) {
            return datepickerHiddenField.trigger(eventToTriggerOnChange);
          }
        }
      });
    });
  };

  setupHidingShowingOfFilterRow = function(wiceGridContainer) {
    var filterRow, hideFilter, showFilter;

    hideFilter = '.wg-hide-filter';
    showFilter = '.wg-show-filter';
    filterRow = '.wg-filter-row';
    $(hideFilter, wiceGridContainer).click(function() {
      $(this).hide();
      $(showFilter, wiceGridContainer).show();
      return $(filterRow, wiceGridContainer).hide();
    });
    return $(showFilter, wiceGridContainer).click(function() {
      $(this).hide();
      $(hideFilter, wiceGridContainer).show();
      return $(filterRow, wiceGridContainer).show();
    });
  };

  setupCsvExport = function(wiceGridContainer, gridProcessor) {
    return $('.export-to-csv-button', wiceGridContainer).click(function() {
      return gridProcessor.exportToCsv();
    });
  };

  setupSubmitReset = function(wiceGridContainer, gridProcessor) {
    $('.submit', wiceGridContainer).click(function() {
      return gridProcessor.process();
    });
    $('.reset', wiceGridContainer).click(function() {
      return gridProcessor.reset();
    });
    return $('.wg-filter-row input[type=text]', wiceGridContainer).keydown(function(event) {
      if (event.keyCode === 13) {
        event.preventDefault();
        return gridProcessor.process();
      }
    });
  };

  focusElementIfNeeded = function(focusId) {
    var elToFocus, elements;

    elements = $('#' + focusId);
    if (elToFocus = elements[0]) {
      elToFocus.value = elToFocus.value;
      return elToFocus.focus();
    }
  };

  setupAutoreloadsForInternalFilters = function(wiceGridContainer, gridProcessor) {
    $('select.auto-reload', wiceGridContainer).change(function() {
      return gridProcessor.process();
    });
    $('input.auto-reload', wiceGridContainer).keyup(function() {
      return gridProcessor.setProcessTimer(this.id);
    });
    $('input.negation-checkbox.auto-reload', wiceGridContainer).click(function() {
      return gridProcessor.process();
    });
    return $(document).bind('wg:calendarChanged_' + gridProcessor.name, function() {
      return gridProcessor.process();
    });
  };

  setupAutoreloadsForExternalFilters = function() {
    return $('.wg-detached-filter').each(function(index, detachedFilterContainer) {
      var gridProcessor;

      gridProcessor = getGridProcessorForElement(detachedFilterContainer);
      if (gridProcessor) {
        $('select.auto-reload', detachedFilterContainer).change(function() {
          return gridProcessor.process();
        });
        $('input.auto-reload', detachedFilterContainer).keyup(function() {
          return gridProcessor.setProcessTimer(this.id);
        });
        return $('input.negation-checkbox.auto-reload', detachedFilterContainer).click(function() {
          return gridProcessor.process();
        });
      }
    });
  };

  setupShowingAllRecords = function(wiceGridContainer, gridProcessor) {
    return $('.wg-show-all-link, .wg-back-to-pagination-link', wiceGridContainer).click(function(event) {
      var confirmationMessage, gridState, reloadGrid;

      event.preventDefault();
      gridState = $(this).data("grid-state");
      confirmationMessage = $(this).data("confim-message");
      reloadGrid = function() {
        return gridProcessor.reloadPageForGivenGridState(gridState);
      };
      if (confirmationMessage) {
        if (confirm(confirmationMessage)) {
          return reloadGrid();
        }
      } else {
        return reloadGrid();
      }
    });
  };

  setupMultiSelectToggle = function(wiceGridContainer) {
    $('.expand-multi-select-icon', wiceGridContainer).click(function() {
      $(this).prev().each(function(index, select) {
        return select.multiple = true;
      });
      $(this).next().show();
      return $(this).hide();
    });
    return $('.collapse-multi-select-icon', wiceGridContainer).click(function() {
      $(this).prev().prev().each(function(index, select) {
        return select.multiple = false;
      });
      $(this).prev().show();
      return $(this).hide();
    });
  };

  setupBulkToggleForActionColumn = function(wiceGridContainer) {
    $('.select-all', wiceGridContainer).click(function() {
      return $('.sel input', wiceGridContainer).prop('checked', true);
    });
    return $('.deselect-all', wiceGridContainer).click(function() {
      return $('.sel input', wiceGridContainer).prop('checked', false);
    });
  };

  getGridProcessorForElement = function(element) {
    var gridName;

    gridName = $(element).data('grid-name');
    if (gridName) {
      return window[gridName];
    } else {
      return null;
    }
  };

  setupExternalCsvExport = function() {
    return $(".wg-external-csv-export-button").each(function(index, externalCsvExportButton) {
      var gridProcessor;

      gridProcessor = getGridProcessorForElement(externalCsvExportButton);
      if (gridProcessor) {
        return $(externalCsvExportButton).click(function(event) {
          return gridProcessor.exportToCsv();
        });
      }
    });
  };

  setupExternalSubmitReset = function() {
    $(".wg-external-submit-button").each(function(index, externalSubmitButton) {
      var gridProcessor;

      gridProcessor = getGridProcessorForElement(externalSubmitButton);
      if (gridProcessor) {
        return $(externalSubmitButton).click(function(event) {
          gridProcessor.process();
          event.preventDefault();
          return false;
        });
      }
    });
    $(".wg-external-reset-button").each(function(index, externalResetButton) {
      var gridProcessor;

      gridProcessor = getGridProcessorForElement(externalResetButton);
      if (gridProcessor) {
        return $(externalResetButton).click(function(event) {
          gridProcessor.reset();
          event.preventDefault();
          return false;
        });
      }
    });
    return $('.wg-detached-filter').each(function(index, detachedFilterContainer) {
      var gridProcessor;

      gridProcessor = getGridProcessorForElement(detachedFilterContainer);
      if (gridProcessor) {
        return $('input[type=text]', this).keydown(function(event) {
          if (event.keyCode === 13) {
            gridProcessor.process();
            event.preventDefault();
            return false;
          }
        });
      }
    });
  };

  window['getGridProcessorForElement'] = getGridProcessorForElement;

}).call(this);
