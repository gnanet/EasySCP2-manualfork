{include file='client/header.tpl'}
<body>
	<script type="text/javascript">
	/* <![CDATA[ */
		function setForwardReadonly(obj){
			if(obj.value == 1) {
				document.getElementById('client_subdomain_add').elements['forward'].readOnly = false;
				document.getElementById('client_subdomain_add').elements['forward_prefix'].disabled = false;
			} else {
				document.getElementById('client_subdomain_add').elements['forward'].readOnly = true;
				document.getElementById('client_subdomain_add').elements['forward'].value = '';
				document.getElementById('client_subdomain_add').elements['forward_prefix'].disabled = true;
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
			<li><a href="domains_manage.php">{$TR_MENU_MANAGE_DOMAINS}</a></li>
			<li><a href="domains_manage.php">{$TR_MENU_OVERVIEW}</a></li>
			<li>{$TR_EDIT_SUBDOMAIN}</li>
		</ul>
	</div>
	<div class="left_menu">{include file="$MENU"}</div>
	<div class="main">
		{if isset($MESSAGE)}
		<div class="{$MSG_TYPE}">{$MESSAGE}</div>
		{/if}
		<h2 class="domains"><span>{$TR_EDIT_SUBDOMAIN}</span></h2>
		<form action="subdomain_edit.php?edit_id={$ID}" method="post" id="client_subdomain_edit">
			<table>
				<tr>
					<td>{$TR_SUBDOMAIN_NAME}</td>
					<td>{$SUBDOMAIN_NAME}</td>
				</tr>
				<tr>
					<td>{$TR_ENABLE_FWD}</td>
					<td>
						<input type="radio" name="status" id="status1" {$CHECK_EN} value="1" onchange="setForwardReadonly(this);" /> <label for="status1">{$TR_ENABLE}</label><br />
						<input type="radio" name="status" id="status2" {$CHECK_DIS} value="0" onchange="setForwardReadonly(this);" /> <label for="status2">{$TR_DISABLE}</label>
					</td>
				</tr>
				<tr>
					<td>{$TR_FORWARD}</td>
					<td>
						<select name="forward_prefix" style="vertical-align:middle"{$DISABLE_FORWARD}>
							<option value="{$TR_PREFIX_HTTP}"{$HTTP_YES}>{$TR_PREFIX_HTTP}</option>
							<option value="{$TR_PREFIX_HTTPS}"{$HTTPS_YES}>{$TR_PREFIX_HTTPS}</option>
							<option value="{$TR_PREFIX_FTP}"{$FTP_YES}>{$TR_PREFIX_FTP}</option>
						</select>
						<input name="forward" type="text" id="forward" value="{$FORWARD}" />
					</td>
				</tr>
			</table>
			<div class="buttons">
				<input type="hidden" name="dmn_type" value="{$DMN_TYPE}" />
				<input type="hidden" name="dmn_id" value="{$DMN_ID}" />
				<input type="hidden" name="uaction" value="modify" />
				<input name="Submit" type="submit"  value="{$TR_MODIFY}" />
			</div>
		</form>
	</div>
{include file='client/footer.tpl'}