{include file='client/header.tpl'}
<body>
	<script type="text/javascript">
	/* <![CDATA[ */
		function action_delete(url, subject) {
			if (!confirm(sprintf("{$TR_MESSAGE_DELETE}", subject)))
				return false;
			location = url;
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
			<li><a>{$TR_MENU_OVERVIEW}</a></li>
		</ul>
	</div>
	<div class="left_menu">{include file="$MENU"}</div>
	<div class="main">
		{if isset($MESSAGE)}
		<div class="{$MSG_TYPE}">{$MESSAGE}</div>
		{/if}
		{if isset($FTP_MSG)}
		<div class="{$FTP_MSG_TYPE}">{$FTP_MSG}</div>
		{/if}
		{if isset($FTP_ACCOUNT)}
		<h2 class="ftp"><span>{$TR_FTP_USERS}</span></h2>
		<table class="tablesorter">
			<thead>
				<tr>
					<th>{$TR_FTP_ACCOUNT}</th>
					<th>{$TR_FTP_ACTION}</th>
				</tr>
			</thead>
			{if isset($TOTAL_FTP_ACCOUNTS)}
			<tfoot>
				<tr>
					<td colspan="2">{$TR_TOTAL_FTP_ACCOUNTS}&nbsp;{$TOTAL_FTP_ACCOUNTS}</td>
				</tr>
			</tfoot>
			{/if}
			<tbody>
				{section name=i loop=$FTP_ACCOUNT}
				<tr>
					<td>{$FTP_ACCOUNT[i]}</td>
					<td>
						<a href="ftp_edit.php?id={$UID[i]}" title="{$TR_EDIT}" class="icon i_edit"></a>
						<a href="#" onclick="action_delete('ftp_delete.php?id={$UID[i]}', '{$FTP_ACCOUNT[i]}')" title="{$TR_DELETE}" class="icon i_delete"></a>
						{if $FTP_LOGIN_AVAILABLE[i]}
						<a href="ftp_auth.php?id={$UID[i]}" title="{$TR_LOGINAS}" class="icon i_identity external"></a>
						{/if}
					</td>
				</tr>
				{/section}
			</tbody>
		</table>
		{/if}
	</div>
{include file='client/footer.tpl'}