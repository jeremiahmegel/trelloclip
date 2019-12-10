copy_to_clipboard = (str) ->
	try
		await navigator.clipboard.writeText(str)
	catch
		# https://stackoverflow.com/a/18455088
		copy_from = document.createElement('textarea')
		copy_from.textContent = str
		document.body.appendChild(copy_from)
		copy_from.select()
		document.execCommand('copy')
		copy_from.blur()
		document.body.removeChild(copy_from)

browser.pageAction.onClicked.addListener (tab) ->
	{ board, card } =
		await browser.tabs.sendMessage(
			tab.id
			'get_card'
		)
	markdown_link = "[Trello: _#{board.name}_ - _#{card.name}_](#{card.url})"
	copy_to_clipboard(markdown_link)

if browser.declarativeContent?
	browser.runtime.onInstalled.addListener ->
		browser.declarativeContent.onPageChanged.removeRules(
			undefined,
			->
				browser.declarativeContent.onPageChanged.addRules(
					[
						{
							conditions: [
								new browser.declarativeContent.PageStateMatcher(
									pageUrl:
										hostEquals: 'trello.com'
								)
							]
							actions: [
								new browser.declarativeContent.ShowPageAction()
							]
						}
					]
				)
		)
