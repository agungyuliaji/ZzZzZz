json.array! @records do |record|
  json.id record.id
  json.clock_in_time record.clock_in_time
  json.clock_out_time record.clock_out_time
  json.duration record.duration
  json.created_at record.created_at
  json.updated_at record.updated_at
  json.user record.user
end