{extends file="common/layout.tpl"}

{block name=TR_PAGE_TITLE}{$TR_PAGE_TITLE}{/block}

{block name=CUSTOM_JS}{/block}

{block name=CONTENT_HEADER}{$TR_DOMAIN_DETAILS}{/block}

{block name=BREADCRUMP}
<li><a href="/admin/manage_users.php">{$TR_MENU_MANAGE_USERS}</a></li>
<li><a href="/admin/manage_users.php">{$TR_MENU_OVERVIEW}</a></li>
<li><a>{$TR_DOMAIN_DETAILS}</a></li>
{/block}

{block name=BODY}
<h2 class="general"><span>{$TR_DOMAIN_DETAILS}</span></h2>
<table>
	<tr>
		<td>{$TR_DOMAIN_NAME}</td>
		<td>{$VL_DOMAIN_NAME}</td>
	</tr>
	<tr>
		<td>{$TR_DOMAIN_IP}</td>
		<td>{$VL_DOMAIN_IP}</td>
	</tr>
	<tr>
		<td>{$TR_STATUS}</td>
		<td>{$VL_STATUS}</td>
	</tr>
	<tr>
		<td>{$TR_PHP_SUPP}</td>
		<td>{$VL_PHP_SUPP}</td>
	</tr>
	<tr>
		<td>{$TR_CGI_SUPP}</td>
		<td>{$VL_CGI_SUPP}</td>
	</tr>
	<tr>
		<td>{$TR_BACKUP_SUPPORT}</td>
		<td>{$VL_BACKUP_SUPPORT}</td>
	</tr>
	<tr>
		<td>{$TR_DNS_SUPP}</td>
		<td>{$VL_DNS_SUPP}</td>
	</tr>
	<tr>
		<td>{$TR_MYSQL_SUPP}</td>
		<td>{$VL_MYSQL_SUPP}</td>
	</tr>
	<tr>
		<td>{$TR_TRAFFIC}</td>
		<td>
			<div class="graph"><span style="width:{$VL_TRAFFIC_PERCENT}%">&nbsp;</span></div>
			{$VL_TRAFFIC_USED} / {$VL_TRAFFIC_LIMIT}
		</td>
	</tr>
	<tr>
		<td>{$TR_DISK}</td>
		<td>
			<div class="graph"><span style="width:{$VL_DISK_PERCENT}%">&nbsp;</span></div>
			{$VL_DISK_USED} / {$VL_DISK_LIMIT}
		</td>
	</tr>
</table>
<br />
<table>
	<tr>
		<th>{$TR_FEATURE}</th>
		<th>{$TR_USED}</th>
		<th>{$TR_LIMIT}</th>
	</tr>
	<tr>
		<td>{$TR_MAIL_ACCOUNTS}</td>
		<td>{$VL_MAIL_ACCOUNTS_USED}</td>
		<td>{$VL_MAIL_ACCOUNTS_LIIT}</td>
	</tr>
	<tr>
		<td>{$TR_FTP_ACCOUNTS}</td>
		<td>{$VL_FTP_ACCOUNTS_USED}</td>
		<td>{$VL_FTP_ACCOUNTS_LIIT}</td>
	</tr>
	<tr>
		<td>{$TR_SQL_DB_ACCOUNTS}</td>
		<td>{$VL_SQL_DB_ACCOUNTS_USED}</td>
		<td>{$VL_SQL_DB_ACCOUNTS_LIIT}</td>
	</tr>
	<tr>
		<td>{$TR_SQL_USER_ACCOUNTS}</td>
		<td>{$VL_SQL_USER_ACCOUNTS_USED}</td>
		<td>{$VL_SQL_USER_ACCOUNTS_LIIT}</td>
	</tr>
	<tr>
		<td>{$TR_SUBDOM_ACCOUNTS}</td>
		<td>{$VL_SUBDOM_ACCOUNTS_USED}</td>
		<td>{$VL_SUBDOM_ACCOUNTS_LIIT}</td>
	</tr>
	<tr>
		<td>{$TR_DOMALIAS_ACCOUNTS}</td>
		<td>{$VL_DOMALIAS_ACCOUNTS_USED}</td>
		<td>{$VL_DOMALIAS_ACCOUNTS_LIIT}</td>
	</tr>
</table>
<form action="manage_users.php" method="post" id="admin_manage_users">
	<div class="buttons">
		<input type="submit" name="Submit"  value="  {$TR_BACK}  " />
	</div>
</form>
{/block}