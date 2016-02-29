class String
  def json
    JSON.parse File.read("spec/assets/#{self}.json").strip, symbolize_names: true
  end

  def body
    self.json.to_json
  end
end
