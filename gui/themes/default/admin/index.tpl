{extends file="common/layout.tpl"}

{block name=TR_PAGE_TITLE}{$TR_PAGE_TITLE}{/block}

{block name=CUSTOM_JS}{/block}

{block name=CONTENT_HEADER}{$TR_GENERAL_INFORMATION}{/block}

{block name=BREADCRUMP}
<li><a href="/admin/index.php">{$TR_MENU_GENERAL_INFORMATION}</a></li>
<li><a>{$TR_MENU_OVERVIEW}</a></li>
{/block}

{block name=BODY}
{if isset($TR_NEW_MSGS)}
<div class="{$NEW_MSG_TYPE}"><a href="/admin/ticket_system.php">{$TR_NEW_MSGS}</a></div>
{/if}
{if isset($UPDATE)}
<div class="{$UPDATE_TYPE}">{$UPDATE}</div>
{/if}
{if isset($DATABASE_UPDATE)}
<div class="{$DATABASE_MSG_TYPE}">{$DATABASE_UPDATE}</div>
{/if}
<h2 class="general"><span>{$TR_GENERAL_INFORMATION}</span></h2>
<table>
	<tr>
		<td>{$TR_ACCOUNT_NAME}</td>
		<td>{$ACCOUNT_NAME}</td>
	</tr>
	<tr>
		<td>{$TR_ADMIN_USERS}</td>
		<td>{$ADMIN_USERS}</td>
	</tr>
	<tr>
		<td>{$TR_RESELLER_USERS}</td>
		<td>{$RESELLER_USERS}</td>
	</tr>
	<tr>
		<td>{$TR_NORMAL_USERS}</td>
		<td>{$NORMAL_USERS}</td>
	</tr>
	<tr>
		<td>{$TR_DOMAINS}</td>
		<td>{$DOMAINS}</td>
	</tr>
	<tr>
		<td>{$TR_SUBDOMAINS}</td>
		<td>{$SUBDOMAINS}</td>
	</tr>
	<tr>
		<td>{$TR_DOMAINS_ALIASES}</td>
		<td>{$DOMAINS_ALIASES}</td>
	</tr>
	<tr>
		<td>{$TR_MAIL_ACCOUNTS}</td>
		<td>{$MAIL_ACCOUNTS}</td>
	</tr>
	<tr>
		<td>{$TR_FTP_ACCOUNTS}</td>
		<td>{$FTP_ACCOUNTS}</td>
	</tr>
	<tr>
		<td>{$TR_SQL_DATABASES}</td>
		<td>{$SQL_DATABASES}</td>
	</tr>
	<tr>
		<td>{$TR_SQL_USERS}</td>
		<td>{$SQL_USERS}</td>
	</tr>
</table>
<h2 class="traffic"><span>{$TR_SERVER_TRAFFIC}</span></h2>
{if isset($TR_TRAFFIC_WARNING)}
<div class="warning">{$TR_TRAFFIC_WARNING}</div>
{/if}
{$TRAFFIC_WARNING}
<div class="graph"><span style="width:{$TRAFFIC_PERCENT}%">&nbsp;</span></div>
{/block}