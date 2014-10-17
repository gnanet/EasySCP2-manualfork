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
			<li><a href="ftp_accounts.php">{$TR_MENU_OVERVIEW}</a></li>
			<li><a>{$TR_EDIT_FTP_USER}</a></li>
		</ul>
	</div>
	<div class="left_menu">{include file="$MENU"}</div>
	<div class="main">
		{if isset($MESSAGE)}
		<div class="{$MSG_TYPE}">{$MESSAGE}</div>
		{/if}
		<h2 class="ftp"><span>{$TR_EDIT_FTP_USER}</span></h2>
		<form action="ftp_edit.php" method="post" id="client_ftp_edit">
			<table>
				<tr>
					<td>{$TR_FTP_ACCOUNT}</td>
					<td><input type="text" name="username" id="ftp_account" value="{$FTP_ACCOUNT}"  readonly="readonly"/></td>
				</tr>
				<tr>
					<td>{$TR_PASSWORD}</td>
					<td><input type="password" name="pass" id="pass" value="" /></td>
				</tr>
				<tr>
					<td>{$TR_PASSWORD_REPEAT}</td>
					<td><input type="password" name="pass_rep" id="pass_rep" value="" /></td>
				</tr>
				<tr>
					<td><input type="checkbox" name="use_other_dir" id="use_other_dir" {$USE_OTHER_DIR_CHECKED} />&nbsp;{$TR_USE_OTHER_DIR}</td>
					<td><input type="text" name="other_dir" id="other_dir" value="{$OTHER_DIR}" /><a href="#" onclick="showFileTree();" class="icon i_bc_folder">{$CHOOSE_DIR}</a></td>
				</tr>
			</table>
			<div class="buttons">
				<input type="hidden" name="id" value="{$ID}" />
				<input type="hidden" name="uaction" value="edit_user" />
				<input type="submit" name="Submit" value="{$TR_EDIT}" />
			</div>
		</form>
	</div>
{include file='client/footer.tpl'}