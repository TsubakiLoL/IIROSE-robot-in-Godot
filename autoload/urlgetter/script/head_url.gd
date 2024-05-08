extends HTTPRequest
class_name self_url
var res:PackedByteArray
var is_success:bool=false
func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	res=body
	if result==self.RESULT_SUCCESS:
		is_success=true
	else:
		is_success=false
	pass # Replace with function body.
func get_data()->PackedByteArray:
	return res
