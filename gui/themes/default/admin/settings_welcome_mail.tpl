{extends file="common/layout.tpl"}

{block name=TR_PAGE_TITLE}{$TR_PAGE_TITLE}{/block}

{block name=CUSTOM_JS}{/block}

{block name=CONTENT_HEADER}{$TR_EMAIL_SETUP}{/block}

{block name=BREADCRUMP}
<li><a href="/admin/settings.php">{$TR_MENU_SETTINGS}</a></li>
<li><a>{$TR_EMAIL_SETUP}</a></li>
{/block}

{block name=BODY}
<h2 class="email"><span>{$TR_EMAIL_SETUP}</span></h2>
<form action="/admin/settings_welcome_mail.php" method="post" id="admin_email_setup">
	<fieldset>
		<legend>{$TR_MESSAGE_TEMPLATE_INFO}</legend>
		<table>
			<tr>
				<td>{$TR_USER_LOGIN_NAME}</td>
				<td>{literal}{USERNAME}{/literal}</td>
			</tr>
			<tr>
				<td>{$TR_USER_PASSWORD}</td>
				<td>{literal}{PASSWORD}{/literal}</td>
			</tr>
			<tr>
				<td>{$TR_USER_REAL_NAME}</td>
				<td>{literal}{NAME}{/literal}</td>
			</tr>
			<tr>
				<td>{$TR_USERTYPE}</td>
				<td>{literal}{USERTYPE}{/literal}</td>
			</tr>
			<tr>
				<td>{$TR_BASE_SERVER_VHOST}</td>
				<td>{literal}{BASE_SERVER_VHOST}{/literal}</td>
			</tr>
			<tr>
				<td>{$TR_BASE_SERVER_VHOST_PREFIX}</td>
				<td>{literal}{BASE_SERVER_VHOST_PREFIX}{/literal}</td>
			</tr>
		</table>
	</fieldset>
	<fieldset>
		<legend>{$TR_MESSAGE_TEMPLATE}</legend>
		<table>
			<tr>
				<td>&nbsp;</td>
				<td><label for="auto_subject"><b>{$TR_SUBJECT}</b></label></td>
				<td><input type="text" name="auto_subject" id="auto_subject" value="{$SUBJECT_VALUE}" /></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><label for="auto_message"><b>{$TR_MESSAGE}</b></label></td>
				<td><textarea name="auto_message" id="auto_message" cols="80" rows="30">{$MESSAGE_VALUE}</textarea></td>
			</tr>
			<tr>
				<td>{$TR_SENDER_EMAIL}</td>
				<td colspan="2" class="content">{$SENDER_EMAIL_VALUE}</td>
			</tr>
			<tr>
				<td>{$TR_SENDER_NAME}</td>
				<td colspan="2">{$SENDER_NAME_VALUE}</td>
			</tr>
		</table>
	</fieldset>
	<div class="buttons">
		<input type="hidden" name="uaction" value="email_setup" />
		<input type="submit" name="Submit" value="{$TR_APPLY_CHANGES}" />
	</div>
</form>
{/block}