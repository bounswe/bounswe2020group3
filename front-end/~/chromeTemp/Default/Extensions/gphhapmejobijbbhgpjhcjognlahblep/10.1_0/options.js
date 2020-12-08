/*
    GNOME Shell integration for Chrome
    Copyright (C) 2016-2018  Yuri Konotopov <ykonotopov@gnome.org>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
 */

function save_options()
{
	var showReleaseNotes = $('#show_release_notes_yes').prop('checked');
	var syncExtensions = $('#synchronize_extensions_yes').prop('checked');
	var updateCheck = $('#update_check_yes').prop('checked');
	var updateCheckEnabledOnly = $('#update_check_enabled_yes').prop('checked');
	var updateCheckPeriod = $('#update_check_period').val();
	var useLightIcon = $('#use_light_icon_yes').prop('checked');
	updateCheckPeriod = Math.max(3, updateCheckPeriod);

	chrome.storage.sync.set({
		showReleaseNotes:	showReleaseNotes,
		updateCheck:		updateCheck,
		updateCheckEnabledOnly: updateCheckEnabledOnly,
		updateCheckPeriod:	updateCheckPeriod
	}, function () {
		chrome.storage.local.set({
			syncExtensions:	syncExtensions,
			useLightIcon:	useLightIcon
		}, function() {
			if(syncExtensions)
			{
				syncType = document.getElementById('syncChoice').returnValue;
				if(!syncType || syncType === 'local')
				{
					GSC.sync.getExtensions($.Deferred().done(function (extensions) {
						var localExtensions = {};
						$.each(extensions, function (uuid, extension) {
							if(extension.local && extension.localState != EXTENSION_STATE.UNINSTALLED)
							{
								localExtensions[extension.uuid] = {
									uuid:	extension.uuid,
									name:	extension.name,
									state:	extension.localState
								};
							}
						});

						chrome.storage.sync.set({
							extensions: localExtensions
						}, function() {
							showSuccessStatus();
						});
					}).fail(function (message) {
						$('#error')
							.html(message)
							.show()
							.delay(15000)
							.hide(250);
					}));
				}
				else if(syncType === 'remote')
				{
					chrome.runtime.sendMessage(GS_CHROME_ID, MESSAGE_SYNC_FROM_REMOTE);
					showSuccessStatus();
				}
			}
			else
			{
				showSuccessStatus();
			}
		});
	});
}

function showSuccessStatus()
{
	// Update status to let user know options were saved.
	$('#status')
		.show()
		.delay(750)
		.hide(250);
}

function restore_options()
{
	tabby.init();

	chrome.storage.sync.get(DEFAULT_SYNC_OPTIONS, function (items) {
		function toggle_notice(show, id) {
			let notice = $('#' + id)
				.closest('dl')
				.find('dt br, dt span.notice');

			if (show)
			{
				notice.show();
			}
			else
			{
				notice.hide();
			}
		}

		function toggle_update_notice(show) {
			toggle_notice(show, "update_check_yes");
		}

		function toggle_update_enable_notice(show) {
			toggle_notice(show, "update_check_enabled_yes");
		}

		function disable_update_check() {
			if (items.updateCheck)
			{
				items.updateCheck = false;

				chrome.storage.sync.set({
					updateCheck: items.updateCheck
				});
			}

			toggle_update_notice(true);
		}

		function disable_update_enabled_only() {
			if (items.updateCheckEnabledOnly)
			{
				items.updateCheckEnabledOnly = false;

				chrome.storage.sync.set({
					updateCheckEnabledOnly: items.updateCheckEnabledOnly
				});
			}

			toggle_update_enable_notice(true);
		}

		GSC.onInitialize().then(function (response) {
			if (!GSC.nativeUpdateCheckSupported(response))
			{
				disable_update_check();
			}
			else
			{
				$("input[name='update_check'], #update_check_period").removeAttr('disabled');
				$('#update_check_period').val(items.updateCheckPeriod);
				toggle_update_notice(false);
				retrieveUpdateTimes();
			}

			if (!GSC.nativeUpdateCheckEnabledOnlySupported(response))
			{
				disable_update_enabled_only();
			}
			else
			{
				$("input[name='update_check_enabled']").removeAttr('disabled');
				toggle_update_enable_notice(false);
			}

			setCheckUpdate(items.updateCheck);
			setCheckUpdateEnabledOnly(items.updateCheckEnabledOnly);
		}, function(response) {
			disable_update_check();
		});

		setReleaseNotes(items.showReleaseNotes);
	});

	if(COMPAT.SYNC_STORAGE)
	{
		updateSynchronizationStatus();
	}
	else
	{
		$('a[data-i18n="synchronization"]').parent().remove();
		$('#synchronize_extensions_yes').closest('dl').hide();
	}

	chrome.storage.local.get(DEFAULT_LOCAL_OPTIONS, function (items) {
		if(items.syncExtensions)
		{
			chrome.permissions.contains({
				permissions: ["idle"]
			}, function (result) {
				setSyncExtensions(result);
			});
		}
		else if(COMPAT.SYNC_STORAGE)
		{
			setSyncExtensions(false);
		}

		setLightIcon(items.useLightIcon);
	});
}

function retrieveUpdateTimes()
{
	chrome.storage.local.get({
		lastUpdateCheck: null
	}, function (items) {
		if(items.lastUpdateCheck)
		{
			$('#last_update_check').text(items.lastUpdateCheck);
		}
		else
		{
			$('#last_update_check').text(m('never'));
		}
	});

	retrieveNextUpdateTime();
}

function retrieveNextUpdateTime()
{
	chrome.alarms.get(ALARM_UPDATE_CHECK, function (alarm) {
		if (alarm)
		{
			$('#next_update_check').text(new Date(alarm.scheduledTime).toLocaleString());
		}
		else
		{
			$('#next_update_check').text(m('never'));
		}
	});
}

function setCheckUpdate(result)
{
	if(result)
		$('#update_check_yes').prop('checked', true);
	else
		$('#update_check_no').prop('checked', true);
}

function setCheckUpdateEnabledOnly(result)
{
	if(result)
		$('#update_check_enabled_yes').prop('checked', true);
	else
		$('#update_check_enabled_no').prop('checked', true);
}

function setLightIcon(result)
{
	if(result)
		$('#use_light_icon_yes').prop('checked', true);
	else
		$('#use_light_icon_no').prop('checked', true);
}

function setReleaseNotes(result)
{
	if(result)
		$('#show_release_notes_yes').prop('checked', true);
	else
		$('#show_release_notes_no').prop('checked', true);
}

function setSyncExtensions(result)
{
	if(result)
		$('#synchronize_extensions_yes').prop('checked', true);
	else
		$('#synchronize_extensions_no').prop('checked', true);
}

function handleSynchronize()
{
	if($('#synchronize_extensions_yes').is(':checked'))
	{
		chrome.permissions.request({
			permissions: ["idle"]
		}, function(granted) {
			if(granted)
			{
				if(!COMPAT.PERMISSIONS_EVENTS)
				{
					chrome.runtime.sendMessage(GS_CHROME_ID, MESSAGE_IDLE_PERMISSION_ADDED);
				}

				chrome.storage.sync.get({
					extensions: {}
				}, function (options) {
					if(!$.isEmptyObject(options.extensions))
					{
						document.getElementById('syncChoice').showModal();
					}
				});
			}
			else
			{
				if(!COMPAT.PERMISSIONS_EVENTS)
				{
					chrome.runtime.sendMessage(GS_CHROME_ID, MESSAGE_IDLE_PERMISSION_REMOVED);
				}

				setSyncExtensions(false);
			}
		});
	}
	else
	{
		chrome.permissions.remove({
			permissions: ["idle"]
		}, function(removed) {
			if(removed && !COMPAT.PERMISSIONS_EVENTS)
			{
				chrome.runtime.sendMessage(GS_CHROME_ID, MESSAGE_IDLE_PERMISSION_REMOVED);
			}

			setSyncExtensions(!removed);
		});
	}
}

function updateSynchronizationStatus()
{
	GSC.sync.getExtensions($.Deferred().done(function (extensions) {
		var keys = Object.keys(extensions).sort(function (a, b) {
			var nameA = extensions[a].name.toLowerCase();
			var nameB = extensions[b].name.toLowerCase();

			if (nameA < nameB)
			{
				return -1;
			}

			if (nameA > nameB)
			{
				return 1;
			}

			return 0;
		});

		$('#synchronization table tbody').empty();
		$.each(keys, function (key, uuid) {
			var extension = extensions[uuid];

			$('#synchronization table tbody').append(
				$('<tr />')
					.append(
						$('<td />').text(extension.name)
					)
					.append(
						$('<td />').addClass(
							extension.local ? 'ok' : 'fail'
						)
					)
					.append(
						$('<td />').addClass(
							extension.localState == EXTENSION_STATE.ENABLED ? 'ok' : 'fail'
						)
					)
					.append(
						$('<td />').addClass(
							extension.remote ? 'ok' : 'fail'
						)
					)
			);
		});
	}).fail(function (message) {
		$('#error')
			.html(message)
			.show()
			.delay(15000)
			.hide(250);
	}));
}

i18n();

document.addEventListener('DOMContentLoaded', restore_options);
document.getElementById('save').addEventListener('click', save_options);

$.each(document.getElementsByName('synchronize_extensions'), function(index, control) {
	control.addEventListener('change', handleSynchronize);
});


// Compat: Firefox
dialogPolyfill.registerDialog(document.getElementById('syncChoice'));
document.getElementById('syncChoice').addEventListener('close', function() {
	if(document.getElementById('syncChoice').returnValue === 'cancel')
	{
		chrome.permissions.remove({
			permissions: ["idle"]
		}, function(removed) {
			if(removed && !COMPAT.PERMISSIONS_EVENTS)
			{
				chrome.runtime.sendMessage(GS_CHROME_ID, MESSAGE_IDLE_PERMISSION_REMOVED);
			}

			setSyncExtensions(!removed);
		});
	}
});

if($('#translation_credits div').is(':empty'))
{
	$('.translation_credits_container').remove();
}

chrome.storage.onChanged.addListener(function (changes, areaName) {
	if (areaName === 'local')
	{
		if(changes.lastUpdateCheck && changes.lastUpdateCheck.newValue)
		{
			$('#last_update_check').text(changes.lastUpdateCheck.newValue);
		}
	}

	if (areaName === 'sync' && changes.extensions)
	{
		updateSynchronizationStatus();
	}
});

chrome.runtime.onMessage.addListener(
	function (request, sender, sendResponse) {
		if(sender.id && sender.id === GS_CHROME_ID && request)
		{
			if(request === MESSAGE_NEXT_UPDATE_CHANGED)
			{
				retrieveNextUpdateTime();
			}
			else if(request.signal && request.signal === SIGNAL_EXTENSION_CHANGED)
			{
				updateSynchronizationStatus();
			}
		}
	}
);
