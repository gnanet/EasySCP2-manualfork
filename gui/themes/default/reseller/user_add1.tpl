{include file='reseller/header.tpl'}
<body>
	<script type="text/javascript">
	/* <![CDATA[ */
		jQuery(document).ready(function(){
			// Tooltips - begin
			jQuery('#dmn_help').EasySCPtooltips({ msg:"{$TR_DMN_HELP}" });
			// Tooltips - end

			// Datepicker - begin		
			jQuery('#dmn_exp_never').change(function() {
				if (jQuery(this).is(':checked')) {
					jQuery('#dmn_exp_date').attr('disabled', 'disabled');
				} else {
					jQuery('#dmn_exp_date').removeAttr('disabled');
				}
			});
			// Datepicker - end

			// jQuery UI Datepicker
			jQuery('#dmn_exp_date').datepicker({
				dateFormat: '{$VL_DATE_FORMAT}',
				dayNamesMin: ['{$TR_SU}', '{$TR_MO}', '{$TR_TU}', '{$TR_WE}', '{$TR_TH}', '{$TR_FR}', '{$TR_SA}'],
				monthNames: ['{$TR_JANUARY}', '{$TR_FEBRUARY}', '{$TR_MARCH}', '{$TR_APRIL}', '{$TR_MAY}', '{$TR_JUNE}', '{$TR_JULY}', '{$TR_AUGUST}', '{$TR_SEPTEMBER}', '{$TR_OCTOBER}', '{$TR_NOVEMBER}', '{$TR_DECEMBER}'],
				isRTL: false,
				showOtherMonths: true,
				defaultDate: '+1y',
				minDate: new Date()
			});
			jQuery('#ui-datepicker-div').hide();
		});
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
			<li><a href="users.php">{$TR_MENU_OVERVIEW}</a></li>
			<li><a>{$TR_ADD_USER}</a></li>
		</ul>
	</div>
	<div class="left_menu">{include file="$MENU"}</div>
	<div class="main">
		{if isset($MESSAGE)}
		<div class="{$MSG_TYPE}">{$MESSAGE}</div>
		{/if}
		{if !isset($ADD_FORM)}
		<h2 class="general"><span>{$TR_ADD_USER}</span></h2>
		<form action="user_add1.php" method="post" id="reseller_user_add1">
			<fieldset>
				<legend>{$TR_CORE_DATA}</legend>
				<table>
					<tr>
						<td>{$TR_DOMAIN_NAME} <span id="dmn_help" class="icon i_help">&nbsp;</span></td>
						<td><input type="text" name="dmn_name" id="dmn_name" value="{$DMN_NAME_VALUE}"/></td>
					</tr>
					<tr>
						<td>{$TR_DOMAIN_EXPIRE}</td>
						<td>
							<input type="text" name="dmn_expire_date" id="dmn_exp_date" value="" disabled="disabled" />
							&nbsp;{$TR_EXPIRE_CHECKBOX} <input type="checkbox" name="dmn_expire_never" id="dmn_exp_never" checked="checked" />
						</td>
					</tr>
					{if !isset($ADD_USER)}
					<tr>
						<td>{$TR_CHOOSE_HOSTING_PLAN}</td>
						<td>
							<select id="dmn_tpl" name="dmn_tpl">
								{section name=i loop=$HP_NAME}
								<option value="{$CHN[i]}" {$CH_SEL[i]}>{$HP_NAME[i]}</option>
								{/section}
							</select>
						</td>
					</tr>
					{if !isset($PERSONALIZE)}
					<tr>
						<td>{$TR_PERSONALIZE_TEMPLATE}</td>
						<td>
							<input type="radio" name="chtpl" id="chtpl_yes" value="_yes_" {$CHTPL1_VAL} /><label for="chtpl_yes">{$TR_YES}</label>
							<input type="radio" name="chtpl" id="chtpl_no" value="_no_" {$CHTPL2_VAL} /><label for="chtpl_no">{$TR_NO}</label>
						</td>
					</tr>
					{/if}
					{/if}
				</table>
			</fieldset>
			<div class="buttons">
				<input type="hidden" name="uaction" value="user_add_nxt" />
				<input type="submit" name="Submit"  value="{$TR_NEXT_STEP}" />
			</div>
		</form>
		{/if}
	</div>
{include file='reseller/footer.tpl'}