{include file='client/header.tpl'}
<body>
	<div class="header">
		{include file="$MAIN_MENU"}
		<div class="logo">
			<img src="{$THEME_COLOR_PATH}/images/easyscp_logo.png" alt="EasySCP logo" />
			<img src="{$THEME_COLOR_PATH}/images/easyscp_webhosting.png" alt="EasySCP - Easy Server Control Panel" />
		</div>
	</div>
	<div class="location">
		<ul class="location-menu">
			{if isset($YOU_ARE_LOGGED_AS)}
			<li><a href="change_user_interface.php?action=go_back" class="backadmin">{$YOU_ARE_LOGGED_AS}</a></li>
			{/if}
			<li><a href="../index.php?logout" class="logout">{$TR_MENU_LOGOUT}</a></li>
		</ul>
		<ul class="path">
			<li><a href="webtools.php">{$TR_MENU_OVERVIEW}</a></li>
			<li><a href="error_pages.php">{$TR_MENU_ERROR_PAGES}</a></li>
			<li><a>{$TR_ERROR_EDIT_PAGE} {$EID}</a></li>
		</ul>
	</div>
	<div class="left_menu">{include file="$MENU"}</div>
	<div class="main">
		{if isset($MESSAGE)}
		<div class="{$MSG_TYPE}">{$MESSAGE}</div>
		{/if}
		<h2 class="errors"><span>{$TR_ERROR_EDIT_PAGE} {$EID}</span></h2>
		<form action="error_pages.php" method="post" id="client_error_pages">
			<fieldset>
				<textarea name="error" cols="120" rows="25" id="error">{$ERROR}</textarea>
			</fieldset>
			<div class="buttons">
				<input type="hidden" name="eid" value="{$EID}" />
				<input type="hidden" name="uaction" value="updt_error" />
				<input type="submit" name="Submit" value="{$TR_SAVE}" />
			</div>
		</form>
	</div>
{include file='client/footer.tpl'}