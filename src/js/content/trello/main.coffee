browser.runtime.onMessage.addListener (message) ->
	switch message
		when 'get_card'
			path = window.location.pathname
			if !/^\/c\/[^\/]+/.test(path)
				path = document.querySelector('.list-card.active-card').pathname

			card_id = path.match(/^\/c\/[^\/]+/)[0].replace(/^\/c\//, '')

			card_resp =
				await fetch(
					"#{window.location.origin}/1/cards/#{encodeURIComponent(card_id)}"
				)
			card = await card_resp.json()

			board_resp =
				await fetch(
					"#{window.location.origin}/1/boards/#{encodeURIComponent(card.idBoard)}"
				)
			board = await board_resp.json()

			card: card
			board: board
