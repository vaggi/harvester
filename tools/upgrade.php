<?php

/**
 * @file tools/upgrade.php
 *
 * Copyright (c) 2005-2010 Alec Smecher and John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class upgradeTool
 * @ingroup tools
 *
 * @brief CLI tool for upgrading the harvester.
 *
 * Note: Some functions require fopen wrappers to be enabled.
 */

// $Id$


require(dirname(__FILE__) . '/bootstrap.inc.php');

import('cliTool.UpgradeTool');

class HarvesterUpgradeTool extends UpgradeTool {
	/**
	 * Constructor.
	 * @param $argv array command-line arguments
	 */
	function HarvesterUpgradeTool($argv = array()) {
		parent::UpgradeTool($argv);
	}
}

$tool = new HarvesterUpgradeTool(isset($argv) ? $argv : array());
$tool->execute();

?>
