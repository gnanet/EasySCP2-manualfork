<?php

//   -------------------------------------------------------------------------------
//  |                  net2ftp: a web based FTP client                              |
//  |              Copyright (c) 2003-2012 by David Gartner                         |
//  |                                                                               |
//  | This program is free software; you can redistribute it and/or                 |
//  | modify it under the terms of the GNU General Public License                   |
//  | as published by the Free Software Foundation; either version 2                |
//  | of the License, or (at your option) any later version.                        |
//  |                                                                               |
//   -------------------------------------------------------------------------------





// **************************************************************************************
// **************************************************************************************
// **                                                                                  **
// **                                                                                  **

function getActivePlugins() {

// --------------
// This function modifies the global variable $net2ftp_globals["activePlugins"], which contains an array 
// with all active plugin names
//
// Which plugin is active depends on 2 things:
// 1 - if the plugin is enabled or disabled (see the ["use"] field in getPluginProperties())
// 2 - the $net2ftp_globals["state"] and $net2ftp_globals["state2"] variables, as well as other specific variables (see this function)
// --------------

// -------------------------------------------------------------------------
// Global variables
// -------------------------------------------------------------------------
	global $net2ftp_globals;
	$pluginProperties = getPluginProperties("ALL");
	$plugincounter = 0;
	$activePlugins = array();
	if (isset($_POST["textareaType"]) == true) { $textareaType = $_POST["textareaType"]; }

// -------------------------------------------------------------------------
// Plugins to always activate
// -------------------------------------------------------------------------


// -------------------------------------------------------------------------
// Plugins to activate depending on the $state and $state2 variables
// -------------------------------------------------------------------------
	if ($net2ftp_globals["state"] == "logout" || $net2ftp_globals["state"] == "admin") { 
		if ($pluginProperties["versioncheck"]["use"] == "yes") { $activePlugins[$plugincounter] = "versioncheck"; $plugincounter++; } 
	}
	elseif ($net2ftp_globals["state"] == "findstring") { 
		if ($pluginProperties["jscalendar"]["use"] == "yes")   { $activePlugins[$plugincounter] = "jscalendar"; $plugincounter++; } 
	}
	elseif ($net2ftp_globals["state"] == "view") { 
		if ($pluginProperties["geshi"]["use"] == "yes")		 { $activePlugins[$plugincounter] = "geshi"; $plugincounter++; } 
	}

// -------------------------------------------------------------------------
// Plugins to activate depending on other variables
// -------------------------------------------------------------------------
	if ($net2ftp_globals["state"] == "edit" && isset($textareaType) == true && $textareaType != "" && array_key_exists($textareaType, $pluginProperties) == true) {
		if ($pluginProperties[$textareaType]["use"] == "yes") { $activePlugins[$plugincounter] = $textareaType; $plugincounter++; } 
	}

	return $activePlugins;

} // end function getActivePlugins

// **                                                                                  **
// **                                                                                  **
// **************************************************************************************
// **************************************************************************************





// **************************************************************************************
// **************************************************************************************
// **                                                                                  **
// **                                                                                  **

function isActivePlugin($plugin) {

// --------------
// This function checks if a plugin is active or not
// --------------

	global $net2ftp_globals;
	return in_array($plugin, $net2ftp_globals["activePlugins"]);

} // end function isActivePlugin

// **                                                                                  **
// **                                                                                  **
// **************************************************************************************
// **************************************************************************************






// **************************************************************************************
// **************************************************************************************
// **                                                                                  **
// **                                                                                  **

function getPluginProperties() {

// --------------
// This function returns an array with all plugin properties
// --------------

// -------------------------------------------------------------------------
// Global variables
// -------------------------------------------------------------------------
	global $net2ftp_globals, $net2ftp_settings;


// -------------------------------------------------------------------------
// CKEditor (formerly FCKEditor) - http://www.fckeditor.net/
// An HTML editor
// -------------------------------------------------------------------------

// Language code (see /plugins/ckeditor/lang)
	if     ($net2ftp_globals["language"] == "ar") { $ckeditor_language = "ar"; }
	elseif ($net2ftp_globals["language"] == "ar-utf") { $ckeditor_language = "ar"; }
	elseif ($net2ftp_globals["language"] == "cs") { $ckeditor_language = "cs"; }
	elseif ($net2ftp_globals["language"] == "da") { $ckeditor_language = "da"; }
	elseif ($net2ftp_globals["language"] == "de") { $ckeditor_language = "de"; }
	elseif ($net2ftp_globals["language"] == "es") { $ckeditor_language = "es"; }
	elseif ($net2ftp_globals["language"] == "fi") { $ckeditor_language = "fi"; }
	elseif ($net2ftp_globals["language"] == "fr") { $ckeditor_language = "fr"; }
	elseif ($net2ftp_globals["language"] == "he") { $ckeditor_language = "he"; }
	elseif ($net2ftp_globals["language"] == "hu") { $ckeditor_language = "hu"; }
	elseif ($net2ftp_globals["language"] == "hu-utf") { $ckeditor_language = "hu"; }
	elseif ($net2ftp_globals["language"] == "it") { $ckeditor_language = "it"; }
	elseif ($net2ftp_globals["language"] == "ja") { $ckeditor_language = "ja"; }
	elseif ($net2ftp_globals["language"] == "nl") { $ckeditor_language = "nl"; }
	elseif ($net2ftp_globals["language"] == "pl") { $ckeditor_language = "pl"; }
	elseif ($net2ftp_globals["language"] == "pt") { $ckeditor_language = "pt"; }
	elseif ($net2ftp_globals["language"] == "ru") { $ckeditor_language = "ru"; }
	elseif ($net2ftp_globals["language"] == "sv") { $ckeditor_language = "sv"; }
	elseif ($net2ftp_globals["language"] == "tc") { $ckeditor_language = "zh"; }
	elseif ($net2ftp_globals["language"] == "tr") { $ckeditor_language = "tr"; }
	elseif ($net2ftp_globals["language"] == "ua") { $ckeditor_language = "ru"; }
	elseif ($net2ftp_globals["language"] == "vi") { $ckeditor_language = "vi"; }
	elseif ($net2ftp_globals["language"] == "zh") { $ckeditor_language = "zh-cn"; }
	else                                          { $ckeditor_language = "en"; }

	$pluginProperties["ckeditor"]["use"]                     = "no";
	$pluginProperties["ckeditor"]["label"]                   = "CKEditor";
	$pluginProperties["ckeditor"]["directory"]               = "ckeditor";
	$pluginProperties["ckeditor"]["type"]                    = "textarea";
	$pluginProperties["ckeditor"]["browsers"][1]             = "IE";
	$pluginProperties["ckeditor"]["browsers"][2]             = "Mozilla";
	$pluginProperties["ckeditor"]["browsers"][3]             = "Opera";
	$pluginProperties["ckeditor"]["browsers"][4]             = "Other";
	$pluginProperties["ckeditor"]["filename_extensions"][1]  = "html";
	$pluginProperties["ckeditor"]["includePhpFiles"][1]      = "ckeditor/ckeditor.php";
	$pluginProperties["ckeditor"]["printJavascript"]         = "<script type=\"text/javascript\" src=\"" . $net2ftp_globals["application_rootdir_url"] . "/plugins/ckeditor/ckeditor.js\"></script>\n";
	$pluginProperties["ckeditor"]["printCss"]                = "";
	$pluginProperties["ckeditor"]["printBodyOnload"]         = "";
	$pluginProperties["ckeditor"]["printBodyOnload"]        .= "	CKEDITOR.replace( 'text_splitted[middle]' );\n";
	$pluginProperties["ckeditor"]["printBodyOnload"]        .= "	CKEDITOR.config.language = '" . $ckeditor_language . "';\n";
	$pluginProperties["ckeditor"]["printBodyOnload"]        .= "	CKEDITOR.config.contentsLangDirection = '" . __("ltr") . "';\n";
	$pluginProperties["ckeditor"]["printBodyOnload"]        .= "	CKEDITOR.config.height = 400;\n";

// -------------------------------------------------------------------------
// TinyMCE - http://tinymce.moxiecode.com/
// An HTML editor
// -------------------------------------------------------------------------

// Language code (see /plugins/tinymce/lang)
	if     ($net2ftp_globals["language"] == "ar") { $tinymce_language = "ar"; }
	if     ($net2ftp_globals["language"] == "ar-utf") { $tinymce_language = "ar"; }
	elseif ($net2ftp_globals["language"] == "cs") { $tinymce_language = "cs"; }
	elseif ($net2ftp_globals["language"] == "da") { $tinymce_language = "da"; }
	elseif ($net2ftp_globals["language"] == "de") { $tinymce_language = "de"; }
	elseif ($net2ftp_globals["language"] == "es") { $tinymce_language = "es"; }
	elseif ($net2ftp_globals["language"] == "fi") { $tinymce_language = "fi"; }
	elseif ($net2ftp_globals["language"] == "fr") { $tinymce_language = "fr"; }
	elseif ($net2ftp_globals["language"] == "he") { $tinymce_language = "he"; }
	elseif ($net2ftp_globals["language"] == "hu") { $tinymce_language = "hu"; }
	elseif ($net2ftp_globals["language"] == "hu-utf") { $tinymce_language = "hu"; }
	elseif ($net2ftp_globals["language"] == "it") { $tinymce_language = "it"; }
	elseif ($net2ftp_globals["language"] == "ja") { $tinymce_language = "ja_euc-jp"; }
	elseif ($net2ftp_globals["language"] == "nl") { $tinymce_language = "nl"; }
	elseif ($net2ftp_globals["language"] == "pl") { $tinymce_language = "pl"; }
	elseif ($net2ftp_globals["language"] == "pt") { $tinymce_language = "pt_br"; }
	elseif ($net2ftp_globals["language"] == "ru") { $tinymce_language = "ru"; }
	elseif ($net2ftp_globals["language"] == "sv") { $tinymce_language = "sv"; }
	elseif ($net2ftp_globals["language"] == "tc") { $tinymce_language = "zh_tw"; }
	elseif ($net2ftp_globals["language"] == "tr") { $tinymce_language = "tr"; }
	elseif ($net2ftp_globals["language"] == "ua") { $tinymce_language = "ru"; }
	elseif ($net2ftp_globals["language"] == "ua") { $tinymce_language = "ru"; }
	elseif ($net2ftp_globals["language"] == "vi") { $tinymce_language = "vi"; }
	elseif ($net2ftp_globals["language"] == "zh") { $tinymce_language = "zh_cn"; }
	else                                          { $tinymce_language = "en"; }

	$pluginProperties["tinymce"]["use"]                      = "no";
	$pluginProperties["tinymce"]["label"]                    = "TinyMCE";
	$pluginProperties["tinymce"]["directory"]                = "tinymce";
	$pluginProperties["tinymce"]["type"]                     = "textarea";
	$pluginProperties["tinymce"]["browsers"][1]              = "IE";
	$pluginProperties["tinymce"]["browsers"][2]              = "Mozilla";
	$pluginProperties["tinymce"]["browsers"][3]              = "Opera";
	$pluginProperties["tinymce"]["browsers"][4]              = "Other";
	$pluginProperties["tinymce"]["filename_extensions"][1]   = "html";
	$pluginProperties["tinymce"]["includePhpFiles"][1]       = "";
	$pluginProperties["tinymce"]["printJavascript"]          = "<script type=\"text/javascript\" src=\"" . $net2ftp_globals["application_rootdir_url"] . "/plugins/tinymce/tiny_mce.js\"></script>\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "<script type=\"text/javascript\">\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "	tinyMCE.init({\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		// General options\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		mode : \"exact\",\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		elements : \"text_splitted[middle]\",\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		theme : \"advanced\",\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		plugins : \"pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave\",\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		// Theme options\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		theme_advanced_buttons1 : \"save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect\",\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		theme_advanced_buttons2 : \"cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor\",\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		theme_advanced_buttons3 : \"tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen\",\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		theme_advanced_buttons4 : \"insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak,restoredraft\",\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		theme_advanced_toolbar_location : \"top\",\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		theme_advanced_toolbar_align : \"left\",\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		theme_advanced_statusbar_location : \"bottom\",\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		theme_advanced_resizing : true,\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		// Example content CSS (should be your site CSS)\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		content_css : \"css/content.css\",\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		// Drop lists for link/image/media/template dialogs\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		template_external_list_url : \"lists/template_list.js\",\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		external_link_list_url : \"lists/link_list.js\",\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		external_image_list_url : \"lists/image_list.js\",\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		media_external_list_url : \"lists/media_list.js\",\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		// Style formats\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		style_formats : [\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "			{title : 'Bold text', inline : 'b'},\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "			{title : 'Red text', inline : 'span', styles : {color : '#ff0000'}},\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "			{title : 'Red header', block : 'h1', styles : {color : '#ff0000'}},\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "			{title : 'Example 1', inline : 'span', classes : 'example1'},\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "			{title : 'Example 2', inline : 'span', classes : 'example2'},\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "			{title : 'Table styles'},\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "			{title : 'Table row 1', selector : 'tr', classes : 'tablerow1'}\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		],\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		// Replace values for the template plugin\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		template_replace_values : {\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "			username : \"Some User\",\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "			staffid : \"991234\"\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "		}\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "	});\n";
	$pluginProperties["tinymce"]["printJavascript"]         .= "</script>\n";
	$pluginProperties["tinymce"]["printCss"]                 = "";
	$pluginProperties["tinymce"]["printBodyOnload"]          = "";


// -------------------------------------------------------------------------
// CodePress http://www.codepress.org/
// A syntax highlighting text editor in javascript
// -------------------------------------------------------------------------

	$pluginProperties["codepress"]["use"]                    = "no";
	$pluginProperties["codepress"]["label"]                  = "CodePress";
	$pluginProperties["codepress"]["directory"]              = "codepress";
	$pluginProperties["codepress"]["type"]                   = "textarea";
	$pluginProperties["codepress"]["browsers"][1]            = "IE";
	$pluginProperties["codepress"]["browsers"][2]            = "Opera";
	$pluginProperties["codepress"]["browsers"][3]            = "Mozilla";
	$pluginProperties["codepress"]["browsers"][4]            = "Other";
	$pluginProperties["codepress"]["filename_extensions"][1] = "asp";
	$pluginProperties["codepress"]["filename_extensions"][2] = "css";
	$pluginProperties["codepress"]["filename_extensions"][3] = "cgi";
	$pluginProperties["codepress"]["filename_extensions"][4] = "htm";
	$pluginProperties["codepress"]["filename_extensions"][5] = "html";
	$pluginProperties["codepress"]["filename_extensions"][6] = "java";
	$pluginProperties["codepress"]["filename_extensions"][7] = "javascript";
	$pluginProperties["codepress"]["filename_extensions"][8] = "js";
	$pluginProperties["codepress"]["filename_extensions"][9] = "pl";
	$pluginProperties["codepress"]["filename_extensions"][10] = "perl";
	$pluginProperties["codepress"]["filename_extensions"][11] = "php";
	$pluginProperties["codepress"]["filename_extensions"][12] = "phps";
	$pluginProperties["codepress"]["filename_extensions"][13] = "phtml";
	$pluginProperties["codepress"]["filename_extensions"][14] = "ruby";
	$pluginProperties["codepress"]["filename_extensions"][15] = "sql";
	$pluginProperties["codepress"]["filename_extensions"][16] = "txt";
	$pluginProperties["codepress"]["includePhpFiles"][1]     = "";
	$pluginProperties["codepress"]["printJavascript"]        = "<script type=\"text/javascript\" src=\"" . $net2ftp_globals["application_rootdir_url"] . "/plugins/codepress/codepress.js\"></script>\n";
	$pluginProperties["codepress"]["printCss"]               = "";
	$pluginProperties["codepress"]["printBodyOnload"]        = "";



// -------------------------------------------------------------------------
// Version Checker - written by Slynderdale for net2ftp.
// This small Javascript function will check if a new version of net2ftp is available
// and display a message if there is. 
// -------------------------------------------------------------------------

	$pluginProperties["versioncheck"]["use"]                = "no";
	$pluginProperties["versioncheck"]["label"]              = "Javascript Version Checker";
	$pluginProperties["versioncheck"]["directory"]          = "versioncheck";
	$pluginProperties["versioncheck"]["type"]               = "versioncheck";
	$pluginProperties["versioncheck"]["browsers"][1]        = "IE";
	$pluginProperties["versioncheck"]["browsers"][2]        = "Opera";
	$pluginProperties["versioncheck"]["browsers"][3]        = "Mozilla";
	$pluginProperties["versioncheck"]["browsers"][4]        = "Other";
	$pluginProperties["versioncheck"]["filename_extensions"][1] = "";
	$pluginProperties["versioncheck"]["includePhpFiles"][1] = "";
	$pluginProperties["versioncheck"]["printJavascript"]    = "<script type=\"text/javascript\" src=\"http://www.net2ftp.com/version.js\"></script>\n";
	$pluginProperties["versioncheck"]["printCss"]           = "";
	$pluginProperties["versioncheck"]["printBodyOnload"]    = "";


// -------------------------------------------------------------------------
// The JS Calendar code is written by Mishoo (who also wrote the HTMLArea v3).
// http://dynarch.com/mishoo/calendar.epl
// -------------------------------------------------------------------------

// Language code (see /plugins/jscalendar/lang)
	if     ($net2ftp_globals["language"] == "cs") { $jscalendar_language = "calendar-cs-win"; }
	elseif ($net2ftp_globals["language"] == "da") { $jscalendar_language = "calendar-da"; }
	elseif ($net2ftp_globals["language"] == "de") { $jscalendar_language = "calendar-de"; }
	elseif ($net2ftp_globals["language"] == "es") { $jscalendar_language = "calendar-es"; }
	elseif ($net2ftp_globals["language"] == "fi") { $jscalendar_language = "calendar-fi"; }
	elseif ($net2ftp_globals["language"] == "fr") { $jscalendar_language = "calendar-fr"; }
	elseif ($net2ftp_globals["language"] == "he") { $jscalendar_language = "calendar-he-utf8.js"; }
	elseif ($net2ftp_globals["language"] == "it") { $jscalendar_language = "calendar-it"; }
	elseif ($net2ftp_globals["language"] == "ja") { $jscalendar_language = "calendar-jp"; }
	elseif ($net2ftp_globals["language"] == "nl") { $jscalendar_language = "calendar-nl"; }
	elseif ($net2ftp_globals["language"] == "pl") { $jscalendar_language = "calendar-pl"; }
	elseif ($net2ftp_globals["language"] == "pt") { $jscalendar_language = "calendar-pt"; }
	elseif ($net2ftp_globals["language"] == "ru") { $jscalendar_language = "calendar-ru"; }
	elseif ($net2ftp_globals["language"] == "sv") { $jscalendar_language = "calendar-sv"; }
	elseif ($net2ftp_globals["language"] == "tr") { $jscalendar_language = "calendar-tr"; }
	elseif ($net2ftp_globals["language"] == "tc") { $jscalendar_language = "calendar-big5.js"; }
	elseif ($net2ftp_globals["language"] == "zh") { $jscalendar_language = "calendar-zh"; }
	else                                          { $jscalendar_language = "calendar-en"; }

	$pluginProperties["jscalendar"]["use"]                    = "no";
	$pluginProperties["jscalendar"]["label"]                  = "JS Calendar";
	$pluginProperties["jscalendar"]["directory"]              = "jscalendar";
	$pluginProperties["jscalendar"]["type"]                   = "calendar";
	$pluginProperties["jscalendar"]["browsers"][1]            = "IE";
	$pluginProperties["jscalendar"]["browsers"][2]            = "Opera";
	$pluginProperties["jscalendar"]["browsers"][3]            = "Mozilla";
	$pluginProperties["jscalendar"]["browsers"][4]            = "Other";
	$pluginProperties["jscalendar"]["filename_extensions"][1] = "";
	$pluginProperties["jscalendar"]["includePhpFiles"][1]     = "jscalendar/calendar.php";
	$pluginProperties["jscalendar"]["printJavascript"]        = "<script type=\"text/javascript\" src=\"" . $net2ftp_globals["application_rootdir_url"] . "/plugins/jscalendar/calendar.js\"></script>\n";
	$pluginProperties["jscalendar"]["printJavascript"]       .= "<script type=\"text/javascript\" src=\"" . $net2ftp_globals["application_rootdir_url"] . "/plugins/jscalendar/lang/" . $jscalendar_language . ".js\"></script>\n";
	$pluginProperties["jscalendar"]["printJavascript"]       .= "<script type=\"text/javascript\" src=\"" . $net2ftp_globals["application_rootdir_url"] . "/plugins/jscalendar/calendar-setup.js\"></script>\n";
	$pluginProperties["jscalendar"]["printCss"]               = "<link rel=\"stylesheet\" type=\"text/css\" media=\"all\" href=\"" . $net2ftp_globals["application_rootdir_url"] . "/plugins/jscalendar/skins/aqua/theme.css\" title=\"Aqua\" />\n";
	$pluginProperties["jscalendar"]["printCss"]              .= "<link rel=\"alternate stylesheet\" type=\"text/css\" media=\"all\" href=\"" . $net2ftp_globals["application_rootdir_url"] . "/plugins/jscalendar/calendar-win2k-cold-1.css\" title=\"win2k-cold-1\" />\n";
	$pluginProperties["jscalendar"]["printBodyOnload"]        = "";


// -------------------------------------------------------------------------
// JUpload
// A Java applet to upload directories and files
// -------------------------------------------------------------------------

	$pluginProperties["jupload"]["use"]                      = "yes";
	$pluginProperties["jupload"]["label"]                    = "JUpload";
	$pluginProperties["jupload"]["directory"]                = "jupload";
	$pluginProperties["jupload"]["type"]                     = "applet";
	$pluginProperties["jupload"]["browsers"][1]              = "IE";
	$pluginProperties["jupload"]["browsers"][2]              = "Opera";
	$pluginProperties["jupload"]["browsers"][3]              = "Mozilla";
//	$pluginProperties["jupload"]["browsers"][4]            = "Other";
	$pluginProperties["jupload"]["filename_extensions"][1]   = "";
	$pluginProperties["jupload"]["includePhpFiles"][1]       = "";
	$pluginProperties["jupload"]["printCss"]                 = "";
	$pluginProperties["jupload"]["printJavascript"]          = "";
	$pluginProperties["jupload"]["printBodyOnload"]          = "";


// -------------------------------------------------------------------------
// GeSHi
// Syntax highlighter
// -------------------------------------------------------------------------

	$pluginProperties["geshi"]["use"]                      = "no";
	$pluginProperties["geshi"]["label"]                    = "GeSHi";
	$pluginProperties["geshi"]["directory"]                = "geshi";
	$pluginProperties["geshi"]["type"]                     = "highlighter";
	$pluginProperties["geshi"]["browsers"][1]              = "IE";
	$pluginProperties["geshi"]["browsers"][2]              = "Opera";
	$pluginProperties["geshi"]["browsers"][3]              = "Mozilla";
	$pluginProperties["geshi"]["browsers"][4]              = "Other";
	$pluginProperties["geshi"]["filename_extensions"][1]   = "";
	$pluginProperties["geshi"]["includePhpFiles"][1]       = "geshi/geshi.php";
	$pluginProperties["geshi"]["printCss"]                 = "";
	$pluginProperties["geshi"]["printJavascript"]          = "";
	$pluginProperties["geshi"]["printBodyOnload"]          = "";

	return $pluginProperties;

} // end function getPluginProperties

// **                                                                                  **
// **                                                                                  **
// **************************************************************************************
// **************************************************************************************









// **************************************************************************************
// **************************************************************************************
// **                                                                                  **
// **                                                                                  **

function net2ftp_plugin_includePhpFiles() {

// --------------
// This function includes PHP files which are required by the active plugins
// The list of current active plugins is stored in $net2ftp_globals["activePlugins"]
// --------------

// -------------------------------------------------------------------------
// Global variables and settings
// -------------------------------------------------------------------------
	global $net2ftp_globals;
	$pluginProperties = getPluginProperties();

// -------------------------------------------------------------------------
// Initial checks and initialization
// -------------------------------------------------------------------------
	if ($net2ftp_globals["activePlugins"] == "") { return ""; }

// -------------------------------------------------------------------------
// For all plugins...
// -------------------------------------------------------------------------
	for ($pluginnr=0; $pluginnr<sizeof($net2ftp_globals["activePlugins"]); $pluginnr++) {

// Get the plugin related data
		$currentPlugin = $pluginProperties[$net2ftp_globals["activePlugins"][$pluginnr]];

// Check if the plugin should be used
		if ($currentPlugin["use"] != "yes" || $currentPlugin["includePhpFiles"][1] == "") { continue; }

// -------------------------------------------------------------------------
// Include PHP files
// -------------------------------------------------------------------------
		for ($i=1; $i<=sizeof($currentPlugin["includePhpFiles"]); $i++) {
			require_once($net2ftp_globals["application_pluginsdir"] . "/" . $currentPlugin["includePhpFiles"][$i]);
		} // end for

	} // end for

} // End function net2ftp_plugin_includePhpFiles

// **                                                                                  **
// **                                                                                  **
// **************************************************************************************
// **************************************************************************************





// **************************************************************************************
// **************************************************************************************
// **                                                                                  **
// **                                                                                  **

function net2ftp_plugin_printJavascript() {

// --------------
// This function includes PHP files which are required by the active plugins
// The list of current active plugins is stored in $net2ftp_globals["activePlugins"]
// --------------

// -------------------------------------------------------------------------
// Global variables and settings
// -------------------------------------------------------------------------
	global $net2ftp_globals;
	$pluginProperties = getPluginProperties();

// -------------------------------------------------------------------------
// Initial checks and initialization
// -------------------------------------------------------------------------
	if ($net2ftp_globals["activePlugins"] == "") { return ""; }

// -------------------------------------------------------------------------
// For all plugins...
// -------------------------------------------------------------------------
	for ($pluginnr=0; $pluginnr<sizeof($net2ftp_globals["activePlugins"]); $pluginnr++) {

// Get the plugin related data
		$currentPlugin = $pluginProperties[$net2ftp_globals["activePlugins"][$pluginnr]];

// Check if the plugin should be used
		if ($currentPlugin["use"] != "yes") { continue; }

// -------------------------------------------------------------------------
// Print Javascript code
// -------------------------------------------------------------------------
		echo $currentPlugin["printJavascript"];

	} // end for

} // End function net2ftp_plugin_printJavascript

// **                                                                                  **
// **                                                                                  **
// **************************************************************************************
// **************************************************************************************





// **************************************************************************************
// **************************************************************************************
// **                                                                                  **
// **                                                                                  **

function net2ftp_plugin_printCss() {

// --------------
// This function includes PHP files which are required by the active plugins
// The list of current active plugins is stored in $net2ftp_globals["activePlugins"]
// --------------

// -------------------------------------------------------------------------
// Global variables and settings
// -------------------------------------------------------------------------
	global $net2ftp_globals;
	$pluginProperties = getPluginProperties();

// -------------------------------------------------------------------------
// Initial checks and initialization
// -------------------------------------------------------------------------
	if ($net2ftp_globals["activePlugins"] == "") { return ""; }

// -------------------------------------------------------------------------
// For all plugins...
// -------------------------------------------------------------------------
	for ($pluginnr=0; $pluginnr<sizeof($net2ftp_globals["activePlugins"]); $pluginnr++) {

// Get the plugin related data
		$currentPlugin = $pluginProperties[$net2ftp_globals["activePlugins"][$pluginnr]];

// Check if the plugin should be used
		if ($currentPlugin["use"] != "yes") { continue; }

// -------------------------------------------------------------------------
// Print CSS code
// -------------------------------------------------------------------------
		echo $currentPlugin["printCss"];

	} // end for

} // End function net2ftp_plugin_printCss

// **                                                                                  **
// **                                                                                  **
// **************************************************************************************
// **************************************************************************************





// **************************************************************************************
// **************************************************************************************
// **                                                                                  **
// **                                                                                  **

function net2ftp_plugin_printBodyOnload() {

// --------------
// This function includes PHP files which are required by the active plugins
// The list of current active plugins is stored in $net2ftp_globals["activePlugins"]
// --------------

// -------------------------------------------------------------------------
// Global variables and settings
// -------------------------------------------------------------------------
	global $net2ftp_globals;
	$pluginProperties = getPluginProperties();

// -------------------------------------------------------------------------
// Initial checks and initialization
// -------------------------------------------------------------------------
	if ($net2ftp_globals["activePlugins"] == "") { return ""; }

// -------------------------------------------------------------------------
// For all plugins...
// -------------------------------------------------------------------------
	for ($pluginnr=0; $pluginnr<sizeof($net2ftp_globals["activePlugins"]); $pluginnr++) {

// Get the plugin related data
		$currentPlugin = $pluginProperties[$net2ftp_globals["activePlugins"][$pluginnr]];

// Check if the plugin should be used
		if ($currentPlugin["use"] != "yes") { continue; }

// -------------------------------------------------------------------------
// Print <body onload=""> code
// -------------------------------------------------------------------------
		echo $currentPlugin["printBodyOnload"];

	} // end for

} // End function net2ftp_plugin_printBodyOnload

// **                                                                                  **
// **                                                                                  **
// **************************************************************************************
// **************************************************************************************

?>