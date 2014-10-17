<?php
/**
 * ispCP ω (OMEGA) a Virtual Hosting Control System
 *
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * The Original Code is "ispCP - ISP Control Panel".
 *
 * The Initial Developer of the Original Code is ispCP Team.
 * Portions created by Initial Developer are Copyright (C) 2006-2011 by
 * isp Control Panel. All Rights Reserved.
 *
 * @category	ispCP
 * @package		EasySCP_Registry
 * @copyright	2006-2011 by ispCP | http://isp-control.net
 * @author		Laurent Declercq <laurent.declercq@ispcp.net>
 * @version		SVN: $Id: Registry.php 3762 2011-01-14 08:43:43Z benedikt $
 * @link		http://isp-control.net ispCP Home Site
 * @license		http://www.mozilla.org/MPL/ MPL 1.1
 */

/**
 * Class to store shared data (Better than global variables usage)
 *
 * @package		EasySCP_Registry
 * @author		Laurent declercq <laurent.declercq@ispcp.net>
 * @since		1.0.7
 * @version		1.0.7
 */
class EasySCP_Registry {

	/**
	 * Instance of this class that provides storage for shared data
	 *
	 * @var EasySCP_Registry
	 */
	protected static $_instance = null;

	/**
	 * This class implements the Singleton design pattern
	 *
	 * @return void
	 */
	protected function __construct(){}

	/**
	 * This class implements the Singleton design pattern
	 *
	 * @return void
	 */
	private function __clone(){}

	/**
	 * Get an EasySCP_Registry instance
	 *
	 * Returns an {@link EasySCP_Registry} instance, only creating it if it
	 * doesn't already exist.
	 *
	 * @return EasySCP_Registry An EasySCP_Registry instance
	 */
	public static function getInstance() {

		if(is_null(self::$_instance)) {
			self::$_instance = new self;
		}

		return self::$_instance;
	}

	/**
	 * Getter method to retrieve registered data
	 *
	 * <b>Note:</b> If you want get a reference for data that is not an object, you
	 * should always use this method and not accessed it directly like an object
	 * member.
	 *
	 * @throws EasySCP_Exception
	 * @param string $index Data key name
	 * @return mixed|EasySCP_Config_Handler_File|EasySCP_Config_Handler_Db|EasySCP_Database Registered data
	 */
	public static function &get($index) {

		$instance = self::getInstance();

		if (!$instance->isRegistered($index)) {
			throw new EasySCP_Exception(
				"Error: Data `$index` is not registered!"
			);
		}

		return $instance->$index;
	}

	/**
	 * Overloading on inaccessible members
	 *
	 * This method raises an {@link EasySCP_Exception} if a member is inaccessible
	 * for reading.
	 *
	 * @throws EasySCP_Exception
	 * @param string $index Data key name
	 * @return void
	 */
	public function __get($index) {

		throw new EasySCP_Exception("Error: Data `$index` is not registered!");
	}

	/**
	 * Setter method to register data
	 *
	 * For conveniences reasons, this method return the data registered.
	 *
	 * @param string $index Data key name
	 * @param mixed $value Data value
	 * @return mixed Registered Data
	 */
	public static function &set($index, $value) {

		$instance = self::getInstance();
		$instance->$index = $value;

		return $instance->$index;
	}

	/**
	 * Setter method to register data by reference.
	 *
	 * This method take sense for the singleton objects that provide a method
	 * to recreate the instance. When the object instance is reseted, the alias
	 * that iq registered in the registry will refer to the new instance. It's
	 * not the case with data that were registered with the {@link set()} method
	 * because registered values for objects are objects identifiers and not
	 * real aliases.
	 *
	 * See the {@link http://www.php.net/manual/en/language.oop5.references.php
	 * Php documentation} for more information about this issue.
	 *
	 * @param string $index Data key name
	 * @param mixed $value Data value
	 * @return mixed Registered data
	 */
	public static function &setAlias($index, &$value) {

		$instance = self::getInstance();

		// Small workaround to avoid call of magic __get()
		// See http://bugs.php.net/bug.php?id=52157
		$instance->$index = '';

		return $instance->$index = &$value;
	}

	/**
	 * Check if data is registered
	 *
	 * @param string $index Data key name
	 * @return boolean TRUE if data is registered, FALSE otherwise
	 */
	public static function isRegistered($index) {

		return array_key_exists($index, self::getInstance());
	}
}
