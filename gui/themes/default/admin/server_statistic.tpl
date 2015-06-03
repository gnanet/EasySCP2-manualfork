{extends file="common/layout.tpl"}

{block name=TR_PAGE_TITLE}{$TR_PAGE_TITLE}{/block}

{block name=CUSTOM_JS}{/block}

{block name=CONTENT_HEADER}{$TR_SERVER_STATISTICS}{/block}

{block name=BREADCRUMP}
<li><a href="/admin/server_statistic.php">{$TR_MENU_STATISTICS}</a></li>
<li><a>{$TR_MENU_OVERVIEW}</a></li>
{/block}

{block name=BODY}
<h2 class="general"><span>{$TR_SERVER_STATISTICS}</span></h2>
<form action="server_statistic.php" method="post" id="reseller_user_statistics">
	<fieldset>
		{$TR_MONTH}
		<select name="month" id="month">
			{section name=i loop=$MONTH_VALUE}
			<option{$MONTH_SELECTED[i]}>{$MONTH_VALUE[i]}</option>
			{/section}
		</select>
		{$TR_YEAR}
		<select name="year" id="year">
			{section name=i loop=$YEAR_VALUE}
			<option{$YEAR_SELECTED[i]}>{$YEAR_VALUE[i]}</option>
			{/section}
		</select>
		<input type="hidden" name="uaction" value="change_data" />
		<input type="submit" name="Submit"  value="  {$TR_SHOW}  " />
	</fieldset>
</form>
<table>
	<thead>
		<tr>
			<th>{$TR_DAY}</th>
			<th>{$TR_WEB_IN}</th>
			<th>{$TR_WEB_OUT}</th>
			<th>{$TR_SMTP_IN}</th>
			<th>{$TR_SMTP_OUT}</th>
			<th>{$TR_POP_IN}</th>
			<th>{$TR_POP_OUT}</th>
			<th>{$TR_OTHER_IN}</th>
			<th>{$TR_OTHER_OUT}</th>
			<th>{$TR_ALL_IN}</th>
			<th>{$TR_ALL_OUT}</th>
			<th>{$TR_ALL}</th>
		</tr>
	</thead>
	<tfoot>
		<tr>
			<td>{$TR_ALL}</td>
			<td>{$WEB_IN_ALL}</td>
			<td>{$WEB_OUT_ALL}</td>
			<td>{$SMTP_IN_ALL}</td>
			<td>{$SMTP_OUT_ALL}</td>
			<td>{$POP_IN_ALL}</td>
			<td>{$POP_OUT_ALL}</td>
			<td>{$OTHER_IN_ALL}</td>
			<td>{$OTHER_OUT_ALL}</td>
			<td>{$ALL_IN_ALL}</td>
			<td>{$ALL_OUT_ALL}</td>
			<td>{$ALL_ALL}</td>
		</tr>
	</tfoot>
	<tbody>
		{section name=i loop=$WEB_IN}
		<tr>
			<td><a href="server_statistic_day.php?year={$YEAR[i]}&amp;month={$MONTH[i]}&amp;day={$DAY[i]}" class="link">{$DAY[i]}</a></td>
			<td>{$WEB_IN[i]}</td>
			<td>{$WEB_OUT[i]}</td>
			<td>{$SMTP_IN[i]}</td>
			<td>{$SMTP_OUT[i]}</td>
			<td>{$POP_IN[i]}</td>
			<td>{$POP_OUT[i]}</td>
			<td>{$OTHER_IN[i]}</td>
			<td>{$OTHER_OUT[i]}</td>
			<td>{$ALL_IN[i]}</td>
			<td>{$ALL_OUT[i]}</td>
			<td>{$ALL[i]}</td>
		</tr>
		{/section}
	</tbody>
</table>
{/block}