{**
 * summary.tpl
 *
 * Copyright (c) 2005-2006 The Public Knowledge Project
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display a summary of a Marc record.
 *
 * $Id$
 *}

<span class="title">{$entries.245|escape|truncate:90|default:"&mdash"}</span><br />
<div class="recordContents">
	{if $entries.100}<span class="author">{if is_array($entries.100)}{foreach from=$entries.100 name="creators" item=creator}{$creator|escape|default:"&mdash;"}{if !$smarty.foreach.creators.last}</span><br /><span class="author">{/if}{/foreach}{else}{$entries.100|escape|default:"&mdash;"}{/if}</span><br/>{/if}
	{$record->getDatestamp()|date_format:$dateFormatShort}<br />
	<a href="{url page="record" op="view" path=$record->getRecordId()}" class="action">{translate key="browse.viewRecord"}</a>{if $record->getUrl($entries)|assign:"recordUrl":true}&nbsp;|&nbsp;<a href="{$recordUrl}" class="action">{translate key="browse.viewOriginal"}</a>{/if}
</div>
