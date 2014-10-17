{include file='client/header.tpl'}
<body>
	<script type="text/javascript">
	/* <![CDATA[ */
		function action_delete(url, subject) {
			return confirm(sprintf("{$TR_MESSAGE_DELETE}", subject));
		}
	/* ]]> */
	</script>
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
			<li><a>{$TR_MENU_DAILY_BACKUP}</a></li>
		</ul>
	</div>
	<div class="left_menu">{include file="$MENU"}</div>
	<div class="main">
		{if isset($MESSAGE)}
		<div class="{$MSG_TYPE}">{$MESSAGE}</div>
		{/if}
		<h2 class="hdd"><span>{$TR_BACKUP}</span></h2>
		<h2>{$TR_DOWNLOAD_DIRECTION}</h2>
		<ol>
			<li>{$TR_FTP_LOG_ON}</li>
			<li>{$TR_SWITCH_TO_BACKUP}</li>
			<li>{$TR_DOWNLOAD_FILE}<br />{$TR_USUALY_NAMED}</li>
		</ol>
		<h2>{$TR_RESTORE_BACKUP}</h2>
		<p>{$TR_RESTORE_DIRECTIONS}</p>
		<form action="backup.php" method="post" id="client_backup" onsubmit="return confirm('{$TR_CONFIRM_MESSAGE}');">
			<div class="buttons">
				<input type="hidden" name="uaction" value="bk_restore" />
				<input type="submit" name="Submit" value="{$TR_RESTORE}" />
			</div>
		</form>
	</div>
{include file='client/footer.tpl'}