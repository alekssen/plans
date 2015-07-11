
$check_key_existence = lambda {
  err_msg 'no such key' if !INFO[$hash].has_key? $key.to_sym
}

$check_hash_existence = lambda {
  err_msg 'no such hash' if !HASHES.include? $hash
}

def before_action
  system "clear"
  read_from_file
  INFO.map { |key, value| HASHES << key.to_s }
end

def action
  err_msg 'too much arguments' if ARGV.count > 3

  $hash = ARGV[1]
  $key = ARGV[2]
  $value = ARGV[2]

  which_action
end

def which_action
  if ARGV[0] == '-d' then delete
  elsif ARGV[0] == '-a' then add
  elsif ARGV[0] == '-r' then rename
  elsif ARGV[0] == '-h' then help
  elsif HASHES.include?(ARGV[0]) then print_hash_info
  else print_all_info
  end
end

def rename
  $check_hash_existence.call
  $key.nil? ? rename_hash : rename_plan
end

def rename_hash
  INFO[get_name] = INFO[$hash]
  delete_hash
end

def rename_plan
  $check_key_existence.call
  INFO[$hash][$key.to_sym] = get_name
  print_hash_info

end

def get_name
  print_hash_info
  puts 'new name:'
  new_name = STDIN.gets.chomp
  abort('exit status') if new_name == 'x'
  err_msg 'empty name' if new_name.empty?
  new_name
end

def delete
  $check_hash_existence.call
  $key.nil? ? delete_hash : delete_plan
end

def delete_hash
  INFO.delete $hash
  print_all_info
end

def delete_plan
  $check_key_existence.call
  INFO[$hash].delete $key.to_sym
  print_hash_info
end

def add
  err_msg 'empty hash' if $hash.nil?
  HASHES.include?($hash) ? add_plan : add_hash
end

def add_hash
  INFO[$hash] = {}
  add_plan if !$value.nil?
  print_all_info
end

def add_plan
  err_msg 'empty key' if $value.nil?

  new_key = INFO[$hash].count
  INFO[$hash]["#{new_key}".to_sym] = $value
  print_hash_info
end

def after_action
  write_to_file
end
