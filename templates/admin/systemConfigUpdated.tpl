{**
 * templates/admin/systemConfigUpdated.tpl
 *
 * Copyright (c) 2005-2012 Alec Smecher and John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display confirmation of successful configuration update.
 * If necessary, will display new config file contents if config file could not be written.
 *
 *}
{strip}
{assign var="pageTitle" value="admin.systemConfiguration"}
{url|assign:"currentUrl" op="editSystemConfig"}
{assign var="helpTopicId" value="admin.systemConfiguration"}
{include file="common/header.tpl"}
{/strip}

<br/>

{if $writeConfigFailed}
<p>{translate key="admin.overwriteConfigFileInstructions"}</p>
{elseif $displayConfigContents}
<p>{translate key="admin.displayConfigFileInstructions"}</p>
{else}
<p>{translate key="admin.configFileUpdatedInstructions"}</p>
{/if}

{if $writeConfigFailed || $displayConfigContents}
<form class="pkp_form" action="#">
<h4>{translate key="admin.contentsOfConfigFile"}</h4>
<textarea name="config" cols="80" rows="20" class="textArea">{$configFileContents|escape}</textarea>
</form>
<br />
{/if}

<a class="action" href="{url op="systemInfo"}">{translate key="admin.systemInformation"}</a>

{include file="common/footer.tpl"}

