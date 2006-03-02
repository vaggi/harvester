<?php

/**
 * MarcPlugin.inc.php
 *
 * Copyright (c) 2005-2006 The Public Knowledge Project
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @package plugins
 *
 * Marc schema plugin
 *
 * $Id$
 */

import('plugins.SchemaPlugin');

class MarcPlugin extends SchemaPlugin {
	/**
	 * Register the plugin.
	 */
	function register($category, $path) {
		$success = parent::register($category, $path);
		$this->addLocaleData();
		return $success;
	}

	function getName() {
		return 'MarcPlugin';
	}

	/**
	 * Get the display name of this plugin's protocol.
	 * @return String
	 */
	function getSchemaDisplayName() {
		return Locale::translate('plugins.schemas.marc.schemaName');
	}

	/**
	 * Get a description of the plugin.
	 */
	function getDescription() {
		return Locale::translate('plugins.schemas.marc.description');
	}

	function &getXMLHandler(&$harvester) {
		$this->import('MarcXMLHandler');
		$handler =& new MarcXMLHandler(&$harvester);
		return $handler;
	}

	function getFieldList() {
		static $fieldList;
		if (!isset($fieldList)) {
			$fieldList = array('001', '002', '003', '005', '006', '007', '008', '010', '013', '015', '016', '017', '020', '022', '024', '025', '026', '027', '028', '030', '031', '032', '033', '034', '035', '036', '037', '038', '040', '041', '042', '043', '044', '045', '046', '047', '048', '050', '051', '052', '055', '060', '061', '066', '070', '071', '072', '074', '080', '082', '084', '086', '088', '100', '110', '111', '130', '210', '211', '212', '214', '222', '240', '242', '243', '245', '246', '247', '250', '254', '255', '256', '257', '258', '260', '263', '270', '300', '306', '307', '310', '321', '340', '342', '343', '351', '352', '355', '357', '362', '365', '366', '440', '490', '500', '501', '502', '504', '505', '506', '507', '508', '510', '511', '513', '514', '515', '516', '518', '520', '521', '522', '524', '525', '526', '530', '533', '534', '535', '536', '538', '540', '541', '544', '545', '546', '547', '550', '552', '555', '556', '561', '562', '563', '565', '567', '580', '581', '583', '584', '585', '586', '600', '610', '611', '630', '648', '650', '651', '653', '654', '655', '656', '657', '658', '700', '710', '711', '720', '730', '740', '752', '753', '754', '760', '762', '765', '767', '770', '772', '773', '774', '775', '776', '777', '780', '785', '786', '787', '810', '811', '830', '841', '842', '843', '844', '845', '850', '852', '853', '854', '855', '856', '863', '864', '865', '866', '867', '868', '876', '877', '878', '880', '886', '887');
		}
			echo "COUNT: " . count($fieldList) . "<br/>\n";;
		return $fieldList;
	}

	function getFieldName($fieldSymbolic, $locale = null) {
		return Locale::translate("plugins.schemas.marc.fields.$fieldSymbolic.name", $locale);
	}

	function getFieldDescription($fieldSymbolic, $locale = null) {
		return Locale::translate("plugins.schemas.marc.fields.$fieldSymbolic.description", $locale);
	}

	/**
	 * Get a URL for the supplied record, if available; null otherwise.
	 * @param $record object
	 * @param $entries array
	 * @return string
	 */
	function getUrl(&$record, $entries) {
		$returner = null;
		if (isset($entries['024']) && preg_match('/^[a-z]+:\/\//', $entries['024'])) {
			$returner = $entries['024'];
		}
		return $returner;
	}
}

?>
