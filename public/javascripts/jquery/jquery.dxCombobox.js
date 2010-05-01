/**
 * dxCombobox 1.2 (2008-04-22)
 *
 * Copyright (c) 2008 Dipesh Nyachhyon (http://dmashups.com)
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 * Built upon jQuery 1.2.3 (http://jquery.com)
 * 
 * dxCombobox plugin allows you to transform any < select > element into an editable combobox.
 * Pressing any alphanumeric key will transform select box into editable state by creating a
 * text box element. An case insensitive search is performed on the corresponding < option > of the select
 * box, one the users starts to type in this box. When user goes out of the box (on blur/return),
 * if a direct match is found in the < option > then it is selected else a new option is created
 * with the entered text.
 * - CSS class applied to the selectbox is applied to the created textbox as well
 * 
 * Syntax:
 * $(element).dxCombobox([options])
 * 
 * Parameters:
 * - plugin specific options
 * 
 * Options:
 * - int maxlength: maximum length to allow in editable text box, default is 35 characters
 * 
 * Change log
 * - 1.2
 * 		- fix for, if i type 'Dexter' and press enter then a new option is created and selected; now again if i type 'Dexter' and press enter, then the text(option) is lost
 * 		- fix for, initial key pressed not appearing in the textbox for IE6
 */
(function($) {
	$.fn.dxCombobox	=	function(options) {
		var defaults	=	{
			maxlength: 35
		}		
		var xClass		=	'dxComboboxClass';
		
		// options
		var options = $.extend(defaults, options);		
		
		// select box attributes
		var strSelId	=	$(this).attr('id');
		var strBoxId	=	'txt_' + strSelId;
		var objSel		=	$(this);
		
		// bind key press event
		return $(this).bind('keydown', function(e) {
			var intKey	=	$.dxCombobox.event(e);
			switch (intKey) {
				case 8: // backspace
				case 9: // tab
				case 13: // return
				case 16: // shift
				case 17: // ctrl
				case 18: // alt
				case 27: // escape
				case 33: // page up
				case 34: // page down
				case 35: // end
				case 36: // home
				case 37: // left
				case 38: // up
				case 39: // right
				case 40: // down
				case 45: // insert
				case 46: // delete
					break;
				default:
					// remove selection from all options
					objSel.children(':selected').removeAttr('selected');
					
					// hide select box
					objSel.hide();
					
					// create text box if not created already
					if (document.getElementById(strBoxId) == null) {
						var objBox	=	document.createElement('input');
						$(objBox).width(objSel.width()).attr('type', 'text').attr('id', strBoxId).attr('autocomplete', 'off').attr('maxlength', defaults.maxlength).addClass(objSel.attr('class'));
						
						// display text box
						objSel.after(objBox);
						
						// set focus
						objBox.focus();
						
						// for IE 6, capture key event, convert to character and put it in text box
						if ($.browser.msie) {
							if ($.dxCombobox.ieVersion() < 7) {
								var range = document.selection.createRange();
								range.moveStart('character', 1); //move cursor at the end of line ... i.e. after this entered character
								$(objBox).val(String.fromCharCode(intKey)); // insert capture key into the text box
							}
						}
						
						// bind event to this text box							
						$(objBox).bind('keydown', function(elt) {
							var txtKey	=	$.dxCombobox.event(elt);
							// trigger blur event and return focus back to select box when 'return' key is pressed
							if (txtKey == 13) {
								$(objBox).trigger('blur');
								objSel.focus().focus().next().focus(); //envoke extra focus event to make it compatible with IE
							}
							// clear text, trigger blur and return focus back to select box whe "escape" key is pressed
							if (txtKey == 27) {
								$(objBox).val('').trigger('blur');
								objSel.focus().focus().next().focus(); //envoke extra focus event to make it compatible with IE
							}
						});	
					}
					
					// autocomplete (with highlighting)
					$.dxCombobox.autoFill(strBoxId, objSel);
				break;
			}
			
			// bind on blur event
			$('#' + strBoxId).bind('blur', function() {
				//create new option?
				var bolCreateOption	=	true;
				
				// search option with same value as in text box
				objSel.children().each(function() {
					if (!$(this).hasClass(xClass)) { //don't search in the created option
						if ($(this).text().toLowerCase() == $('#' + strBoxId).val().toLowerCase()) {
							$(this).attr('selected', 'selected');
							bolCreateOption = false;
						}
					}
				});
				
				// create new option in select box (if it has not been created before) and if needed
				if (!objSel.children().hasClass(xClass) && bolCreateOption) {
					objSel.prepend("<option class=\""+xClass+"\" selected></option>");
				}
				
				// if no option found with text that matches the value in text box
				if (bolCreateOption) {
					// if it has some text then update option else remove this created option
					if ($(this).val() != '') {
						// update key/value in option
						objSel.children('option.' + xClass).text($(this).val()).val($(this).val()).attr('selected', 'selected');
					}
					else {
						// if no value entered in text box, remove this option
						objSel.children('option.' + xClass).remove();
					}
				} else {
					// if a match found, then remove this option
					objSel.children('option.' + xClass).remove();
				}
				
				// display select box
				objSel.show();
				
				// destroy text box
				var objNode	=	document.getElementById(strBoxId);
				objNode.parentNode.removeChild(objNode);
			});
		});
	}
})(jQuery);

/**
 * helper plugins for combobox
 */
(function($) {
	$.dxCombobox	=	{
		event: function(e) {
			var intKey = 0;				
			if (!e) var e = window.event;
			if (e.keyCode) intKey = e.keyCode; else { if (e.which) intKey = e.which; }
			return intKey;
		},
		autoFill: function(strBoxId, objSel) {
			var objTextBox	=	$('#' + strBoxId);
			objTextBox.bind('keyup', function(e) {
				var strKeyword	=	objTextBox.val().toLowerCase();
				var intKey		=	$.dxCombobox.event(e);
				switch (intKey) {
					case 8: // BACKSPACE
					case 9: // TAB (?)
					case 33: // PAGE UP
					case 34: // PAGE DOWN
					case 35: // END
					case 36: // HOME
					case 37: // CURSOR LEFT
					case 38: // CURSOR UP
					case 39: // CURSOR RIGHT
					case 40: // CURSOR DOWN
					case 45: // INSERT
					case 46: // DELETE
					case 27: // ESCAPE
					case 13: // RETURN
						break;
					default:
						// search for a match in the option text
						objSel.children().each(function() {
							var strOption	=	$(this).text();
							var intPos		=	strOption.toLowerCase().indexOf(strKeyword);
							
							if (intPos == 0) {
								var intStart	=	strKeyword.length;
								var intEnd		=	strOption.length;
								
								objTextBox.val(strOption);
								
								// for IE
								if ($.browser.msie) {
									var range = document.getElementById(strBoxId).createTextRange();
									range.moveStart('character', intStart);
									range.select();
								} else {
									// for others
									if (intStart == 0) intStart	=	intStart + 1;
									document.getElementById(strBoxId).setSelectionRange(intStart, intEnd);
								}								
								return false; //exit from loop
							}
						});
					break;
				}
			});
		},
		ieVersion: function() {			
			var objUa		=	navigator.userAgent;
			var intIEOffset	=	objUa.indexOf("MSIE ");			    
			if (intIEOffset == -1) return 0;
			else return parseFloat(objUa.substring(intIEOffset + 5, objUa.indexOf(";", intIEOffset)));
		}
	}
})(jQuery);