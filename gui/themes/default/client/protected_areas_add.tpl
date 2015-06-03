{extends file="common/layout.tpl"}

{block name=TR_PAGE_TITLE}{$TR_PAGE_TITLE}{/block}

{block name=CUSTOM_JS}
<script type="text/javascript">
	/* <![CDATA[ */
	$(document).ready(function() {
		$('#protected_areas_delete').click(function() {
			document.location.href = 'protected_areas_delete.php?id={$CDIR}';
		});
		$('#protected_user_manage').click(function() {
			document.location.href = 'protected_user_manage.php';
		});
		$('#protected_areas').click(function() {
			document.location.href = 'protected_areas.php';
		});

		document.forms[0].elements["users[]"].disabled = {$USER_FORM_ELEMENS};
		document.forms[0].elements["groups[]"].disabled = {$GROUP_FORM_ELEMENS};
	});

	function changeType(wath) {
		document.forms[0].elements["users[]"].disabled = wath != "user";
		document.forms[0].elements["groups[]"].disabled = wath == "user";
	}
	/* ]]> */
</script>
{/block}

{block name=CONTENT_HEADER}{$TR_PROTECT_DIR}{/block}

{block name=BREADCRUMP}
<li><a href="/client/webtools.php">{$TR_MENU_WEBTOOLS}</a></li>
<li><a href="/client/protected_areas.php">{$TR_HTACCESS}</a></li>
<li><a>{$TR_PROTECT_DIR}</a></li>
{/block}

{block name=BODY}
<h2 class="htaccess"><span>{$TR_PROTECT_DIR}</span></h2>
<form action="/client/protected_areas_add.php" method="post" id="client_protected_areas_add">
	<table>
		<tr>
			<td>{$TR_PATH}</td>
			<td>
				<input type="text" name="other_dir"  id="other_dir"  value="{$PATH}" />
				<a href="#" onclick="showFileTree();" class="icon i_bc_folder">{$CHOOSE_DIR}</a>
			</td>
		</tr>
		<tr>
			<td>{$TR_AREA_NAME}</td>
			<td><input type="text" name="paname" id="paname" value="{$AREA_NAME}" /></td>
		</tr>
	</table>
	<div>&nbsp;</div>
	<table>
		<thead>
			<tr>
				<th>{$TR_USER}</th>
				<th>{$TR_GROUPS}</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="radio" name="ptype" id="ptype_1" value="user" onfocus="changeType('user');" {$USER_CHECKED} />&nbsp;{$TR_USER_AUTH}</td>
				<td><input type="radio" name="ptype" id="ptype_2" value="group" onfocus="changeType('group');" {$GROUP_CHECKED} />&nbsp;{$TR_GROUP_AUTH}</td>
			</tr>
			<tr>
				<td>
					<select name="users[]" id="users" multiple="multiple" size="5">
						{section name=i loop=$USER_LABEL}
						<option value="{$USER_VALUE[i]}" {$USER_SELECTED[i]}>{$USER_LABEL[i]}</option>
						{/section}
					</select>
				</td>
				<td>
					<select name="groups[]" id="groups" multiple="multiple" size="5">
						{section name=i loop=$GROUP_LABEL}
						<option value="{$GROUP_VALUE[i]}" {$GROUP_SELECTED[i]}>{$GROUP_LABEL[i]}</option>
						{/section}
					</select>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="buttons">
		<input type="hidden" name="cdir" value="{$CDIR}" />
		<input type="hidden" name="sub" value="YES" />
		<input type="hidden" name="use_other_dir" />
		<input type="hidden" name="uaction" value="" />
		<input type="button" name="Button" value="{$TR_PROTECT_IT}" onclick="return sbmt(document.forms[0],'protect_it');" />
		{if isset($UNPROTECT_IT)}
		<input type="button" name="protected_areas_delete" id="protected_areas_delete" value="{$TR_UNPROTECT_IT}" />
		{/if}
		<input type="button" name="protected_user_manage" id="protected_user_manage" value="{$TR_MANAGE_USRES}" />
		<input type="button" name="protected_areas" id="protected_areas" value="{$TR_CANCEL}" />
	</div>
</form>
{/block}