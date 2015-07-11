YAML_FILE = "#{PROJECT_PATH}/lib/info.yaml"

def last_update_date
  YAML::load_file(YAML_FILE)['last_update']
end

def update_info
  a = Mechanize.new
  a.get('https://www.dropbox.com/home') do |page|

    puts page

  end
end

def read_from_file
  info = YAML::load_file YAML_FILE
  info.map { |key,value| INFO[key] = value }
end

def write_to_file
  File.open(YAML_FILE, "w") do |file|
    file << INFO.to_yaml
  end
end
