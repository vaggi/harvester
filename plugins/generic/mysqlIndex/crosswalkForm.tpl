{**
 * crosswalkForm.tpl
 *
 * Copyright (c) 2005-2008 Alec Smecher and John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Basic crosswalk settings under site administration.
 *
 * $Id$
 *}
{if $crosswalkId}
{assign var="pageTitle" value="plugins.generic.mysqlIndex.editCrosswalk"}
{else}
{assign var="pageTitle" value="plugins.generic.mysqlIndex.addCrosswalk"}
{/if}
{assign var="helpTopicId" value="admin.crosswalkForm"}
{include file="common/header.tpl"}

<script type="text/javascript">
{literal}
<!--
function refreshForm() {
{/literal}
	document.crosswalkForm.action='{url}';
	document.crosswalkForm.submit();
{literal}
}
-->
{/literal}
</script>

<br />

<div id="crosswalkForm">
	<form name="crosswalkForm" method="post" action="{url op="updateCrosswalk"}">
	<input type="hidden" name="overrideSortable" value="1"/>
	{if $crosswalkId}
	<input type="hidden" name="crosswalkId" value="{$crosswalkId}" />
	{/if}
	
	{include file="common/formErrors.tpl"}
	
	<table class="listing" width="100%">
		<tr valign="top">
			<td width="20%" class="label">{fieldLabel name="name" key="plugins.generic.mysqlIndex.crosswalk.name" required="true"}</td>
			<td colspan="{if $sortable}3{else}2{/if}" width="80%" class="value"><input type="text" id="name" name="name" value="{$name|escape}" size="40" maxlength="120" class="textField" /></td>
		</tr>
		<tr valign="top">
			<td class="label">{fieldLabel name="description" key="plugins.generic.mysqlIndex.crosswalk.description" required="true"}</td>
			<td colspan="{if $sortable}3{else}2{/if}" class="value"><textarea name="description" id="description" cols="40" rows="10" class="textArea">{$description|escape}</textarea></td>
		</tr>
	
		<tr>
			<td colspan="{if $sortable}4{else}3{/if}" class="separator">&nbsp;</td>
		</tr>
	
		<tr valign="top">
			<td class="label">{fieldLabel name="url" key="plugins.generic.mysqlIndex.crosswalk.publicCrosswalkId"}</td>
			<td colspan="{if $sortable}3{else}2{/if}" class="value">
				<input type="text" id="publicCrosswalkId" name="publicCrosswalkId" value="{$publicCrosswalkId|escape}" size="20" maxlength="40" class="textField" />
				<br/>
				{translate key="plugins.generic.mysqlIndex.form.publicCrosswalkId.description"}
			</td>
		</tr>
	
		<tr>
			<td colspan="{if $sortable}4{else}3{/if}" class="separator">&nbsp;</td>
		</tr>
	
		<tr valign="top">
			<td class="label">{translate key="plugins.generic.mysqlIndex.crosswalk.type"}</td>
			<td colspan="{if $sortable}3{else}2{/if}" class="value">
				{foreach from=$crosswalkTypes item=typeName key=typeId}
					<input {if $crosswalkType == $typeId}checked {/if}onclick="refreshForm()" name="crosswalkType" type="radio" value="{$typeId}">&nbsp;&nbsp;{translate key=$typeName}<br />
				{/foreach}
				<input id="sortable" type="checkbox"{if $sortable} checked="checked"{/if} onclick="refreshForm()" name="sortable"/><label for="sortable">{translate key="plugins.generic.mysqlIndex.crosswalk.sortableDescription"}</label>
			</td>
		</tr>
	
		<tr>
			<td colspan="{if $sortable}4{else}3{/if}" class="separator">&nbsp;</td>
		</tr>
	
		<tr valign="top">
			<td class="label"><label for="schemaPluginName">{translate key="plugins.generic.mysqlIndex.schemaFilter"}</label></td>
			<td colspan="{if $sortable}3{else}2{/if}" class="value">
				<select id="schemaPluginName" name="schemaPluginName" class="selectMenu" onchange="refreshForm()">
					<option value="">{translate key="plugins.generic.mysqlIndex.schemaFilter.all"}</option>
					{foreach from=$schemaPlugins item=schemaPlugin}
						<option {if $schemaPlugin->getName() == $schemaPluginName}selected {/if}value="{$schemaPlugin->getName()|escape}">{$schemaPlugin->getSchemaDisplayName()}</option>
					{/foreach}
				</select>
			</td>
		</tr>
	
		<tr>
			<td colspan="{if $sortable}4{else}3{/if}" class="headseparator">&nbsp;</td>
		</tr>
	
		<tr>
			<td class="label"><strong>{translate key="plugins.generic.mysqlIndex.schema"}</strong></td>
			{if $sortable}<td class="label"><strong>{translate key="plugins.generic.mysqlIndex.sort"}</strong></td>{/if}
			<td class="label"><strong>{translate key="plugins.generic.mysqlIndex.search"}</strong></td>
			<td class="label"><strong>{translate key="record.field"}</strong></td>
		</tr>
		<tr>
			<td colspan="{if $sortable}4{else}3{/if}" class="separator">&nbsp;</td>
		</tr>
	
		{foreach from=$filteredPlugins item=schemaPlugin name="schemaPlugins"}
			{assign var=fieldList value=$schemaPlugin->getFieldList()}
			{assign var=firstField value="1"}
			{foreach from=$fieldList item=field}
				{assign var=fieldId value=$schemaPlugin->getFieldId($field)}
				<tr valign="top">
					{if $firstField}
						<td>{$schemaPlugin->getSchemaDisplayName()}</td>
						{assign var=firstField value="0"}
					{else}
						<td>&nbsp;</td>
					{/if}
					{if $sortable}
						<td align="center" width="5%">
							<input type="radio" {if is_array($sortableFieldIds) && in_array($fieldId, $sortableFieldIds)}checked {/if}name="{$schemaPlugin->getName()|escape}-sort" value="{$field|escape}" />
						</td>
					{/if}
					<td width="5%" align="center">
						{* Determine whether this field is already chosen *}
						{assign var=isFieldChosen value=0}
						{foreach from=$fields item=chosenField}
							{assign var=thisSchemaPlugin value=$chosenField->getSchemaPlugin()}
							{if $thisSchemaPlugin->getName() == $schemaPlugin->getName() && $field == $chosenField->getName()}
								{assign var=isFieldChosen value=1}
							{/if}
						{/foreach}
						<input type="hidden" name="{$schemaPlugin->getName()|escape}-{$field|escape}-displayed" value="1"/>
						<input type="checkbox" {if $isFieldChosen}checked="checked" {/if}class="checkbox" name="{$schemaPlugin->getName()|escape}-{$field|escape}" value="1"/>
					</td>
					<td class="value">
						<strong>{$schemaPlugin->getFieldName($field)|escape}</strong>:&nbsp;{$schemaPlugin->getFieldDescription($field)|escape}<br/>
					</td>
				</tr>
			{/foreach}
			<tr>
				<td colspan="{if $sortable}4{else}3{/if}" class="{if $smarty.foreach.schemaPlugins.last}end{/if}separator">&nbsp;</td>
			</tr>
		{/foreach}
	</table>
	
	<p><input type="submit" value="{translate key="common.save"}" class="button defaultButton" /> <input type="button" value="{translate key="common.cancel"}" class="button" onclick="document.location.href='{url op="crosswalks"}'" /></p>
	
	</form>
	
	<p><span class="formRequired">{translate key="common.requiredField"}</span></p>
</div>
{include file="common/footer.tpl"}
