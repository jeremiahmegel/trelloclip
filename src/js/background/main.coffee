blink_badge = ->
	browser.browserAction.setBadgeText(text: ' ')

	setTimeout(
		->
			browser.browserAction.setBadgeText(text: '')
		, 250
	)

copy_card_link = ->
	browser.tabs.query(
		{
			currentWindow: true,
			active: true
		},
		([current_tab]) ->
			try
				{ board, card } =
					await browser.tabs.sendMessage(
						current_tab.id,
						'get_card'
					)

				markdown_link =
					"[Trello: _#{board.name}_ - _#{card.name}_](#{card.url})"

				navigator.clipboard.writeText(markdown_link)

				browser.browserAction.setBadgeBackgroundColor(color: '#00ff00') # green
			catch
				browser.browserAction.setBadgeBackgroundColor(color: '#ff0000') # red

			blink_badge()
	)

browser.browserAction.onClicked.addListener ->
	copy_card_link()
