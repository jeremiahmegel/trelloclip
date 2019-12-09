browser.pageAction.onClicked.addListener ->
	browser.tabs.query(
		currentWindow: true
		active: true
		([current_tab]) ->
			{ board, card } =
				await browser.tabs.sendMessage(
					current_tab.id
					'get_card'
				)
			markdown_link =
				"[Trello: _#{board.name}_ - _#{card.name}_](#{card.url})"
			navigator.clipboard.writeText(markdown_link)
	)
