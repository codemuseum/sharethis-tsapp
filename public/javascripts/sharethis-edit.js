var ShareThisEdit = {
  init: function() {
    TSEditor.registerOnEdit('sharethis', function(el) { ShareThisEdit.instantiate(el); });
  },
  instantiate: function(el) {
    var selects = el.getElementsByTagName('select');
    var select = null;
    for (var i = 0; i < selects.length; ++i) { if (selects[i].className == 'button-select') { select = selects[i]; } }
    
    var editedValues = el.getElementsByTagName('div');
    var editedValue = null;
    for (var i = 0; i < editedValues.length; ++i) { if (editedValues[i].className.substring(0,12) == 'edited-value') { editedValue = editedValues[i]; } }
    
    if (select) {
      select.onchange = function() { 
        if (select[select.selectedIndex].value == '') { editedValue.className = 'edited-value'; editedValue.getElementsByTagName('input')[0].focus();  }
        else { editedValue.className = 'edited-value hidden'; } 
        return true;
      }
    }
  }
}
ShareThisEdit.init();