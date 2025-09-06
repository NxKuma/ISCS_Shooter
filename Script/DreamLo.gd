extends Node

# Replace with your codes
const PUBLIC_CODE = "68b260b38f40bb12e07873b8"
const PRIVATE_CODE = "_Eenl1pefk2PfvJJm-cBkgkZZcbaarBESF6CZ1p0O3jg"
const USE_HTTPS:bool = false
var _expecting_json: bool = false

var http_request: HTTPRequest
var request_queue: Array = []
var busy := false

signal scores_fetched(entries: Array)

func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)

func queue_request(url: String):
	request_queue.append(url)
	_process_next()

func _process_next():
	if busy or request_queue.is_empty():
		return
	var url = request_queue.pop_front()
	busy = true
	print("Sending request: ", url)
	http_request.request(url)

# Submit score
func submit_score(player_name: String, score: int):
	var protocol = "https" if USE_HTTPS else  "http"
	var url = "%s://dreamlo.com/lb/%s/add/%s/%d" % [protocol, PRIVATE_CODE, player_name, score]
	queue_request(url)

# Fetch top N scores
func fetch_scores(top_n: int = 10):
	var protocol = "https" if USE_HTTPS else  "http"
	var url = "%s://dreamlo.com/lb/%s/json" % [protocol, PUBLIC_CODE]
	queue_request(url)


# Callback for all HTTP requests
func _on_request_completed(result, response_code, headers, body):
	if response_code != 200:
		push_error("Dreamlo request failed: %s" % response_code)
		return
		
	var text = body.get_string_from_utf8()
	# Determine context: you could have a state machine or track last requested type
	if (text != "OK"):
		_parse_json_leaderboard(text)
	busy = false
	_process_next()

# Simple parser for pipe-delimited format
func _parse_json_leaderboard(json: String):
	print("Loading Leaderboard")
	var parsed = JSON.parse_string(json)
	
	var entries = []
	if parsed.has("dreamlo") and parsed["dreamlo"].has("leaderboard") and parsed["dreamlo"]["leaderboard"].has("entry"):
		for e in parsed["dreamlo"]["leaderboard"]["entry"]:
			var name = e.get("name", "")
			var score = int(e.get("score", 0))
			entries.append({"name": name, "score": score})
	emit_signal("scores_fetched", entries)
