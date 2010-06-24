def be_hash_including(arg)
  if arg.is_a?(Hash)
    simple_matcher('a hash including %s' % arg.inspect) do |given|
      arg.to_a.reject do |key, value|
        given[key] == value
      end.empty?
    end
  else
    simple_matcher('a hash having the key %s' % arg) do |given|
      given.has_key?(arg)
    end
  end
end