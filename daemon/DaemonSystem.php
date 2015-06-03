<?php
/**
 * EasySCP a Virtual Hosting Control Panel
 * Copyright (C) 2010-2015 by Easy Server Control Panel - http://www.easyscp.net
 *
 * This work is licensed under the Creative Commons Attribution-NoDerivs 3.0 Unported License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/3.0/.
 *
 * @link 		http://www.easyscp.net
 * @author 		EasySCP Team
 */

/**
 * EasySCP Daemon system functions
 */
class DaemonSystem {
	/**
	 * Handles DaemonSystem requests
	 *
	 * @param string $Input
	 * @return mixed
	 */
	public static function Start($Input) {
		System_Daemon::debug('Starting "DaemonSystem::Start" subprocess.');

		$data = explode(" ", $Input);
		switch ($data[0]) {
			case 'cron':
				System_Daemon::debug('Starting "cron" subprocess.');
				$retVal = self::handleCronjob($data[1]);
				if ($retVal!==true){
					System_Daemon::warning('Failed to handle Cronjob for '.$data[1]);
					System_Daemon::debug('Finished "cron" subprocess.');
					return false;
				}
				System_Daemon::debug('Finished "cron" subprocess.');
				break;
			case 'direxists':
				System_Daemon::debug('Starting "direxists" subprocess.');
				if (is_dir($data[1])){
					System_Daemon::debug('Directory '.$data[1].' exists');
					System_Daemon::debug('Finished "direxists" subprocess.');
					return true;
				} else {
					System_Daemon::debug('Directory '.$data[1].' does not exist');
					System_Daemon::debug('Finished "direxists" subprocess.');
					return false;
				}
				break;
			case 'fileexists':
				System_Daemon::debug('Starting "fileexists" subprocess.');
				if (is_file($data[1])){
					System_Daemon::debug('File '.$data[1].' exists');
					System_Daemon::debug('Finished "fileexists" subprocess.');
					return true;
				} else {
					System_Daemon::debug('File '.$data[1].' does not exist');
					System_Daemon::debug('Finished "fileexists" subprocess.');
					return false;
				}
				break;
			case 'isexecutable':
				System_Daemon::debug('Starting "isexecutable" subprocess.');
				if(self::Start('fileexists '.$data[1])){
					if (is_executable($data[1])){
						System_Daemon::debug('File '.$data[1].' is executable');
						System_Daemon::debug('Finished "isexecutable" subprocess.');
						return true;
					} else {
						System_Daemon::debug('File '.$data[1].' is not executable');
						System_Daemon::debug('Finished "isexecutable" subprocess.');
						return false;
					}
				} else {
					System_Daemon::debug('Finished "isexecutable" subprocess.');
					return false;
				}
				break;
			case 'rebuildConfig':
				System_Daemon::debug('Starting "rebuildConfig" subprocess.');
				// DaemonCommon::systemSetSystemPermissions();
				// DaemonCommon::systemSetGUIPermissions();
				System_Daemon::debug('Finished "rebuildConfig" subprocess.');
				break;
			case 'setPermissions':
				System_Daemon::debug('Starting "setPermissions" subprocess.');
				DaemonCommon::systemSetSystemPermissions();
				DaemonCommon::systemSetGUIPermissions();
				System_Daemon::debug('Finished "setPermissions" subprocess.');
				break;
			default:
				System_Daemon::warning("Don't know what to do with ".$data[0]);
				return false;
		}

		System_Daemon::debug('Finished "DaemonSystem::Start" subprocess.');

		return true;
	}
	protected static function handleCronjob($userID){
		$sql_param = array(
			':user_id'	=> $userID,
			':active'	=> 'yes'
		);
		$sql_query = "
			SELECT
				*
			FROM
				cronjobs
			WHERE 
				active = :active
			AND
				user_id = :user_id
		";
		DB::prepare($sql_query);
		$cronData = DB::execute($sql_param);

		$sql_param = array(
			':user_id'	=> $userID
		);
		$sql_query = "
			SELECT 
				admin_name
			FROM
				admin
			WHERE
				admin_id = :user_id
		";
		DB::prepare($sql_query);
		$adminData = DB::execute($sql_param,true);

		$tpl_param = array('ADMIN'=>$adminData['admin_name']);
		$tpl = DaemonCommon::getTemplate($tpl_param);

		while ($cronJob = $cronData->fetch()){
			$tpl->append(
				array(
					'MINUTE'	=> $cronJob['minute'],
					'HOUR'		=> $cronJob['hour'],
					'DOM'		=> $cronJob['dayofmonth'],
					'MONTH'		=> $cronJob['month'],
					'DOW'		=> $cronJob['dayofweek'],
					'USER'		=> $cronJob['user'],
					'COMMAND'	=> $cronJob['command'],
				)
			);
		}
		// write Apache config
		$config = $tpl->fetch("tpl/cron.tpl");
		$confFile = DaemonConfig::$cfg->{'CRON_DIR'} . '/' . $adminData['admin_name'];
		System_Daemon::debug($confFile);
		$retVal = DaemonCommon::systemWriteContentToFile($confFile, $config, DaemonConfig::$cfg->{'ROOT_USER'}, DaemonConfig::$cfg->{'CRON_GROUP'}, 0600, false);

		if ($retVal !== true) {
			$msg = 'Failed to write'. $confFile;
			System_Daemon::warning($msg);
			return $msg.'<br />'.$retVal;
		} else {
			System_Daemon::debug($confFile.' successfully written!');
		}
		
		$sql_param = array(
			':user_id'	=> $userID,
			':status'	=> 'ok'
		);
		$sql_query = "
			UPDATE
				cronjobs
			SET
				status = :status
			WHERE
				user_id = :user_id
			AND
				status != :status
		";
		DB::prepare($sql_query);
		$cronData = DB::execute($sql_param)->closeCursor();
		System_Daemon::debug('handleCronjob successfully ended!');
		return true;
	}
}
?>
