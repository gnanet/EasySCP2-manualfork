{include file='client/header.tpl'}
<body onload="changeType('{$DEFAULT}');">
	<script type="text/javascript">
	/* <![CDATA[ */
		function changeType(type) {
			if (type == "normal") {
				document.forms[0].mail_id.disabled = false;
				document.forms[0].forward_list.disabled = true;
			} else {
				document.forms[0].mail_id.disabled = true;
				document.forms[0].forward_list.disabled = false;
			}
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
			<li><a href="mail_accounts.php">{$TR_MENU_OVERVIEW}</a></li>
			<li><a>{$TR_CREATE_CATCHALL_MAIL_ACCOUNT}</a></li>
		</ul>
	</div>
	<div class="left_menu">{include file="$MENU"}</div>
	<div class="main">
		{if isset($MESSAGE)}
		<div class="{$MSG_TYPE}">{$MESSAGE}</div>
		{/if}
		<h2 class="email"><span>{$TR_CREATE_CATCHALL_MAIL_ACCOUNT}</span></h2>
		<form action="mail_catchall_add.php" method="post" id="client_mail_catchall_add">
			<table>
				<tr>
					<td><input type="radio" name="mail_type" id="mail_type1" value="normal" onclick="changeType('normal');" {$NORMAL_MAIL} />&nbsp;{$TR_MAIL_LIST}</td>
					<td>
						<select name="mail_id">
							{section name=i loop=$MAIL_ACCOUNT}
							<option value="{$MAIL_ID[i]};{$MAIL_ACCOUNT_PUNNY[i]};">{$MAIL_ACCOUNT[i]}</option>
							{/section}
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2"><input type="radio" name="mail_type" id="mail_type2" value="forward" onclick="changeType('forward');" {$FORWARD_MAIL} />&nbsp;{$TR_FORWARD_MAIL}</td>
				</tr>
				<tr>
					<td>{$TR_FORWARD_TO}</td>
					<td><textarea name="forward_list" id="forward_list" cols="35" rows="5"></textarea></td>
				</tr>
			</table>
			<div class="buttons">
				<input type="hidden" name="id" value="{$ID}" />
				<input type="hidden" name="uaction" value="create_catchall" />
				<input type="submit" name="Submit" value="{$TR_CREATE_CATCHALL}" />
			</div>
		</form>
	</div>
{include file='client/footer.tpl'}