extends Node

# Replace with your codes
const PUBLIC_CODE = "68b260b38f40bb12e07873b8"
const PRIVATE_CODE = "_Eenl1pefk2PfvJJm-cBkgkZZcbaarBESF6CZ1p0O3jg"
const USE_HTTPS:bool = true

var http_request: HTTPRequest

signal scores_fetched(entries)


func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)

# Submit score
func submit_score(player_name: String, score: int):
	var protocol = "https" if USE_HTTPS else  "http"
	var url = "%s://dreamlo.com/lb/%s/pipe-add/%s/%d" % [protocol, PRIVATE_CODE, player_name, score]
	http_request.request(url)

# Fetch top N scores
func fetch_scores(top_n: int = 10):
	var protocol = "https" if USE_HTTPS else  "http"
	var url = "%s://dreamlo.com/lb/%s/pipe-get/0/%d" % [protocol, PUBLIC_CODE, top_n]
	http_request.request(url)

# Callback for all HTTP requests
func _on_request_completed(result, response_code, headers, body):
	if response_code != 200:
		push_error("Dreamlo request failed: %s" % response_code)
		return

	var text = body.get_string_from_utf8()
	# Determine context: you could have a state machine or track last requested type
	_parse_leaderboard(text)

# Simple parser for pipe-delimited format
func _parse_leaderboard(pipe_text: String) -> Array:
	var entries = []
	for line in pipe_text.split("\n", false):
		if line == "":
			continue
		var parts = line.split("|")
		if parts.size() >= 3:
			var rank = parts[0]
			var name = parts[1]
			var score = parts[2].to_int()
			entries.append({"rank": rank, "name": name, "score": score})
	return entries
	emit_signal("scores_fetched", entries)
